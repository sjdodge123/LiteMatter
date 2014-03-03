package Models
{
	import Classes.CollisionBuilder;
	import Classes.CollisionEngine;
	import Classes.GameObject;
	
	import Interfaces.ICollisionModel;

	public class ShipCollisionModel implements ICollisionModel
	{
		public var objHitBox:GameObject;
		
		private var collisionBuilder:CollisionBuilder;
		private var collisionEngine:CollisionEngine;
		
		private var bodyHitBox:GameObject;
		private var leftWingHitBox:GameObject;
		private var rightWingHitBox:GameObject;
		private var boxArray:Array;
		
		public function ShipCollisionModel()
		{
			collisionBuilder = new CollisionBuilder();
			collisionEngine = new CollisionEngine
			boxArray = new Array();
		}
		public function buildModel(obj:GameObject):void
		{
			objHitBox = collisionBuilder.createHitBox(obj,0,0,0,0,0);
			bodyHitBox = collisionBuilder.createHitBox(objHitBox,-71/2,-11,65,23,1);
			leftWingHitBox = collisionBuilder.createHitBox(objHitBox, -20,-19,18,10,1);
			rightWingHitBox = collisionBuilder.createHitBox(objHitBox,-20,11,18,10,1);

			boxArray.push(bodyHitBox);
			boxArray.push(leftWingHitBox);
			boxArray.push(rightWingHitBox);
		}
		public function checkHit(obj:GameObject):Boolean
		{
			if(collisionEngine.testGeneralCollision(objHitBox,obj,boxArray))
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