package Classes 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.ui.GameInputDevice;
	import Events.GameBoardEvent;
	import Classes.GameBoard.StopWatch;
	
	import Events.ButtonEvent;
	import Events.UIEvent;
	
	import UI.UserInterfaceController;
	import UI.ScoreBoard.ScoreBoard;
	import UI.ScoreBoard.ScorePage;

	/**
	 * ...
	 * @author ...
	 */
	public class UIHub extends EventDispatcher
	{
		private var gameRunning:Boolean;
		private var gamePaused:Boolean;
		private var onMenu:Boolean = true;
		public var screenController:UserInterfaceController;
		
		private var game:LiteMatter;
		private var gameStage:Stage;
		private var stopWatch:StopWatch;
		private var scoreBoard:ScoreBoard;
		private var gameMuted:Boolean = false;
		public var ioMonitor:IOMonitor;
		private var numControllers:int;
		private var currentDevice:GameInputDevice;
		private var playerOnePage:ScorePage;
		private var playerTwoPage:ScorePage;
		
		public function UIHub(gameStage:Stage,game:LiteMatter) 
		{
			scoreBoard = new ScoreBoard();
			screenController = new UserInterfaceController(scoreBoard,gameStage);
			this.gameStage = gameStage;
			ioMonitor = new IOMonitor(gameStage);
			this.game = game;
			addGlobalListeners();
			resetGameVariables();
		}
		
		/*
		  ************************************************
						  *** STARTGAME *** 
		  ************************************************
		*/
		private function singlePlayerGame():void 
		{
			addGameListeners();
			game.startGame(1);
			gameRunning = true;
			game.popDownMenu(screenController);		
		}
		private function multiPlayerGame():void 
		{
			addGameListeners();
			game.startGame(2);
			gameRunning = true;
			game.popDownMenu(screenController);
		}
		private function startGamePressed(event:UIEvent):void 
		{ 
			removeControllerListeners();
			addGameListeners();
			if (numControllers > 1) 
			{
				game.startGame(2);
				gameRunning = true;
				game.popDownMenu(screenController);
			}
			else 
			{
				game.startGame(1);
				gameRunning = true;
				game.popDownMenu(screenController);
			}
		}
		/*
		  ************************************************
						  *** ENDGAME *** 
		  ************************************************
		*/
		
		private function resetGamePaused(event:UIEvent):void 
		{
			if (gamePaused) 
			{
				resetGameVariables();
				game.popDownMenu(screenController);
				game.resetToMenu();
				removeGameListeners();
				game.resetWatch();
				screenController.displayMainMenuScreen();
				screenController.displayControllerScreens();
				screenController.resetToMenu(game.getColor(1),game.getColor(2));
				game.popUpMenu(screenController);
			}
		}
		private function resetGame(event:UIEvent):void 
		{
			screenController.removeEventListener(UIEvent.BACK,resetGame);
			resetGameVariables();
			game.popDownMenu(screenController);
			game.resetToMenu();
			removeGameListeners();
			game.resetWatch();
			screenController.displayMainMenuScreen();
			screenController.resetToMenu(game.getColor(1),game.getColor(2));
			game.popUpMenu(screenController);
		}
		public function endGameScreen(playerNum:int):void
		{
			removeGameListeners();
			resetGameVariables();
			screenController.displayEndScreen(playerNum, scoreBoard);
			game.emptyGameBoard();
			game.initiatePlayBack();
			game.popUpMenu(screenController);
			screenController.displayControllerScreens();
			screenController.addEventListener(UIEvent.BACK,resetGame);
		}
		
		/*
		  ************************************************
						  *** GAME COMMANDS *** 
		  ************************************************
		*/
		
		protected function playGame(event:UIEvent):void
		{
			var playerOneSignal:int = event.params[0].inputSignal;
			var playerTwoSignal:int = event.params[1].inputSignal;
			playerOnePage = event.params[0].page;
			playerTwoPage = event.params[1].page;
			playerOnePage.setInitialLives(event.params[2]);
			playerTwoPage.setInitialLives(event.params[2]);
			
			if(playerOneSignal == 3)
			{
				game.changeInputType(1,event.params[0].device);
			}
			if(playerTwoSignal == 3)
			{
				game.changeInputType(2,event.params[1].device);
				multiPlayerGame();
			}
			if(playerTwoSignal == 4)
			{
				singlePlayerGame();
			}
			if(playerTwoSignal == 2)
			{
				multiPlayerGame();
			}
		}
		protected function optionsInfo(event:UIEvent):void
		{
			game.changePace(event.params[0]);		
		}
		
		private function pauseGame(event:UIEvent):void
		{
			if (gameRunning) 
			{
				gamePaused = true;
				gameRunning = false;
				screenController.displayPauseScreen();
				game.popUpMenu(screenController);
			}
			else if (gamePaused)
			{
				gamePaused = false;
				game.resetWatch();
				game.popDownMenu(screenController);
				gameRunning = true;
			}
		}
		private function muteSound(event:UIEvent):void 
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
		private function displayFullScreen(event:UIEvent):void 
		{
			game.displayFullScreen();
		}
		/*
		  ************************************************
					*** GAME LISTENER CONTROL *** 
		  ************************************************
		*/
		
		private function addGlobalListeners():void 
		{
			ioMonitor.addEventListener(UIEvent.PAUSE_GAME, pauseGame);
			ioMonitor.addEventListener(UIEvent.FULL_SCREEN, displayFullScreen);
			screenController.addEventListener(UIEvent.BACK,optionsInfo);
		}
		
		private function addMenuListeners():void 
		{
			screenController.addEventListener(UIEvent.PLAY, playGame);
			screenController.addEventListener(GameBoardEvent.ADD,addSelectionObject);
			screenController.addEventListener(GameBoardEvent.REMOVE,addSelectionObject);
		}
		
		protected function addSelectionObject(event:GameBoardEvent):void
		{
			if(event.type == GameBoardEvent.ADD){
				this.game.addSelectionObject(event);
			}
			if(event.type == GameBoardEvent.REMOVE){
				this.game.removeSelectionObject(event);
			}
			
		}
		private function addGameListeners():void 
		{
			ioMonitor.addEventListener(UIEvent.RESET, resetGamePaused);
			ioMonitor.addEventListener(UIEvent.MUTE_GAME, muteSound);
	
		}
		private function removeGameListeners():void 
		{
			ioMonitor.removeEventListener(UIEvent.RESET, resetGamePaused);
			ioMonitor.removeEventListener(UIEvent.MUTE_GAME, muteSound);
			ioMonitor.removeEventListener(UIEvent.START_GAME, startGamePressed);
		}
		private function addControllerListeners():void 
		{
			ioMonitor.addEventListener(UIEvent.DOWN, shiftDown);
			ioMonitor.addEventListener(UIEvent.UP, shiftUP);
		}
		
		private function removeControllerListeners():void 
		{
			ioMonitor.removeEventListener(UIEvent.DOWN, shiftDown);
			ioMonitor.removeEventListener(UIEvent.UP, shiftUP);
		}
	
		private function resetGameVariables():void 
		{
			gameRunning = false;
			gamePaused = false;
			addMenuListeners();
		}
		/*
		  ************************************************
						  *** CONTROLLER COMMANDS *** 
		  ************************************************
		*/
		public function controllerAdded(device:GameInputDevice):void 
		{
			gameStage.stageFocusRect = false;
			numControllers += 1;
			ioMonitor.controllerAdded(device);
			addControllerListeners();
		}
		public function addControllerPopUpScreen(playNum:int,device:GameInputDevice):void 
		{
			if (!gameRunning) 
			{
				screenController.addControllerPopScreen(playNum,device);
			}
		}
		public function removeControllerPopUpScreen(playNum:int):void 
		{
			if (!gameRunning) 
			{
				screenController.removeControllerPopScreen(playNum);
			}
		}
		
		public function shiftUP(event:UIEvent):void
		{
			trace("up");
		}
		public function shiftDown(event:UIEvent):void
		{
			trace("down");
		}
		
		/*
		  ************************************************
					*** GETTERS AND SETTERS *** 
		  ************************************************
		*/
		
		public function getGameRunning():Boolean
		{
			return gameRunning;
		}
		public function getPlayerOnePage():ScorePage
		{
			return playerOnePage;
		}
		public function getPlayerTwoPage():ScorePage
		{
			return playerTwoPage;
		}
		public function clearAllPages():void 
		{
			scoreBoard.removeAllPlayers();
		}
		public function setOnMenu(value:Boolean):void 
		{
			onMenu = value;
		}
		
		public function getPlayerColor(value:int):uint
		{
			scoreBoard.openToPage(value);
			return scoreBoard.getColor();
		}
	}

}