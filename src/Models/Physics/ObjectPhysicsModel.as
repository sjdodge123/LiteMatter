package Models.Physics
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import Interfaces.IInputHandling;
	import Interfaces.IPhysicsModel;
	import Interfaces.IStaticMethods;
	
	public class ObjectPhysicsModel extends EventDispatcher implements IPhysicsModel
	{
		private var returnInfo:Vector.<Number>;
		private var gameStage:Stage;
		protected var staticArray:Array;
		protected var positionX:Number = 0;
		protected var positionY:Number = 0;
		protected var rotationZ:Number = 0;
		protected var width:Number = 0;
		protected var height:Number = 0;
		protected var velX:Number = 0;
		protected var velY:Number = 0;
		protected var velocity:Number = 0;
		protected var rotRate:Number = 0;
		protected var rotAngle:Number = 0;
		protected var distX:Number = 0;
		protected var distY:Number = 0;
		protected var dist:Number = 0;
		protected var gravAccelContribution: Number = 0;
		protected var gravAccelX:Number = 0;
		protected var gravAccelY:Number = 0;
		
		
		public function ObjectPhysicsModel(stage:Stage)
		{
			this.gameStage = stage;
		}
		public function buildModel(staticArray:Array,width:Number,height:Number,initialX:Number,initialY:Number,rotationZ:Number,inputModel:IInputHandling):void
		{
			this.staticArray = staticArray;
			this.width = width;
			this.height = height;
			positionX = initialX;
			positionY = initialY;
			this.rotationZ = rotationZ;
		}
		
		public function update(deltaT:Number):Vector.<Number>
		{
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			updateRotation(deltaT);
			checkScreenBounds();
			returnInfo = new Vector.<Number>;
			returnInfo.push(positionX);
			returnInfo.push(positionY);
			returnInfo.push(rotationZ);
			return returnInfo;
		}
		
		protected function calculateGravity():void
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
		protected function updateVelocity(deltaT:Number):void
		{
			velX += gravAccelX*deltaT;
			velY += gravAccelY*deltaT;
			velocity = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
			gravAccelX = 0;
			gravAccelY = 0;
		}
		protected function updatePosition(deltaT:Number):void
		{
			positionX += velX*deltaT;
			positionY += velY*deltaT;
		}
		protected function updateRotation(deltaT:Number):void
		{
			rotationZ += rotRate*deltaT;
		}
		protected function checkScreenBounds():void
		{
			if (positionX > gameStage.stageWidth + width/2)
			{
				positionX = -width/2;
			}
			if (positionX < width/2)
			{
				positionX = gameStage.stageWidth + width/2;
			}
			if (positionY >  gameStage.stageHeight + height/2)
			{
				positionY = -height/2;
			}
			if (positionY < -height/2)
			{
				positionY = gameStage.stageHeight + height/2;
			}
		}
		protected function calcDist(point:Point):void
		{
			distX = point.x - positionX;
			distY = point.y - positionY;
			dist = Math.sqrt(Math.pow(distX,2)+Math.pow(distY,2));
		}
		protected function calcGravAccel(staticObj:IStaticMethods):void
		{
			gravAccelContribution = staticObj.getGravityConst()/Math.pow(dist,2);
			gravAccelX += gravAccelContribution*distX/dist;
			gravAccelY += gravAccelContribution*distY/dist;
		}
		
		public function resetPhysics(x:Number,y:Number,z:Number):void
		{
			//TODO resetPhysics
		}
		public function changeVelX(value:Number):void
		{
			velX = value;
		}
		public function changeVelY(value:Number):void
		{
			velY = value;
		}
		public function getVelX():Number
		{
			return velX;
		}
		public function getVelY():Number
		{
			return velY;
		}
		public function getDirX():Number
		{
			return null;
		}
		public function getDirY():Number
		{
			return null;
		}
	}
}