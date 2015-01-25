package Classes 
{
	import Events.UIEvent;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.GameInputControl;
	import flash.ui.GameInputDevice;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	public class IOMonitor extends GameObject
	{	
		private var deviceList:Vector.<GameInputDevice>;
		private var startButton:GameInputControl;
		private var aButton:GameInputControl;
		private var backButton:GameInputControl;
		public var currentDevice:GameInputDevice
		private var leftThumb:GameInputControl;
		private var defaultValue:Number;
		public function IOMonitor(gameStage:Stage) 
		{
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			deviceList = new Vector.<GameInputDevice>;
		}
		
		public function controllerAdded(device:GameInputDevice):void 
		{
			device.enabled = true;
			startButton = device.getControlAt(13);
			startButton.addEventListener(Event.CHANGE, startPressed);
			backButton = device.getControlAt(12);
			backButton.addEventListener(Event.CHANGE, backPressed);
			leftThumb = device.getControlAt(1);
			leftThumb.addEventListener(Event.CHANGE, thumbMoved);
			deviceList.push(device);
		}
		
		
		private function keyPressed(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.P:
				{
					dispatchEvent(new UIEvent(UIEvent.PAUSE_GAME, null));
					break;
				}
				case Keyboard.ESCAPE:
				{
					dispatchEvent(new UIEvent(UIEvent.PAUSE_GAME, null));
					break;
				}
				case Keyboard.R:
				{
					dispatchEvent(new UIEvent(UIEvent.RESET, null));
					break;
				}
				case Keyboard.ALTERNATE:
				{
					dispatchEvent(new UIEvent(UIEvent.FULL_SCREEN, null));
					break;
				}
				case Keyboard.M:
				{
					dispatchEvent(new UIEvent(UIEvent.MUTE_GAME, null));
					break;
				}
			}
			
		}
		private function startPressed(event:Event):void
		{
			currentDevice = event.target.device;
			if (event.target.value == 1) { dispatchEvent(new UIEvent(UIEvent.PAUSE_GAME, currentDevice)); }
		}
		private function backPressed(event:Event):void 
		{
			if (event.target.value == 1) { dispatchEvent(new UIEvent(UIEvent.RESET, null)); }
		}
		private function thumbMoved(event:Event):void
		{
			defaultValue = leftThumb.value;
			switch(true) 
			{
				case (leftThumb.value == 1): 
				{
					dispatchEvent(new UIEvent(UIEvent.UP, null))
					break;
				}
				case  (leftThumb.value == -1):
				{
					dispatchEvent(new UIEvent(UIEvent.DOWN, null))
					break;
				}
			}
		}
		
		
	}

}