package Interfaces
{
	import flash.events.IEventDispatcher;
	
	import Classes.StaticObject;

	public interface IPhysicsModel extends IEventDispatcher
	{
		function buildModel(width:Number,height:Number,initialX:Number,initialY:Number,rotationZ:Number,inputModel:IInputHandling):void;
		function update(deltaT:Number,staticObjects:Vector.<StaticObject>):Vector.<Number>;
		function changeVelX(value:Number):void;
		function changeVelY(value:Number):void;
		function getVelX():Number;
		function getVelY():Number;
		function getDirX():Number;
		function getDirY():Number;
		function resetPhysics(x:Number,y:Number,z:Number):void;
	}
}