package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import UI.MainScreen;
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameBoard.StopWatch;
	import Events.GameState;
	
	
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
		private var mainScreen:MainScreen;
		
		public function LiteMatter()
		{
			Initialize();
			mainScreen.addEventListener(GameState.SINGLE_PLAYER, singlePlayerGame);
			mainScreen.addEventListener(GameState.MULTI_PLAYER, multiPlayerGame);
		}
		 
		private function Initialize():void
		{
			mainScreen = new MainScreen();
			this.stageWidth = stage.stageWidth;
			this.stageHeight = stage.stageHeight;
			addChild(mainScreen);
			stage.focus = mainScreen;
		}
		
		public function singlePlayerGame(event:GameState):void 
		{
			InitializeGameBoard();
			gameBoard.addPlayer2AI();
			gameStarted = true;
			cleanMainScreen();
		}
		public function multiPlayerGame(event:GameState):void 
		{
			InitializeGameBoard();
			gameBoard.addPlayer2HU();
			gameStarted = true;
			cleanMainScreen();
		}
		
		private function InitializeGameBoard():void 
		{
			text2.x = stageWidth - 110;
			text2.textColor = 0xFFFFFF;
			text1.textColor = 0xFFFFFF;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight,stage);
			gameBoard.initializeGameObjects();
			addChild(gameBoard);
			stopWatch = new StopWatch();
			addChild(text1);
			addChild(text2);
			stage.stageFocusRect = false;
			stage.focus = gameBoard;
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function cleanMainScreen():void 
		{
			mainScreen.clearMainScreen();
			removeChild(mainScreen);
		}
		
		
		public function update(e:Event):void
		{

			if ((gameBoard.ship.getRespawnCount() != 0)&&(gameBoard.ship2.getRespawnCount() != 0) && gameStarted) 
			{
				
			deltaT = stopWatch.calcTime();
			gameBoard.updateGameBoard(deltaT);
			
//			mousePoint = new Point(stage.mouseX,stage.mouseY);
			
			print("Player 1 lives: " +gameBoard.ship.getRespawnCount()+ "\n" + "HP: " + gameBoard.ship.getHP(), text1);
			print("Player 2 lives: " +gameBoard.ship2.getRespawnCount() + "\n" + "HP: " + gameBoard.ship2.getHP(),text2);
			}
			
			
			
			if (gameBoard.ship.getRespawnCount() == 0) 
			{
				endGameScreen(2);		
			}
			if (gameBoard.ship2.getRespawnCount() == 0) 
			{
				endGameScreen(1);
			}
			
		}
		
		public function endGameScreen(playerNum:int):void
		{
			print("Player " + playerNum  +" wins!!!!", text2);
			stage.stageFocusRect = true;
			stage.focus = mainScreen;
			disposeGameBoard();
			gameStarted = false;
			mainScreen.displayEndScreen(playerNum);
			addChild(mainScreen);
		}
		
		public function disposeGameBoard():void
		{
			gameBoard.clearGameBoard();
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
	}
}