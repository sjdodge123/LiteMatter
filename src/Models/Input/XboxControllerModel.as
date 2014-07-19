package Models.Input 
{
	import flash.events.Event;
	import flash.ui.GameInputDevice;
	import flash.ui.GameInputControl;
	import Interfaces.IInputHandling;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Jake
	 */
	public class XboxControllerModel implements IInputHandling 
	{
		private var moveForward:Boolean = false;
		private var moveReverse:Boolean = false;
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var fireWeaponOne:Boolean = false;
		private var fireWeaponTwo:Boolean = false;
		private var device:GameInputDevice;
		private var gameStage:Stage;
		private var leftThumb:GameInputControl;
		private var aButton:GameInputControl;
		private var bButton:GameInputControl;
		private var rightTrig:GameInputControl;
		private var leftTrig:GameInputControl;
		private var defaultValue:Number;
		
		public function XboxControllerModel(gameStage:Stage,device:GameInputDevice) 
		{
			this.gameStage = gameStage;
			this.device = device;
			device.enabled = true;
			leftThumb = device.getControlAt(0);
			leftThumb.addEventListener(Event.CHANGE, thumbMoved);
			aButton = device.getControlAt(4);
			aButton.addEventListener(Event.CHANGE, aPressed);
			bButton = device.getControlAt(6);
			bButton.addEventListener(Event.CHANGE, bPressed);
			leftTrig = device.getControlAt(10);
			leftTrig.addEventListener(Event.CHANGE,leftTrigPressed);
			rightTrig = device.getControlAt(11);
			rightTrig.addEventListener(Event.CHANGE, rightTrigPressed);
		}
		private function thumbMoved(event:Event):void
		{
			defaultValue = leftThumb.value;
			switch(true) 
			{
				case (leftThumb.value == 1): 
				{
					moveRight = true;
					break;
				}
				case  leftThumb.value == -1:
				{
					moveLeft = true;
					break;
				}
				case  leftThumb.value == defaultValue: 
				{
					moveLeft = false;
					moveRight = false;
					break;
				}
				
			}
		}
		
		private function aPressed(event:Event):void
		{
			switch(true) 
			{
				case aButton.value == 1: 
				{
					moveForward = true;
					break;
				}
				case aButton.value == 0: 
				{
					moveForward = false;
					break;
				}
			}
		}
		private function bPressed(event:Event):void
		{
			switch(true) 
			{
				case bButton.value == 1: 
				{
					moveReverse = true;
					break;
				}
				case bButton.value == 0: 
				{
					moveReverse = false;
					break;
				}
			}
		}
		private function rightTrigPressed(event:Event):void
		{
			switch(true) 
			{
				case rightTrig.value > 0: 
				{
					fireWeaponTwo = true;
					break;
				}
				case rightTrig.value == 0: 
				{
					fireWeaponTwo = false;
					break;
				}
			}
		}
		private function leftTrigPressed(event:Event):void
		{
			switch(true) 
			{
				case leftTrig.value > 0: 
				{
					fireWeaponOne = true;
					break;
				}
				case leftTrig.value == 0: 
				{
					fireWeaponOne = false;
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
		
		public function getInputType():int 
		{
			return 0;
		}
		
	}

}