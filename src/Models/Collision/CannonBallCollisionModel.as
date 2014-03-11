package Models.Collision
{
	import flash.geom.Point;
	
	import Classes.CollisionBuilder;
	import Classes.CollisionEngine;
	import Classes.GameObject;
	
	import Interfaces.ICollisionModel;

	public class CannonBallCollisionModel implements ICollisionModel
	{
		private var collisionBuilder:CollisionBuilder;
		private var collisionEngine:CollisionEngine;
		private var hitCircle:GameObject;
		private var boxArray:Array;
		private var collisionPoint:Point;
		
		public function CannonBallCollisionModel()
		{
			collisionBuilder = new CollisionBuilder();
			collisionEngine = new CollisionEngine();
		}
		public function buildModel(obj:GameObject):GameObject
		{
			hitCircle = collisionBuilder.createHitCircle(obj,0,0,5,0);
			return hitCircle;
		}
		public function checkHit(obj:GameObject):Boolean
		{
			if(collisionEngine.testGeneralCollision(hitCircle,obj,boxArray))
			{
				collisionPoint = new Point(collisionEngine.getCollisionPoint().x,collisionEngine.getCollisionPoint().y);
				return true;
			}
			else
			{
				return false;	
			}
		}
		public function getCollisionPoint():Point
		{
			return collisionPoint;
		}
		
	}
}