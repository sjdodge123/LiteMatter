package Classes
{
	import flash.geom.Point;
	
	import Interfaces.IStaticMethods;

	public class StaticObject extends GameObject implements IStaticMethods
	{
		public var position:Point;
		
		
		public function StaticObject(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			position = new Point(this.x, this.y);
		}
		public function updateGravity():void
		{
//			for all i in gameboardobjects
//				if [i].type = static
//					calcDist(i);
//					gravAccel(i);
			
			
		}
		public function calcDist():void
		{
//			[i].distX = x - [i].x;
//			same for y
//			dist = sqrt(distX^2+distY^2)
			
		}
		public function gravAccel():void
		{
//			gravAccelContribution = gravConst/dist^2;
//			gravAccel += gravAccelContribution;
		}
	}
}