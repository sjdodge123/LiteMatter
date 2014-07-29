package Interfaces 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author Jake
	 */
	public interface IAnimationModel 
	{
		function buildModel(ldrCont:DisplayObject):void
		function update(event:Event):void;
	}

}