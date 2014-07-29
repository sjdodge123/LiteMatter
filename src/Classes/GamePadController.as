package Classes 
{
	
	import flash.events.Event;
	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	import flash.ui.GameInputDevice;
	
	import Classes.UIHub;
	public class GamePadController 
	{
		private var gameInput:GameInput;
		private var uiHub:UIHub;
		private var device:GameInputDevice;
		private var numDevices:int;
		public function GamePadController(uiHub:UIHub) 
		{
			this.uiHub = uiHub;
			gameInput = new GameInput();
			gameInput.addEventListener(GameInputEvent.DEVICE_ADDED, controllerAdded);
			gameInput.addEventListener(GameInputEvent.DEVICE_REMOVED, controllerRemoved);
			gameInput.addEventListener(GameInputEvent.DEVICE_UNUSABLE, controllerUnusable);
		}
		private function controllerAdded(event:GameInputEvent):void 
		{
			uiHub.controllerAdded(event.device);
			uiHub.addControllerPopUpScreen(int(event.device.id.charAt(event.device.id.length-1)),event.device);
			numDevices += 1;
		}
		private function controllerRemoved(event:GameInputEvent):void 
		{
			uiHub.removeControllerPopUpScreen(numDevices,event.device);
			numDevices -= 1;
		}
		private function controllerUnusable(event:Event):void 
		{
			trace("Device connected is not supported.");
		}
	}

}