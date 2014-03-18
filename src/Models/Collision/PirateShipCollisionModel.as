package Models.Collision 
{
	import flash.geom.Point;
	import Classes.GameObject;
	import Interfaces.ICollisionModel;
	import Classes.CollisionBuilder;
	import Classes.CollisionEngine;
	
	/**
	 * ...
	 * @author Jake
	 */
	public class PirateShipCollisionModel implements ICollisionModel 
	{
		private var collisionPoint:Point;
		private var collisionBuilder:CollisionBuilder;
		private var collisionEngine:CollisionEngine;
		private var boxArray:Array;
		public var objHitBox:GameObject;
		private var bodyHitBox:GameObject;
		private var noseHitBox:GameObject;
		private var bowHitBox:GameObject;
		private var aftHitBox:GameObject;
		private var poopHitBox:GameObject;
		private var mastHitBox:GameObject;
		
		public function PirateShipCollisionModel() 
		{
			collisionBuilder = new CollisionBuilder();
			collisionEngine = new CollisionEngine();
			boxArray = new Array();
		}
		
		public function buildModel(obj:GameObject):GameObject 
		{
			objHitBox = collisionBuilder.createHitBox(obj, 0, 0, 0, 0, 0);
			bodyHitBox = collisionBuilder.createHitBox(objHitBox, -17, -11, 55, 23, 0);
			noseHitBox = collisionBuilder.createHitBox(objHitBox, 39, -5, 6, 11, 0);
			bowHitBox = collisionBuilder.createHitBox(objHitBox, 45, -1, 11, 3, 0);
			aftHitBox = collisionBuilder.createHitBox(objHitBox, -45, -7.5, 8, 15, 0);
			poopHitBox = collisionBuilder.createHitBox(objHitBox, -37, -16, 15, 32, 0);
			mastHitBox = collisionBuilder.createHitBox(objHitBox, 0, -22, 3, 44, 0);
			
			boxArray.push(bodyHitBox);
			boxArray.push(noseHitBox);
			boxArray.push(bowHitBox);
			boxArray.push(aftHitBox);
			boxArray.push(poopHitBox);
			boxArray.push(mastHitBox);
			return objHitBox;
		}
		
		public function checkHit(obj:GameObject):Boolean 
		{
			if(collisionEngine.testGeneralCollision(objHitBox,obj,boxArray))
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