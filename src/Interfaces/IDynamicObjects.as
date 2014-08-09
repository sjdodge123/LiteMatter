package Interfaces
{
	public interface IDynamicObjects extends IObjectMethods
	{
		function buildModel():void;
		function update(deltaT:Number):void;
		function checkHitDyn(objectArray:Array):Boolean;
		function changeVelX(value:Number):void;
		function changeVelY(value:Number):void;
	}
}