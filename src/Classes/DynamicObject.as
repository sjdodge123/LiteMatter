package Classes
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.Sound;
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IDynamicObjects;
	import Interfaces.IStaticMethods;

	public class DynamicObject extends GameObject implements IDynamicObjects
	{
		public var velX:Number = 0;
		public var velY:Number = 0;
		public var velocity:Number = 0;
		public var rotRate:Number = 0;
		public var rotAngle:Number = 0;
		
		protected var gravAccelContribution: Number;
		protected var gravAccelX:Number = 0;
		protected var gravAccelY:Number = 0;

		protected var distX:Number = 0;
		protected var distY:Number = 0;
		protected var dist:Number = 0;
		
		private var owner:PlayerObject;
		
		private var gameBoard:GameBoardObjects;
		private var collisionModel:ICollisionModel;
		private var collisionPoint:Point;
		private var objHitBox:GameObject;
		protected var staticArray:Array;
		protected var explodeSound:Sound;
		
		public function DynamicObject(staticArray:Array,gameBoard:GameBoardObjects,collisionModel:ICollisionModel,initialX:int,initialY:int)
		{	
			this.staticArray = new Array();
			this.gameBoard = gameBoard;
			this.staticArray = staticArray;
			this.collisionModel = collisionModel;
			x = initialX;
			y = initialY;
			explodeSound = gameBoard.soundLoader.loadSound("./Sounds/explode.mp3");
			buildModel();
		}
		public function buildModel():void
		{
			objHitBox = collisionModel.buildModel(this);
		}
		public function update(deltaT:Number):void
		{
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			updateRotation(deltaT);
			checkScreenBounds();
			if(checkHitStatic())
			{
				explode();
			}
			checkHitDyn(gameBoard.objectArray);
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
		public function calculateGravity():void
		{
			for(var i:int=0;i<staticArray.length;i++)
			{
				calcDist(staticArray[i].getPosition());
				if(dist>83.5)
				{
					calcGravAccel(staticArray[i]);
				}
			}
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
		public function calcDist(point:Point):void
		{
			distX = point.x - this.x;
			distY = point.y - this.y;
			dist = Math.sqrt(Math.pow(distX,2)+Math.pow(distY,2));
		}
		public function calcGravAccel(staticObj:IStaticMethods):void
		{
			gravAccelContribution = staticObj.getGravityConst()/Math.pow(dist,2);
			
			gravAccelX += gravAccelContribution*distX/dist;
			gravAccelY += gravAccelContribution*distY/dist;
		}
		public function updateVelocity(deltaT:Number):void
		{
			velX += gravAccelX*deltaT;
			velY += gravAccelY*deltaT;
			velocity = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
			gravAccelX = 0;
			gravAccelY = 0;
		}
		public function updateRotation(deltaT:Number):void
		{
			rotationZ += rotRate*deltaT;
		}
		public function updatePosition(deltaT:Number):void
		{
			this.x += velX*deltaT;
			this.y += velY*deltaT;
		}
		public function checkScreenBounds():void 
		{	
			if (x > gameBoard.stageWidth + this.width/2)
			{
				x = -this.width/2;
			}
			if (x < -this.width/2)
			{
				x = gameBoard.stageWidth + this.width/2;
			}
			if (y >  gameBoard.stageHeight + this.height/2)
			{
				y = -this.height/2;
			}
			if (y < -this.height/2)
			{
				y = gameBoard.stageHeight + this.height/2;
			}
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