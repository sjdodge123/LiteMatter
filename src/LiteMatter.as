package
{
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.ui.GameInput;
	import flash.ui.GameInputDevice;
	
	import Classes.GamePadController;
	import Classes.IOMonitor;
	import Classes.UIHub;
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameBoard.StopWatch;
	
	import Interfaces.IInputHandling;
	
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Input.XboxControllerModel;
	
	import Recording.PlayBackModel;
	import Recording.Rabbit;
	
	import UI.UserInterfaceController;
	import UI.ScoreBoard.ScorePage;
	
	
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
		private var theta:Number = .034;
		private var rabbit1:Rabbit;
		private var rabbit2:Rabbit;
		private var replayPage1:ScorePage;
		private var replayPage2:ScorePage;
		private var replayRabit1:PlayBackModel;
		private var replayRabit2:PlayBackModel;
		private var onEndScreen:Boolean = false;

		
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
			gameBoard = new GameBoardObjects(stage);
			addChild(gameBoard);
			popUpMenu(uiHub.screenController);
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
			var player1Input:IInputHandling = gameBoard.inputPlayer1;
			var player2Input:IInputHandling = gameBoard.inputPlayer2;
			gameBoard.removeChildren();
			gameBoard = null;
			gameBoard = new GameBoardObjects(stage);
			gameBoard.inputPlayer1 = player1Input;
			gameBoard.inputPlayer2 = player2Input;
			text2.x = stageWidth - 110;
			text2.textColor = 0xFFFFFF;
			text1.textColor = 0xFFFFFF;
			rabbit1 = new Rabbit();
			rabbit2 = new Rabbit();
			gameBoard.initializeGameObjects(uiHub.getPlayerOnePage());
			rabbit1.buildModel(player1Input);
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
				if(gameBoard.ship.getCanRecord())
				{
					rabbit1.record(deltaT,gameBoard.ship,gameBoard.objectArray);
				}
				
				if(gameBoard.ship2.getCanRecord())
				{
					rabbit2.record(deltaT,gameBoard.ship2,gameBoard.objectArray);
				}
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
				deltaT = theta;
				gameBoard.updateGameBoard(deltaT);
			}
			else if (onEndScreen)
			{
				deltaT = replayRabit1.playBack();
				replayRabit2.playBack();
				gameBoard.updateGameBoard(deltaT);
				if (gameBoard.ship.getRespawnCount() == 0) 
				{
					onEndScreen = false;
				}
				else if (gameBoard.ship2.getRespawnCount() == 0) 
				{
					onEndScreen = false;
				}	
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
				gameBoard.addPlayer2AI(uiHub.getPlayerTwoPage());
			}
			//2 is HU
			if (numPlayers == 2) 
			{
				gameBoard.addPlayer2HU(uiHub.getPlayerTwoPage());
			}
			rabbit2.buildModel(gameBoard.inputPlayer2);
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
		public function popUpMenu(mainScreen:UserInterfaceController):void 
		{
			addChild(mainScreen);
			stage.focus = mainScreen;
			uiHub.setOnMenu(true);
		}
		public function popDownMenu(mainScreen:UserInterfaceController):void
		{
			if (this.contains(mainScreen)) 
			{
				removeChild(mainScreen);
			}
			mainScreen.clearScreen();
			stage.focus = gameBoard;
			uiHub.setOnMenu(false);
		}
		public function resetToMenu():void 
		{
			emptyGameBoard();
			soundChannel.stop();
			soundChannel = menuTheme.play(0, 150);
			gameBoard.intitalizeBackgroundObjects();
			addChild(gameBoard);
			onMainMenu = true;
			onEndScreen = false;
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
			replayPage1 = uiHub.getPlayerOnePage();
			replayPage2 = uiHub.getPlayerTwoPage();
			uiHub.clearAllPages();
			gameBoard = null;
			gameBoard = new GameBoardObjects(stage);
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
		public function changeInputType(playerNum:Number,device:GameInputDevice,type:int=0):void
		{
			if (type == 0) 
			{
				var input:XboxControllerModel = new XboxControllerModel(stage, device);
				gameBoard.changeInputType(playerNum, input);
			}
			else 
			{
				if (playerNum == 1) 
				{
					gameBoard.changeInputType(playerNum,new Player1InputModel(stage));
				}
				if (playerNum == 2) 
				{
					gameBoard.changeInputType(playerNum,new Player2InputModel(stage));
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
		public function initiatePlayBack():void
		{
			gameBoard = new GameBoardObjects(stage);
			addChild(gameBoard);
			onEndScreen = true;
			gameBoard.initializePlayBack(rabbit1.getEventArray(),rabbit2.getEventArray(),replayPage1,replayPage2,rabbit1);
			replayRabit1 = PlayBackModel(gameBoard.inputPlayer1);
			replayRabit2 = PlayBackModel(gameBoard.inputPlayer2);
			stopWatch = new StopWatch();
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		public function getColor(value:int):uint
		{
			if(value == 1)
			{
				return replayPage1.getColor();
			}
			else
			{
				return replayPage2.getColor();
			}
			
		}
		
	}
}