package Interfaces
{
	import flash.geom.Point;

	public interface IStaticMethods extends IGameObject
	{
		function getGravityConst():Number
		function getPosition():Point
		function getRadius():Number;
	}
}