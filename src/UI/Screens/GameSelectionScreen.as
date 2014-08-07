package UI.Screens
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.ui.GameInputDevice;
	
	import Events.SelectionEvent;
	import Events.UIEvent;
	
	import Loaders.SoundLoader;
	
	import UI.Blocks.ClipLabel;
	import UI.Blocks.LabelBox;
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
		private var soundLoader:SoundLoader;
		private var selectSound:Sound;
		private var lockedColor:uint;
		public function GameSelectionScreen(scoreBoard:ScoreBoard)
		{
			this.scoreBoard = scoreBoard;
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			shipOne = new ShipOptions(25,10,scoreBoard.getNextPage());
			shipOne.addEventListener(SelectionEvent.INPUT_CHANGE,colorShipOneChange);
			addChild(shipOne);
			shipTwo = new ShipOptions(350,10,scoreBoard.getNextPage());
			shipTwo.addEventListener(SelectionEvent.INPUT_CHANGE,colorShipTwoChange);
			addChild(shipTwo);
			soundLoader = new SoundLoader();
			selectSound = soundLoader.loadSound("./Sounds/select.mp3");
			
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
		
		
		protected function colorShipOneChange(event:SelectionEvent):void
		{
			shipTwo.addColor(LabelBox(event.params[0]),LabelBox(event.params[1]));
		}
		protected function colorShipTwoChange(event:SelectionEvent):void
		{
			shipOne.addColor(LabelBox(event.params[0]),LabelBox(event.params[1]));
		}
		
		
		protected function playGame(event:UIEvent):void
		{
			selectSound.play();
			var infoReady:Array = new Array();
			infoReady.push(shipOne.collectInfo(),shipTwo.collectInfo());
			dispatchEvent(new UIEvent(UIEvent.PLAY, infoReady,true));
		}
		
		protected function backToMain(event:UIEvent):void
		{
			dispatchEvent(event);
		}		
		
		public function addControllerToScroll(playNum:int,device:GameInputDevice):void
		{
			shipOne.deviceAdded(playNum+1,device);
			shipTwo.deviceAdded(playNum+1,device);
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
		
		public function removeControllerFromScroll(playNum:int):void
		{
			if(playNum == 1)
			{
				shipOne.deviceRemoved(playNum);
				
			}
			if(playNum == 2)
			{
				shipTwo.deviceRemoved(playNum);
			}			
		}
		
		public function reset(colorOne:uint,colorTwo:uint):void
		{
			scoreBoard.removeAllPlayers();
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			removeChildren();
			shipOne.resetPage(scoreBoard.getNextPage(),colorOne);
			addChild(shipOne);
			shipTwo.resetPage(scoreBoard.getNextPage(),colorTwo);;
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