package Classes
{
	import flash.geom.Point;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IStaticMethods;

	public class StaticObject extends GameObject implements IStaticMethods
	{
		private var position:Point;
		private var collisionModel:ICollisionModel;
		private const gravConst:Number = 2600000;
//		private const gravConst:Number = 0;
		private var hitCircle:GameObject;
		
		public function StaticObject(x:int, y:int,collisionModel)
		{
			this.x = x;
			this.y = y;
			this.collisionModel = collisionModel;
			hitCircle = this.collisionModel.buildModel(this);
			position = new Point(this.x, this.y);
		}
		
		public function getGravityConst():Number
		{
			return gravConst;
		}
		public function getPosition():Point
		{
			return position;
		}
		public function getHitArea():GameObject
		{
			return hitCircle;
		}
	}
}