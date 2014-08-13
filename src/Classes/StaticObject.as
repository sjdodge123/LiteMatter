package Classes
{
	import flash.geom.Point;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IStaticMethods;
	import Interfaces.IStaticPhysicsModel;

	public class StaticObject extends GameObject implements IStaticMethods
	{
		private var position:Point;
		private var hitCircle:GameObject;
		private var physicsModel:IStaticPhysicsModel;
		private var collisionModel:ICollisionModel;
		private var radius:Number;
		
		public function StaticObject(x:int, y:int,radius:Number,collisionModel:ICollisionModel,physicsModel:IStaticPhysicsModel)
		{
			this.x = x;
			this.y = y;
			this.radius = radius;
			this.collisionModel = collisionModel;
			this.physicsModel = physicsModel;
			hitCircle = this.collisionModel.buildModel(this);
			position = new Point(this.x, this.y);
		}
		
		public function getGravityConst():Number
		{
			return physicsModel.getGravityConst();
		}
		public function getRadius():Number
		{
			return radius;
		}
		public function getPosition():Point
		{
			return position;
		}
		override public function getHitArea():GameObject
		{
			return hitCircle;
		}
	}
}