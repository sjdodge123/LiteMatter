package Classes
{
	import flash.geom.Point;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IStaticPhysicsModel;
	import Interfaces.IStaticMethods;

	public class StaticObject extends GameObject implements IStaticMethods
	{
		private var position:Point;
		
//		private const gravConst:Number = 0;
		private var hitCircle:GameObject;
		private var physicsModel:IStaticPhysicsModel;
		private var collisionModel:ICollisionModel;
		
		public function StaticObject(x:int, y:int,collisionModel:ICollisionModel,physicsModel:IStaticPhysicsModel)
		{
			this.x = x;
			this.y = y;
			this.collisionModel = collisionModel;
			this.physicsModel = physicsModel;
			hitCircle = this.collisionModel.buildModel(this);
			position = new Point(this.x, this.y);
		}
		
		public function getGravityConst():Number
		{
			return physicsModel.getGravityConst();
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