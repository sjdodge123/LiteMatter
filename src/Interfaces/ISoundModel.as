package Interfaces 
{
	import Events.EFireCannon;
	import flash.display.DisplayObject;
	import flash.events.Event;

	public interface ISoundModel 
	{
		function buildModel(lderCont:DisplayObject):void;
		function update(event:Event):void;
	}
	
}