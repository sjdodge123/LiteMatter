package Classes
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.Sound;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Events.GameBoardEvent;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IDynamicObjects;
	import Interfaces.IPhysicsModel;
	
	import Loaders.SoundLoader;

	public class BasicObject extends GameObject implements IDynamicObjects
	{
		
		private var owner:PlayerObject;
		private var collisionModel:ICollisionModel;
		private var physicsModel:IPhysicsModel;
		private var collisionPoint:Point;
		private var objHitBox:GameObject;
		private var positionInfo:Vector.<Number>;
		protected var explodeSound:Sound;
		private var soundLoader:SoundLoader;
		
		public function BasicObject(collisionModel:ICollisionModel,physicsModel:IPhysicsModel,initialX:int,initialY:int)
		{	
			this.collisionModel = collisionModel;
			this.physicsModel = physicsModel;
			this.width = width;
			this.height = height;
			soundLoader = new SoundLoader();
			x = initialX;
			y = initialY;
			explodeSound = soundLoader.loadSound("./Sounds/explode.mp3");
			buildModel();
		}
		public function buildModel():void
		{
			objHitBox = collisionModel.buildModel(this);
			physicsModel.buildModel(width,height,x,y,rotationZ,null);
		}
		override public function update(deltaT:Number,staticObjects:Vector.<StaticObject>,gameObjects:Vector.<GameObject>):void
		{
			updatePhysics(deltaT,staticObjects);
			if(checkHitStatic(staticObjects))
			{
				explode();
			}
			checkHitDyn(gameObjects);
		}
		
		private function updatePhysics(deltaT:Number,staticObjects:Vector.<StaticObject>):void
		{
			positionInfo = physicsModel.update(deltaT,staticObjects);
			x = positionInfo[0];
			y = positionInfo[1];
			rotationZ = positionInfo[2];
		}
		public function checkHitStatic(staticObjects:Vector.<StaticObject>):Boolean
		{
			for(var i:int=0;i<staticObjects.length;i++)
			{
				if (collisionModel.checkHit(staticObjects[i]))
				{
					return true
				}
			}
			return false;
		}
		public function checkHitDyn(objectArray:Vector.<GameObject>):Boolean
		{
			for(var i:int=0;i<objectArray.length;i++)
			{
				if(objectArray[i] != this && collisionModel.checkHit(objectArray[i]))
				{
					if (objectArray[i].getImmuneStatus() == false)
					{
						if (objectArray[i].isPlayer()) 
						{
							owner.recordHit(objectArray[i] as PlayerObject);
							var currentHP:int = objectArray[i].takeAwayHP(25);
							if (currentHP <= 0) 
							{
								owner.recordKill(objectArray[i] as PlayerObject);
								objectArray[i].explode();
							}	
						}
						else 
						{
							objectArray[i].explode();
						}
						explode();
						return true;
					}
				}
			}
			return false;
		}
		public function explode():void
		{	
			dispatchEvent(new GameBoardEvent(GameBoardEvent.EXPLODE,this));
			explodeSound.play();
			dispatchEvent(new GameBoardEvent(GameBoardEvent.REMOVE,this));
		}
		
		public function changeVelX(value:Number):void
		{
			physicsModel.changeVelX(value);
		}
		public function changeVelY(value:Number):void
		{
			physicsModel.changeVelY(value);
		}
		public function respawn():void
		{
			
		}
		public function setCollisionPoint(collisionPoint:Point):void
		{
			this.collisionPoint = new Point(collisionPoint.x,collisionPoint.y);
		}
		
		public function getImmuneStatus():Boolean 
		{
			return false;
		}
		
		override public function getHitArea():GameObject
		{
			return objHitBox;
		}
		public function isPlayer():Boolean
		{
			return false;
		}
		public function setOwner(owner:PlayerObject):void 
		{
			this.owner = owner;
		}
		override public function getScale():Number
		{
			return .15
		}
		
		public function getOwner(bullet:BasicObject):PlayerObject
		{
			return owner;
		}
		
	}
	
}