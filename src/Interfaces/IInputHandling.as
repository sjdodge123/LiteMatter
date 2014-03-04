package Interfaces
{
	import flash.events.KeyboardEvent;

	public interface IInputHandling
	{
		function keyPressed(event:KeyboardEvent):void;
		function keyReleased(event:KeyboardEvent):void;
		function getMoveForward():Boolean
		function getMoveReverse():Boolean
		function getMoveLeft():Boolean
		function getMoveRight():Boolean
		function getFireWeaponOne():Boolean
		function getFireWeaponTwo():Boolean
	}
}