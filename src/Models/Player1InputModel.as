package Models
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import Interfaces.IInputHandling;

	public class Player1InputModel implements IInputHandling
	{
		private var moveForward:Boolean = false;
		private var moveReverse:Boolean = false;
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var fireWeapon:Boolean = false;
		
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