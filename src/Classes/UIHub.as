package Classes 
{
	import flash.display.Stage;
	import Classes.GameBoard.StopWatch;
	import Events.GameState;
	import flash.events.Event;
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
	public class UIHub 
	{
		private var gameRunning:Boolean = false;
		private var gamePaused:Boolean = false;
		private var mainScreen:MainScreen;
		private var game:LiteMatter;
		private var gameStage:Stage;
		private var stopWatch:StopWatch;
		private var scoreBoard:ScoreBoard;
		private var gameMuted:Boolean = false;
		public var ioMonitor:IOMonitor;
		
		public function UIHub(gameStage:Stage,game:LiteMatter) 
		{
			mainScreen = new MainScreen();
			scoreBoard = new ScoreBoard();
			game.popUpMenu(mainScreen);
			this.gameStage = gameStage;
			ioMonitor = new IOMonitor(gameStage);
			this.game = game;
			mainScreen.addEventListener(GameState.SINGLE_PLAYER, singlePlayerGame);
			mainScreen.addEventListener(GameState.MULTI_PLAYER, multiPlayerGame);
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
			else 
			{
				gamePaused = false;
				game.resetWatch();
				game.popDownMenu(mainScreen);
				gameRunning = true;
			}
		}
		
		private function resetGame(event:GameState):void 
		{
			if (gamePaused) 
			{
				game.popDownMenu(mainScreen);
				game.emptyGameBoard();
				removeKeyBoardListeners();
				game.resetWatch();
				mainScreen.displayStartScreen();
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
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			addKeyBoardListeners();
			game.startGame(1);
			gameRunning = true;
			game.popDownMenu(mainScreen);		
		}
		private function multiPlayerGame(event:GameState):void 
		{
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			addKeyBoardListeners();
			game.startGame(2);
			gameRunning = true;
			game.popDownMenu(mainScreen);
		}
		
		private function addKeyBoardListeners():void 
		{
			ioMonitor.addEventListener(GameState.PAUSE_GAME, pauseGame);
			ioMonitor.addEventListener(GameState.FULL_SCREEN, displayFullScreen);
			ioMonitor.addEventListener(GameState.RESET, resetGame);
			ioMonitor.addEventListener(GameState.MUTE_GAME, muteSound);
		}
		private function removeKeyBoardListeners():void 
		{
			ioMonitor.removeEventListener(GameState.PAUSE_GAME, pauseGame);
			ioMonitor.removeEventListener(GameState.FULL_SCREEN, displayFullScreen);
			ioMonitor.removeEventListener(GameState.RESET, resetGame);
			ioMonitor.removeEventListener(GameState.MUTE_GAME, muteSound);
		}
		
		
		public function endGameScreen(playerNum:int):void
		{
			game.displayScore(playerNum);
			mainScreen.displayEndScreen(playerNum,scoreBoard);
			game.emptyGameBoard();
			removeKeyBoardListeners();
			gameRunning = false;
			game.popUpMenu(mainScreen);
			
		}
		
		public function controllerAdded(device:GameInputDevice):void 
		{
			ioMonitor.controllerAdded(device);
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
		
	}

}