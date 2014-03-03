package Models
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Interfaces.IInputHandling;

	public class Player2InputModel implements IInputHandling
	{
		private var moveForward:Boolean = false;
		private var moveReverse:Boolean = false;
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var fireWeapon:Boolean = false;
		
		public function Player2InputModel() 
		{
		}
		public function keyPressed(event:KeyboardEvent):void
		{	
			switch(event.keyCode)
			{
				case Keyboard.UP:
				{
					moveForward = true;
					break;
				}
				case Keyboard.DOWN:
				{
					moveReverse = true;
					break;
				}
				case Keyboard.LEFT:
				{
					moveLeft = true;
					break;
				}
				case Keyboard.RIGHT:
				{
					moveRight = true;
					break;
				}
				case Keyboard.O:
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
				case Keyboard.UP:
				{
					moveForward = false;
					break;
				}
				case Keyboard.DOWN:
				{
					moveReverse = false;
					break;
				}
				case Keyboard.LEFT:
				{
					moveLeft = false;
					break;
				}
				case Keyboard.RIGHT:
				{
					moveRight = false;
					break;
				}
				case Keyboard.O:
				{
					fireWeapon = false;
					break;
				}
			}	
		}
		public function getMoveForward():Boolean
		{
			return moveForward;
		}
		public function getMoveReverse():Boolean
		{
			return moveReverse;
		}
		public function getMoveLeft():Boolean
		{
			return moveLeft;
		}
		public function getMoveRight():Boolean
		{
			return moveRight;
		}
		public function getFireWeapon():Boolean
		{
			return fireWeapon;
		}
	}
}