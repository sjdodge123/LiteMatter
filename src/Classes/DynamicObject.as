package Classes
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.Sound;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IDynamicObjects;
	import Interfaces.IPhysicsModel;

	public class DynamicObject extends GameObject implements IDynamicObjects
	{
		
		private var owner:PlayerObject;
		private var gameBoard:GameBoardObjects;
		private var collisionModel:ICollisionModel;
		private var physicsModel:IPhysicsModel;
		private var collisionPoint:Point;
		private var objHitBox:GameObject;
		private var positionInfo:Vector.<Number>;
		protected var staticArray:Array;
		protected var explodeSound:Sound;
		
		public function DynamicObject(staticArray:Array,gameBoard:GameBoardObjects,collisionModel:ICollisionModel,physicsModel:IPhysicsModel,initialX:int,initialY:int)
		{	
			this.staticArray = new Array();
			this.gameBoard = gameBoard;
			this.staticArray = staticArray;
			this.collisionModel = collisionModel;
			this.physicsModel = physicsModel;
			this.width = width;
			this.height = height;
			x = initialX;
			y = initialY;
			explodeSound = gameBoard.soundLoader.loadSound("./Sounds/explode.mp3");
			buildModel();
		}
		public function buildModel():void
		{
			objHitBox = collisionModel.buildModel(this);
			physicsModel.buildModel(staticArray,width,height,x,y,rotationZ,null);
		}
		public function update(deltaT:Number):void
		{
			updatePhysics(deltaT);
			if(checkHitStatic())
			{
				explode();
			}
			checkHitDyn(gameBoard.objectArray);
		}
		
		private function updatePhysics(deltaT:Number):void
		{
			positionInfo = physicsModel.update(deltaT);
			x = positionInfo[0];
			y = positionInfo[1];
			rotationZ = positionInfo[2];
		}
		public function checkHitStatic():Boolean
		{
			for(var i:int=0;i<staticArray.length;i++)
			{
				if (collisionModel.checkHit(staticArray[i]))
				{
					return true
				}
			}
			return false;
		}
		public function checkHitDyn(objectArray:Array):Boolean
		{
			for(var i:int=0;i<objectArray.length;i++)
			{
				if(objectArray[i] != this && collisionModel.checkHit(objectArray[i]))
				{
					if (objectArray[i].getImmuneStatus() == false)
					{
						if (objectArray[i].isPlayer()) 
						{
							owner.recordHit(objectArray[i]);
							var currentHP:int = objectArray[i].takeAwayHP(25);
							if (currentHP <= 0) 
							{
								owner.recordKill(objectArray[i]);
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
			var explosion:MovieClip = gameBoard.addExplosion(x, y,.15,.15);
			explodeSound.play();
			gameBoard.addChild(explosion);
			if (gameBoard.contains(this))
			{
				gameBoard.removeObject(this);
			}
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
		
		public function getOwner(bullet:DynamicObject):PlayerObject
		{
			return owner;
		}
		
	}
	
}