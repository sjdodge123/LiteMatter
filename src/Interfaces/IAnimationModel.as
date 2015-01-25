package Interfaces 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author Jake
	 */
	public interface IAnimationModel extends IEventDispatcher
	{
		function buildModel(ldrCont:DisplayObject):void
		function update(event:Event):void;
	}

}