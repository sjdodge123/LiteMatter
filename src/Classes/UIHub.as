package Classes 
{
	import flash.display.Stage;
	import Classes.GameBoard.StopWatch;
	import Events.GameState;
	import flash.events.Event;
	import UI.MainScreen;
	/**
	 * ...
	 * @author ...
	 */
	public class UIHub 
	{
		private var gameRunning:Boolean = false;
		private var mainScreen:MainScreen;
		private var game:LiteMatter;
		private var stopWatch:StopWatch;
		
		public var keyBoard:KeyboardMonitor;
		
		public function UIHub(gameStage:Stage,game:LiteMatter) 
		{
			mainScreen = new MainScreen();
			game.popUpMenu(mainScreen);
			keyBoard = new KeyboardMonitor(gameStage);
			this.game = game;
			keyBoard.addEventListener(GameState.PAUSE_GAME, pauseGame);
			mainScreen.addEventListener(GameState.SINGLE_PLAYER, singlePlayerGame);
			mainScreen.addEventListener(GameState.MULTI_PLAYER, multiPlayerGame);
		}
		
		private function pauseGame(event:GameState):void
		{
			if (gameRunning) 
			{
				gameRunning = false;
				mainScreen.displayPauseScreen();
				game.popUpMenu(mainScreen);
				
			}
			else 
			{
				game.resumeGame();
				game.popDownMenu(mainScreen);
				mainScreen.clearMainScreen();
				gameRunning = true;
			}
		}
		
		public function singlePlayerGame(event:GameState):void 
		{
			game.startGame(1);
			gameRunning = true;
			cleanMainScreen();	
		}
		public function multiPlayerGame(event:GameState):void 
		{
			game.startGame(2);
			gameRunning = true;
			cleanMainScreen();
		}
		
		private function cleanMainScreen():void 
		{
			mainScreen.clearMainScreen();
			game.popDownMenu(mainScreen);
		}
		
		public function endGameScreen(playerNum:int):void
		{
			game.emptyGameBoard();
			game.displayScore(playerNum);
			gameRunning = false;
			mainScreen.displayEndScreen(playerNum);
			game.popUpMenu(mainScreen);
		}
		
		public function getGameRunning():Boolean
		{
			return gameRunning;
		}
		
	}

}