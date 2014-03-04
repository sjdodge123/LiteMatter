package Models
{
	import Classes.CollisionBuilder;
	import Classes.CollisionEngine;
	import Classes.GameObject;
	
	import Interfaces.ICollisionModel;

	public class AsteriodCollisionModel implements ICollisionModel
	{
		private var collisionBuilder:CollisionBuilder;
		private var collisionEngine:CollisionEngine;
		private var hitCircle:GameObject;
		private var boxArray:Array;
		
		public function AsteriodCollisionModel()
		{
			collisionBuilder = new CollisionBuilder();
			collisionEngine = new CollisionEngine();
		}
		public function buildModel(obj:GameObject):void
		{
			hitCircle = collisionBuilder.createHitCircle(obj,0,0,10,1);	
		}
		public function checkHit(obj:GameObject):Boolean
		{
			if(collisionEngine.testGeneralCollision(hitCircle,obj,boxArray))
			{
				return true;
			}
			else
			{
				return false;	
			}
		}
	}
}