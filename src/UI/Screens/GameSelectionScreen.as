package UI.Screens
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.ui.GameInputDevice;
	
	import Events.SelectionEvent;
	import Events.UIEvent;
	
	import Loaders.SoundLoader;
	
	import UI.Blocks.AnimatedClipLabel;
	import UI.Blocks.LabelBox;
	import UI.Components.SideScrollBox;
	import UI.ScoreBoard.ScoreBoard;
	import UI.Components.ShipOptionsSWF;

	public class GameSelectionScreen extends Sprite
	{
		private var playButton:AnimatedClipLabel;
		private var backButton:AnimatedClipLabel;
		private var shipOne:ShipOptionsSWF;
		private var shipTwo:ShipOptionsSWF;
		private var scoreBoard:ScoreBoard;
		private var controller:Vector.<ControllerPopScreen>;
		private var maxNumPlayers:int = 2;
		private var soundLoader:SoundLoader;
		private var selectSound:Sound;
		private var lockedColor:uint;
		private var lives:int = 2;
		private var livesSelection:SideScrollBox;
		public function GameSelectionScreen(scoreBoard:ScoreBoard)
		{
			this.scoreBoard = scoreBoard;
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			shipOne = new ShipOptionsSWF(25,10,scoreBoard.getNextPage());
			//shipOne.addEventListener(SelectionEvent.INPUT_CHANGE,colorShipOneChange);
			addChild(shipOne);
			shipTwo = new ShipOptionsSWF(350,10,scoreBoard.getNextPage());
			//shipTwo.addEventListener(SelectionEvent.INPUT_CHANGE,colorShipTwoChange);
			addChild(shipTwo);
			soundLoader = new SoundLoader();
			selectSound = soundLoader.loadSound("./Sounds/select.mp3");
			
			controller = new Vector.<ControllerPopScreen>;
			for(var i:int=0;i<maxNumPlayers;i++)
			{
				controller.push(null);
			}
			livesSelection = new SideScrollBox(500,500,new LabelBox("Respawns: " + lives,525,480,25,37));
			livesSelection.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			addChild(livesSelection);
			playButton = new AnimatedClipLabel("./Images/beginButton.swf",600,600,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			
			backButton = new AnimatedClipLabel("./Images/backButton.swf",600,700,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
		
		protected function inputTypeChanged(event:SelectionEvent):void
		{
			if(event.params[0] == livesSelection)
			{
				if(event.params[1])
				{
					lives++;
				}
				else
				{
					if(lives > 1)
					{
						lives--;
					}
				}
				var newLabel:LabelBox = new LabelBox("Respawns: " + lives,525,480,25,37);
				livesSelection.addLabel(newLabel);
				var oldLabel:LabelBox = livesSelection.getCurrentLabel();
				livesSelection.changeLabel(newLabel);
				livesSelection.removeLabel(oldLabel);
			}
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
			infoReady.push(shipOne.collectInfo(),shipTwo.collectInfo(),lives);
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
			shipTwo.resetPage(scoreBoard.getNextPage(),colorTwo);
			addChild(shipTwo);
			livesSelection = new SideScrollBox(500,500,new LabelBox("Respawns: " + lives,525,480,25,37));
			livesSelection.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			addChild(livesSelection);
			playButton = new AnimatedClipLabel("./Images/beginButton.swf",600,600,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			backButton = new AnimatedClipLabel("./Images/backButton.swf",600,700,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
		public function replay(colorOne:uint,colorTwo:uint):void
		{
			scoreBoard.removeAllPlayers();
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			removeChildren();
			shipOne.resetPage(scoreBoard.getNextPage(),colorOne);
			shipTwo.resetPage(scoreBoard.getNextPage(),colorTwo);
			playGame(null);
		}
	}
}