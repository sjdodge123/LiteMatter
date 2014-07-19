package Classes 
{
	import flash.display.Stage;
	import Classes.GameBoard.StopWatch;
	import Events.GameState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.ui.GameInputDevice;
	import UI.MainScreen;
	import UI.ScoreBoard.ScoreBoard;
	import UI.ScoreBoard.ScorePage;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author ...
	 */
	public class UIHub extends EventDispatcher
	{
		private var gameRunning:Boolean = false;
		private var gamePaused:Boolean = false;
		private var onMenu:Boolean = true;
		private var controllersInUse:Boolean = false;
		public var mainScreen:MainScreen;
		private var game:LiteMatter;
		private var gameStage:Stage;
		private var stopWatch:StopWatch;
		private var scoreBoard:ScoreBoard;
		private var gameMuted:Boolean = false;
		public var ioMonitor:IOMonitor;
		private var numControllers:int;
		private var currentDevice:GameInputDevice;
		
		public function UIHub(gameStage:Stage,game:LiteMatter) 
		{
			mainScreen = new MainScreen();
			scoreBoard = new ScoreBoard();
			this.gameStage = gameStage;
			ioMonitor = new IOMonitor(gameStage);
			this.game = game;
			addKeyBoardListeners();
			mainScreen.addEventListener(GameState.SINGLE_PLAYER, singlePlayerGame);
			mainScreen.addEventListener(GameState.MULTI_PLAYER, multiPlayerGame);
			addEventListener(GameState.CONFIRM_CONTROLLER, controllerConfirmed);
		}
		
		private function pauseGame(event:GameState):void
		{
			if (gameRunning) 
			{
				gamePaused = true;
				gameRunning = false;
				mainScreen.displayPauseScreen();
				game.popUpMenu(mainScreen);
			}
			else if (gamePaused)
			{
				gamePaused = false;
				game.resetWatch();
				game.popDownMenu(mainScreen);
				gameRunning = true;
			}
			if (onMenu  && (numControllers > 0)) 
			{
				currentDevice = event.target.currentDevice;
				dispatchEvent(new GameState(GameState.CONFIRM_CONTROLLER, currentDevice));
			}
		}
		
		private function resetGame(event:GameState):void 
		{
			if (gamePaused) 
			{
				gamePaused = false;
				gameRunning = false;
				onMenu = true;
				controllersInUse = true;
				addEventListener(GameState.CONFIRM_CONTROLLER, controllerConfirmed);
				game.popDownMenu(mainScreen);
				game.emptyGameBoard();
				removeGameListeners();
				game.resetWatch();
				mainScreen.displayStartScreen();
				mainScreen.displayControllerScreens();
				game.popUpMenu(mainScreen);
			}
		}
		
		private function muteSound(event:GameState):void 
		{
			if (gamePaused&&!gameMuted) 
			{
				SoundMixer.soundTransform = new SoundTransform(0);
				//TODO:Display Speaker off Graphic
			}
			if (gameMuted) 
			{
				SoundMixer.soundTransform = new SoundTransform(1);
				//TODO:Display Speaker on Graphic
			}
			gameMuted = !gameMuted;
		}
		
		private function displayFullScreen(event:GameState):void 
		{
			game.displayFullScreen();
		}
		
		
		private function singlePlayerGame(event:GameState):void 
		{
			removeEventListener(GameState.CONFIRM_CONTROLLER, controllerConfirmed);
			addGameListeners();
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			game.startGame(1);
			gameRunning = true;
			controllersInUse = false;
			game.popDownMenu(mainScreen);		
		}
		private function multiPlayerGame(event:GameState):void 
		{
			removeEventListener(GameState.CONFIRM_CONTROLLER, controllerConfirmed);
			addGameListeners();
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			game.startGame(2);
			controllersInUse = false;
			gameRunning = true;
			game.popDownMenu(mainScreen);
		}
		private function startGamePressed(event:GameState):void 
		{ 
			if (controllersInUse)
			{
				removeEventListener(GameState.CONFIRM_CONTROLLER, controllerConfirmed);
				ioMonitor.removeEventListener(GameState.START_GAME, startGamePressed);
				addGameListeners();
				if (numControllers > 1) 
				{
					scoreBoard.addPlayer(1);
					scoreBoard.addPlayer(2);
					game.startGame(2);
					gameRunning = true;
					game.popDownMenu(mainScreen);
				}
				else 
				{
					scoreBoard.addPlayer(1);
					scoreBoard.addPlayer(2);
					game.startGame(1);
					gameRunning = true;
					game.popDownMenu(mainScreen);
				}
			}
		}
		
		private function addKeyBoardListeners():void 
		{
			ioMonitor.addEventListener(GameState.PAUSE_GAME, pauseGame);
			ioMonitor.addEventListener(GameState.FULL_SCREEN, displayFullScreen);
			ioMonitor.addEventListener(GameState.RESET, resetGame);
			ioMonitor.addEventListener(GameState.MUTE_GAME, muteSound);
			ioMonitor.addEventListener(GameState.START_GAME, startGamePressed);
		}
		private function addGameListeners():void 
		{
			ioMonitor.addEventListener(GameState.FULL_SCREEN, displayFullScreen);
			ioMonitor.addEventListener(GameState.RESET, resetGame);
			ioMonitor.addEventListener(GameState.MUTE_GAME, muteSound);
		}
		private function removeGameListeners():void 
		{
			ioMonitor.removeEventListener(GameState.FULL_SCREEN, displayFullScreen);
			ioMonitor.removeEventListener(GameState.RESET, resetGame);
			ioMonitor.removeEventListener(GameState.MUTE_GAME, muteSound);
		}
		
		
		public function endGameScreen(playerNum:int):void
		{
			game.displayScore(playerNum);
			removeGameListeners();
			mainScreen.displayEndScreen(playerNum, scoreBoard);
			game.emptyGameBoard();
			gameRunning = false;
			gamePaused = false;
			game.popUpMenu(mainScreen);
			addEventListener(GameState.CONFIRM_CONTROLLER, controllerConfirmed);
			mainScreen.displayControllerScreens();
			
		}
		
		public function controllerAdded(device:GameInputDevice):void 
		{
			numControllers += 1;
			ioMonitor.controllerAdded(device);

		}
		public function addControllerPopUpScreen(playNum:int,device:GameInputDevice):void 
		{
			if (!gameRunning) 
			{
				mainScreen.addControllerPopScreen(playNum,device);
			}
		}
		
		private function controllerConfirmed(event:Event):void 
		{
			controllersInUse = true;
			ioMonitor.addEventListener(GameState.START_GAME, startGamePressed);
			mainScreen.confirmControllerScreen(event.target.currentDevice);
			var id:Number = Number(event.target.currentDevice.id.charAt(event.target.currentDevice.id.length-1));
			game.changeInputType(id);
		}
		
		public function getGameRunning():Boolean
		{
			return gameRunning;
		}
		public function getNextPage():ScorePage
		{
			return scoreBoard.getNextPage();
		}
		public function clearAllPages():void 
		{
			scoreBoard.removeAllPlayers();
		}
		public function setOnMenu(value:Boolean):void 
		{
			onMenu = value;
		}
		
	}

}