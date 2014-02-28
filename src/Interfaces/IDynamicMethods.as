package Interfaces
{
	public interface IDynamicMethods extends IObjectMethods
	{
		function update(deltaT:Number):void;
		function updateVelocity(deltaT:Number):void;
		function updatePosition(deltaT:Number):void;
		function checkScreenBounds():void;
	}
}