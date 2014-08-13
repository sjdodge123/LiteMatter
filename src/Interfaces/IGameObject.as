package Interfaces
{
	import Classes.GameObject;
	import Classes.StaticObject;
	

	public interface IGameObject
	{
		function getHitArea():GameObject;
		function getScale():Number;
		function update(deltaT:Number,staticObjects:Vector.<StaticObject>,gameObjects:Vector.<GameObject>):void
	}
}