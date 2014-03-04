package Models
{
	import flash.geom.Point;
	
	import Classes.CollisionBuilder;
	import Classes.GameObject;
	
	import Interfaces.ICollisionModel;

	public class PlanetCollisionModel implements ICollisionModel
	{
		private var collisionBuilder:CollisionBuilder;
		private var hitCircle:GameObject;
		private var collisionPoint:Point;
		public function PlanetCollisionModel()
		{
			collisionBuilder = new CollisionBuilder();
		}
		public function buildModel(obj:GameObject):GameObject
		{
			hitCircle = collisionBuilder.createHitCircle(obj,0,0,83.5,0);
			return hitCircle;
		}
		public function checkHit(obj:GameObject):Boolean
		{
			return false;
		}
		public function getHitBox():GameObject
		{
			return hitCircle;
		}
		public function getCollisionPoint():Point
		{
			return collisionPoint;
		}
		
	}
}