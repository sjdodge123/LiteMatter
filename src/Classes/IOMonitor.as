package Classes 
{
	import Events.GameState;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.GameInputControl;
	import flash.ui.GameInputDevice;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class IOMonitor extends GameObject
	{	
		private var deviceList:Vector.<GameInputDevice>;
		private var startButton:GameInputControl;
		private var aButton:GameInputControl;
		public var currentDevice:GameInputDevice
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
			aButton = device.getControlAt(4);
			aButton.addEventListener(Event.CHANGE, aPressed);
			deviceList.push(device);
		}
		
		private function keyPressed(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.P:
				{
					dispatchEvent(new GameState(GameState.PAUSE_GAME, null));
					break;
				}
				case Keyboard.R:
				{
					dispatchEvent(new GameState(GameState.RESET, null));
					break;
				}
				case Keyboard.ALTERNATE + Keyboard.ENTER:
				{
					dispatchEvent(new GameState(GameState.FULL_SCREEN, null));
					break;
				}
				case Keyboard.M:
				{
					dispatchEvent(new GameState(GameState.MUTE_GAME, null));
					break;
				}
			}
			
		}
		private function startPressed(event:Event):void
		{
			currentDevice = event.target.device;
			if (event.target.value == 1) { dispatchEvent(new GameState(GameState.PAUSE_GAME, currentDevice)); }
			
		}
		private function aPressed(event:Event):void 
		{
			if (event.target.value == 1) { dispatchEvent(new GameState(GameState.START_GAME, null)); }
		}
		
		
	}

}