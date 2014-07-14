package Classes 
{
	import flash.display.Stage;
	import Classes.GameBoard.StopWatch;
	import Events.GameState;
	import flash.events.Event;
	import UI.MainScreen;
	import UI.ScoreBoard.ScoreBoard;
	import UI.ScoreBoard.ScorePage;
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
		public var keyBoard:KeyboardMonitor;
		
		public function UIHub(gameStage:Stage,game:LiteMatter) 
		{
			mainScreen = new MainScreen();
			scoreBoard = new ScoreBoard();
			game.popUpMenu(mainScreen);
			this.gameStage = gameStage;
			keyBoard = new KeyboardMonitor(gameStage);
			this.game = game;
			keyBoard.addEventListener(GameState.PAUSE_GAME, pauseGame);
			keyBoard.addEventListener(GameState.FULL_SCREEN, displayFullScreen);
			keyBoard.addEventListener(GameState.RESET, resetGame);
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
				game.resetWatch();
				mainScreen.displayStartScreen();
				game.popUpMenu(mainScreen);
			}
		}
		
		private function displayFullScreen(event:GameState):void 
		{
			game.displayFullScreen();
		}
		
		
		private function singlePlayerGame(event:GameState):void 
		{
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			game.startGame(1);
			gameRunning = true;
			game.popDownMenu(mainScreen);		
		}
		private function multiPlayerGame(event:GameState):void 
		{
			scoreBoard.addPlayer(1);
			scoreBoard.addPlayer(2);
			game.startGame(2);
			gameRunning = true;
			game.popDownMenu(mainScreen);
		}
		
		
		public function endGameScreen(playerNum:int):void
		{
			game.displayScore(playerNum);
			mainScreen.displayEndScreen(playerNum,scoreBoard);
			game.emptyGameBoard();
			gameRunning = false;
			game.popUpMenu(mainScreen);
			
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