package Interfaces
{
	import Classes.GameObject;

	public interface IDynamicObjects extends IGameObject
	{
		function buildModel():void;
		function checkHitDyn(objectArray:Vector.<GameObject>):Boolean;
		function changeVelX(value:Number):void;
		function changeVelY(value:Number):void;
	}
}