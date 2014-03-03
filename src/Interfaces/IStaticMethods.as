package Interfaces
{
	import flash.geom.Point;

	public interface IStaticMethods extends IObjectMethods
	{
		function updateGravity():void
		function getGravityConst():Number
		function getPosition():Point
	}
}