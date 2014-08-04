package UI.Screens 
{
	import flash.display.Sprite;
	import flash.ui.GameInputDevice;
	
	import UI.Blocks.LabelBox;

	public class ControllerPopScreen extends Sprite
	{
		private var pressStart:LabelBox;
		private var playNum:int;
		public var device:GameInputDevice;
		public function ControllerPopScreen(playNum:int,device:GameInputDevice) 
		{
			this.device = device;
			this.playNum = playNum;
			var detected:LabelBox = new LabelBox("Controller detected", 475+(playNum*250), 720, 300, 22);
			pressStart = new LabelBox("Press start to use for Player "+ (playNum+1), 475+(playNum*250), 760, 300, 18);
			addChild(detected);
			addChild(pressStart);
			
		}
		
		public function confirmController():void 
		{
			removeChild(pressStart);
			pressStart = new LabelBox("Player " + (playNum + 1) + " now using a controller.\n Press A to start game.", 475 + (playNum * 250), 760, 300, 18);
			addChild(pressStart);
		}
		public function unConfirmController():void 
		{
			removeChild(pressStart);
			pressStart = new LabelBox("Press start to use for Player "+ (playNum+1), 475+(playNum*250), 760, 300, 18);
			addChild(pressStart);
		}
		public function resetMenu():void
		{
			removeChild(pressStart);
			pressStart = new LabelBox("Press start to use for Player "+ (playNum+1), 475+(playNum*250), 760, 300, 18);
			addChild(pressStart);
		}
		
		
		
	}

}