package
{
	import Classes.PlayerObject;
	import Classes.UIHub;
	import Classes.IOMonitor;
	import Classes.GamePadController;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import Interfaces.IInputHandling;
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Input.XboxControllerModel;
	import UI.MainScreen;
	import flash.events.Event;
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameBoard.StopWatch;
	import Events.GameState;
	import flash.display.StageDisplayState;
	import flash.media.SoundChannel;
	
	import flash.ui.GameInput;
	
	
	[SWF(backgroundColor= "0x000000", width="1200", height ="900", frameRate='30')]
	public class LiteMatter extends Sprite
	{
		private var text1:TextField = new TextField();
		private var text2:TextField = new TextField();
		private var mousePoint:Point;
		private var stopWatch:StopWatch;
		private var deltaT:Number;
		private var gameStarted:Boolean = false;
		private var stageWidth:int;
		private var stageHeight:int;
		private var gameBoard:GameBoardObjects; 
		private var keyBoard:IOMonitor;
		private var uiHub:UIHub;
		private var xbc:GamePadController;
		private var gameInput:GameInput;
		private var menuTheme:Sound;
		private var soundChannel:SoundChannel;
		private var onMainMenu:Boolean = true;
	
		public function LiteMatter()
		{
			Initialize();	
		}
		 
		private function Initialize():void
		{
			stage.stageFocusRect = false;
			uiHub = new UIHub(stage, this);
			xbc = new GamePadController(uiHub);
			this.stageWidth = stage.stageWidth;
			this.stageHeight = stage.stageHeight;
			gameBoard = new GameBoardObjects(stageWidth, stageHeight, stage);
			addChild(gameBoard);
			popUpMenu(uiHub.mainScreen);
			soundChannel = new SoundChannel();
			menuTheme = gameBoard.soundLoader.loadSound("./Sounds/mainMenuTheme.mp3");
			soundChannel = menuTheme.play(0, 150);
			gameBoard.intitalizeBackgroundObjects();
			stopWatch = new StopWatch();
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function InitializeGameBoard():void 
		{
			soundChannel.stop();
			gameBoard.removeChildren();
			gameBoard = null;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight,stage);
			text2.x = stageWidth - 110;
			text2.textColor = 0xFFFFFF;
			text1.textColor = 0xFFFFFF;
			gameBoard.initializeGameObjects(uiHub.getNextPage());
			addChild(gameBoard);
			stopWatch = new StopWatch();
			addChild(text1);
			addChild(text2);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			if (uiHub.getGameRunning())
			{
				deltaT = stopWatch.calcTime();
				gameBoard.updateGameBoard(deltaT);
				//mousePoint = new Point(stage.mouseX,stage.mouseY);
				
				print("Player 1 lives: " +gameBoard.ship.getRespawnCount()+ "\n" + "HP: " + gameBoard.ship.getHP(), text1);
				print("Player 2 lives: " +gameBoard.ship2.getRespawnCount() + "\n" + "HP: " + gameBoard.ship2.getHP(), text2);
				
				if (gameBoard.ship.getRespawnCount() == 0) 
				{
					uiHub.endGameScreen(gameBoard.ship2.getShipId());
				}
				else if (gameBoard.ship2.getRespawnCount() == 0) 
				{
					uiHub.endGameScreen(gameBoard.ship.getShipId());
				}	
			}
			else if (onMainMenu)
			{
				deltaT = stopWatch.calcTime();
				gameBoard.updateGameBoard(deltaT);
			}
		
		}
		public function startGame(numPlayers:int):void 
		{
			InitializeGameBoard();
			stage.focus = gameBoard;
			onMainMenu = false;
			//1 is AI
			if (numPlayers == 1) 
			{
				gameBoard.addPlayer2AI(uiHub.getNextPage());
			}
			//2 is HU
			if (numPlayers == 2) 
			{
				gameBoard.addPlayer2HU(uiHub.getNextPage());
			}
		}
		public function displayFullScreen():void 
		{
			if (stage.displayState != StageDisplayState.FULL_SCREEN_INTERACTIVE) 
			{
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			else
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		public function resetWatch():void 
		{
			stopWatch.reset();
		}
		
		public function displayScore(playerNum:int):void
		{
			print("Player " + playerNum  +" wins!!!!", text2);
		}
		public function popUpMenu(mainScreen:MainScreen):void 
		{
			addChild(mainScreen);
			stage.focus = mainScreen;
			uiHub.setOnMenu(true);
		}
		public function popDownMenu(mainScreen:MainScreen):void
		{
			if (this.contains(mainScreen)) 
			{
				removeChild(mainScreen);
			}
			mainScreen.clearMainScreen();
			stage.focus = gameBoard;
			uiHub.setOnMenu(false);
		}
		public function resetToMenu():void 
		{
			emptyGameBoard();
			soundChannel = menuTheme.play(0, 150);
			gameBoard.intitalizeBackgroundObjects();
			addChild(gameBoard);
			onMainMenu = true;
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
			
		public function emptyGameBoard():void 
		{
			if (stage.hasEventListener(Event.ENTER_FRAME)) 
			{
				stage.removeEventListener(Event.ENTER_FRAME, update);
			}
			if (contains(gameBoard)) 
			{
				removeChild(gameBoard);
			}
			uiHub.clearAllPages();
			gameBoard = null;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight,stage);
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
		public function changeInputType(playerNum:Number,type:int=0):void
		{
			if (type == 0) 
			{
				var input:XboxControllerModel = new XboxControllerModel(stage, GameInput.getDeviceAt(playerNum));
				gameBoard.changeInputType(playerNum+1, input);
			}
			else 
			{
				if (playerNum == 0) 
				{
					gameBoard.changeInputType(playerNum+1,new Player1InputModel(stage));
				}
				if (playerNum == 1) 
				{
					gameBoard.changeInputType(playerNum+1,new Player2InputModel(stage));
				}	
			}
			
		}
		public function checkInputType(playerNum:Number):int
		{
			if (gameBoard.checkInputType(playerNum+1) is XboxControllerModel) 
			{
				return 1;
			}
			return 0;
		}

		
	}
}