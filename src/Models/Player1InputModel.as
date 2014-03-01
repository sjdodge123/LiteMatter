package Models
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import Interfaces.IInputHandling;

	public class Player1InputModel implements IInputHandling
	{
		public var moveForward:Boolean = false;
		public var moveReverse:Boolean = false;
		public var moveLeft:Boolean = false;
		public var moveRight:Boolean = false;
		public var fireWeapon:Boolean = false;
		
		public function Player1InputModel() 
		{
		}
		public function keyPressed(event:KeyboardEvent):void
		{	
			switch(event.keyCode)
			{
				case Keyboard.W:
				{
					moveForward = true;
					break;
				}
				case Keyboard.S:
				{
					moveReverse = true;
					break;
				}
				case Keyboard.A:
				{
					moveLeft = true;
					break;
				}
				case Keyboard.D:
				{
					moveRight = true;
					break;
				}
				case Keyboard.SPACE:
				{
					fireWeapon = true;
					break;
				}
			}
		}
		public function keyReleased(event:KeyboardEvent):void
		{
			switch(event.keyCode)
				
			{	
				case Keyboard.W:
				{
					moveForward = false;
					break;
				}
				case Keyboard.S:
				{
					moveReverse = false;
					break;
				}
				case Keyboard.A:
				{
					moveLeft = false;
					break;
				}
				case Keyboard.D:
				{
					moveRight = false;
					break;
				}
				case Keyboard.SPACE:
				{
					fireWeapon = false;
					break;
				}
			}
		}
	}
}