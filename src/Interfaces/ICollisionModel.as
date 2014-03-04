package Interfaces
{
	import flash.geom.Point;
	
	import Classes.GameObject;

	public interface ICollisionModel
	{
		function buildModel(obj:GameObject):GameObject;
		function checkHit(obj:GameObject):Boolean;
		function getCollisionPoint():Point;
	}
}