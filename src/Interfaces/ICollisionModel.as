package Interfaces
{
	import Classes.GameObject;

	public interface ICollisionModel
	{
		function buildModel(obj:GameObject):void
		function checkHit(obj:GameObject):Boolean
	}
}