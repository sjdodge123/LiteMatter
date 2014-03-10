package Models.Input
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
		private var fireWeaponOne:Boolean = false;
		private var fireWeaponTwo:Boolean = false;
		
		public function Player2InputModel() 
		{
		}
		public function keyPressed(event:KeyboardEvent):void
		{	
			switch(event.keyCode)
			{
				case Keyboard.I:
				{
					moveForward = true;
					break;
				}
				case Keyboard.K:
				{
					moveReverse = true;
					break;
				}
				case Keyboard.J:
				{
					moveLeft = true;
					break;
				}
				case Keyboard.L:
				{
					moveRight = true;
					break;
				}
				case Keyboard.U:
				{
					fireWeaponOne = true;
					break;
				}
				case Keyboard.O:
				{
					fireWeaponTwo = true;
					break;
				}
			}
		}
		public function keyReleased(event:KeyboardEvent):void
		{
			switch(event.keyCode)
				
			{	
				case Keyboard.I:
				{
					moveForward = false;
					break;
				}
				case Keyboard.K:
				{
					moveReverse = false;
					break;
				}
				case Keyboard.J:
				{
					moveLeft = false;
					break;
				}
				case Keyboard.L:
				{
					moveRight = false;
					break;
				}
				case Keyboard.U:
				{
					fireWeaponOne = false;
					break;
				}
				case Keyboard.O:
				{
					fireWeaponTwo = false;
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
		public function getFireWeaponOne():Boolean
		{
			return fireWeaponOne;
		}
		public function getFireWeaponTwo():Boolean
		{
			return fireWeaponTwo;
		}
	}
}