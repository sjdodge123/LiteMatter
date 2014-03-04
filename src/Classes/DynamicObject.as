package Classes
{
	import flash.geom.Point;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IDynamicObjects;
	import Interfaces.IStaticMethods;
	import flash.display.DisplayObjectContainer;

	public class DynamicObject extends GameObject implements IDynamicObjects
	{
		public var velX:Number = 0;
		public var velY:Number = 0;
		public var velocity:Number = 0;
		public var rotRate:Number = 0;
		public var rotAngle:Number = 0;
		
		public var gravAccelContribution: Number;
		public var gravAccelX:Number = 0;
		public var gravAccelY:Number = 0;

		private var distX:Number = 0;
		private var distY:Number = 0;
		private var dist:Number = 0;
		
		private var gameBoard:GameBoardObjects;
		private var collisionModel:ICollisionModel;
		private var collisionPoint:Point;
		public var staticArray:Array;
		public var hit:Boolean;
		
		
		
		
		public function DynamicObject(staticArray:Array,gameBoard:GameBoardObjects,collisionModel:ICollisionModel)
		{	
			this.staticArray = new Array();
			this.gameBoard = gameBoard;
			this.staticArray = staticArray;
			this.collisionModel = collisionModel;
			buildModel();
			
		}
		public function buildModel():void
		{
			collisionModel.buildModel(this);
		}
		public function update(deltaT:Number):void
		{
			hit = checkHit();
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			updateRotation(deltaT);
			checkScreenBounds();
			
		}
		
		private function checkHit():Boolean
		{
			var value:Boolean = false;
			for(var i:int=0;i<staticArray.length;i++)
			{
				return collisionModel.checkHit(staticArray[i]);
			}		
			return value;
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
				if(hit)
				{
//					bounce();
					explode();
				}
			}
		}
		
		private function bounce():void
		{
			
		}
		
		private function explode():void
		{
			
			var explosion:GameObject = new GameObject();
			explosion.graphics.beginFill(0xFF0000,1);
			explosion.graphics.drawCircle(collisionModel.getCollisionPoint().x,collisionModel.getCollisionPoint().y,5);
			explosion.graphics.endFill();
			gameBoard.addChild(explosion);
			gameBoard.removeChild(this);
			
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
			if (x > 1240)
			{
				x = -40;
			}
			if (x < -40)
			{
				x = 1240;
			}
			if (y >  940)
			{
				y = -40;
			}
			if (y < -40)
			{
				y = 940;
			}
		}
		public function setCollisionPoint(collisionPoint:Point):void
		{
			this.collisionPoint = new Point(collisionPoint.x,collisionPoint.y);
		}
		
	}
	
}