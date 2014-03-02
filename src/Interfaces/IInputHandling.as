package Interfaces
{
	import flash.events.KeyboardEvent;

	public interface IInputHandling
	{
		function keyPressed(event:KeyboardEvent):void;
		function keyReleased(event:KeyboardEvent):void;
	}
}