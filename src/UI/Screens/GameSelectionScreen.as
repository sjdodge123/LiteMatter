package UI.Screens
{
	import flash.display.Sprite;
	import flash.ui.GameInputDevice;
	
	import Events.UIEvent;
	
	import UI.Blocks.ClipLabel;
	import UI.Blocks.InfoReadyObject;
	import UI.Blocks.LabelButton;
	import UI.Components.ShipOptions;
	import UI.ScoreBoard.ScoreBoard;

	public class GameSelectionScreen extends Sprite
	{
		private var playButton:ClipLabel;
		private var backButton:LabelButton;
		private var shipOne:ShipOptions;
		private var shipTwo:ShipOptions;
		private var scoreBoard:ScoreBoard;
		private var controller:Vector.<ControllerPopScreen>;
		private var maxNumPlayers:int = 2;
		public function GameSelectionScreen(scoreBoard:ScoreBoard)
		{
			this.scoreBoard = scoreBoard;
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			shipOne = new ShipOptions(25,10,scoreBoard.getNextPage());
			addChild(shipOne);
			shipTwo = new ShipOptions(350,10,scoreBoard.getNextPage());
			addChild(shipTwo);
			
			controller = new Vector.<ControllerPopScreen>;
			for(var i:int=0;i<maxNumPlayers;i++)
			{
				controller.push(null);
			}
			
			playButton = new ClipLabel("./Images/play.swf",600,600,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			backButton = new LabelButton("Back",600,700,250,40,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
		
		protected function playGame(event:UIEvent):void
		{
			var infoReady:InfoReadyObject = new InfoReadyObject(shipOne.collectInfo(),shipTwo.collectInfo());
			dispatchEvent(new UIEvent(UIEvent.PLAY, infoReady,true));
		}
		
		protected function backToMain(event:UIEvent):void
		{
			dispatchEvent(event);
		}		
		
		public function addControllerPopScreen(playNum:int,device:GameInputDevice):void
		{
			//var screen:ControllerPopScreen = new ControllerPopScreen(playNum,device);
			var id:Number = Number(device.id.charAt(device.id.length-1));
			//controller[id] = screen;
			if(playNum == 0)
			{
				shipOne.deviceAdded(playNum+1,device);
			}
			if(playNum == 1)
			{
				shipTwo.deviceAdded(playNum+1,device);
			}
			
		}
		
		public function displayControllerScreens():void
		{
			for (var i:int = 0; i < controller.length; i++) 
			{
				if(controller[i] != null)
				{
					controller[i].resetMenu();
					addChild(controller[i]);
				}
			}
		}
		
		public function removeControllerPopScreen(playNum:int, device:GameInputDevice):void
		{
			for(var i:int=0;i<controller.length;i++)
			{
				if(controller[i].device == device)
				{
					removeChild(controller[i]);
					controller[i] = null
				}
			}	
		}
		
		public function reset():void
		{
			scoreBoard.removeAllPlayers();
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			removeChildren();
			shipOne = new ShipOptions(25,10,scoreBoard.getNextPage());
			addChild(shipOne);
			shipTwo = new ShipOptions(350,10,scoreBoard.getNextPage());
			addChild(shipTwo);

			playButton = new ClipLabel("./Images/play.swf",600,600,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			backButton = new LabelButton("Back",600,700,250,40,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
	}
}