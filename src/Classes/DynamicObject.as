package Classes
{
	import flash.geom.Point;
	
	import Interfaces.IDynamicMethods;

	public class DynamicObject extends GameObject implements IDynamicMethods
	{
		public var velX:Number = 0;
		public var velY:Number = 0;
		public var velocity:Number = 0;
		public var rotRate:Number = 0;
		public var rotAngle:Number = 0;
		
		public var gravConst:Number = 2600000;
		public var gravAccelContribution: Number;
		public var gravAccelX:Number = 0;
		public var gravAccelY:Number = 0;

		
		private var distX:Number = 0;
		private var distY:Number = 0;
		private var dist:Number = 0;
		
		public var pointArray:Array;
		
		
		public function DynamicObject(pointArray:Array)
		{	
			this.pointArray = new Array();
			this.pointArray = pointArray;
			
		}
		public function update(deltaT:Number):void
		{
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			checkScreenBounds();
		}
		public function calculateGravity():void
		{
			for(var i:int=0;i<pointArray.length;i++)
			{
				calcDist(pointArray[i]);
				calcGravAccel();
			}
		}
		public function calcDist(point:Point):void
		{
			distX = point.x - this.x;
			distY = point.y - this.y;
			dist = Math.sqrt(Math.pow(distX,2)+Math.pow(distY,2));
		}
		public function calcGravAccel():void
		{
			gravAccelContribution = gravConst/Math.pow(dist,2);
			
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
		
	}
	
}