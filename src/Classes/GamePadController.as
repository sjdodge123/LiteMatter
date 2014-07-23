package Classes 
{
	
	import flash.ui.GameInput;
	import flash.ui.GameInputDevice;
	import Classes.UIHub;
	import flash.events.Event;
	import flash.events.GameInputEvent;
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
		private function controllerAdded(event:Event):void 
		{
			uiHub.controllerAdded(GameInput.getDeviceAt(numDevices));
			uiHub.addControllerPopUpScreen(numDevices,GameInput.getDeviceAt(numDevices));
			numDevices += 1;
		}
		private function controllerRemoved(event:Event):void 
		{
			trace(GameInput.numDevices);
			numDevices -= 1;
			//TODO Remove associated device from device array
		}
		private function controllerUnusable(event:Event):void 
		{
			trace("Device connected is not supported.");
		}
	}

}