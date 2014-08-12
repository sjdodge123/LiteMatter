package Interfaces
{
	import Classes.GameObject;
	

	public interface IGameObject
	{
		function getHitArea():GameObject;
		function update(deltaT:Number):void
	}
}