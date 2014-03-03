package Models
{
	import Classes.CollisionBuilder;
	import Classes.GameObject;
	
	import Interfaces.ICollisionModel;

	public class PlanetCollisionModel implements ICollisionModel
	{
		private var collisionBuilder:CollisionBuilder;
		private var hitCircle:GameObject;
		public function PlanetCollisionModel()
		{
			collisionBuilder = new CollisionBuilder();
		}
		public function buildModel(obj:GameObject):void
		{
			hitCircle = collisionBuilder.createHitCircle(obj,0,0,83.5,1);
		}
		public function checkHit(obj:GameObject):Boolean
		{
			return false;
		}
		public function getHitBox():GameObject
		{
			return hitCircle;
		}
	}
}