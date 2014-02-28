package Interfaces
{
	import Classes.DynamicObject;
	import Classes.StaticObject;
	import Classes.PlayerObject;

	public interface ICollisionObject
	{
		function testGeneralCollision(movingObj:DynamicObject,movingObjHitBoxName:String, staticObj:StaticObject, staticObjHitBoxName:String):Boolean;
		function testCollisionCheap(movingObj:DynamicObject, staticObj:StaticObject):Boolean;
		function testCollisionExp(movingObj:DynamicObject,movingObjHitBoxName:String, staticObj:StaticObject, staticObjHitBoxName:String):Boolean;
	}
}