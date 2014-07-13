package
{
	import Classes.UIHub;
	import Classes.KeyboardMonitor;
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
		private var keyBoard:KeyboardMonitor;
		private var uiHub:UIHub;
		
		public function LiteMatter()
		{
			Initialize();	
		}
		 
		private function Initialize():void
		{
			
			uiHub = new UIHub(stage,this);		
			this.stageWidth = stage.stageWidth;
			this.stageHeight = stage.stageHeight;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight,stage);
			stage.stageFocusRect = false;
		}
		
		public function InitializeGameBoard():void 
		{
			text2.x = stageWidth - 110;
			text2.textColor = 0xFFFFFF;
			text1.textColor = 0xFFFFFF;
			gameBoard.initializeGameObjects();
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
			
//			mousePoint = new Point(stage.mouseX,stage.mouseY);
			
			print("Player 1 lives: " +gameBoard.ship.getRespawnCount()+ "\n" + "HP: " + gameBoard.ship.getHP(), text1);
			print("Player 2 lives: " +gameBoard.ship2.getRespawnCount() + "\n" + "HP: " + gameBoard.ship2.getHP(),text2);
			}
			
			if (gameBoard.ship.getRespawnCount() == 0) 
			{
				uiHub.endGameScreen(2);
			}
			else if (gameBoard.ship2.getRespawnCount() == 0) 
			{
				uiHub.endGameScreen(1);
			}
			
		}
		public function startGame(numPlayers:int):void 
		{
			InitializeGameBoard();
			stage.focus = gameBoard;			
			//1 is AI
			if (numPlayers == 1) 
			{
				gameBoard.addPlayer2AI();
			}
			//2 is HU
			if (numPlayers == 2) 
			{
				gameBoard.addPlayer2HU();
			}
			
		}
		
		public function resumeGame():void 
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
		}
		public function popDownMenu(mainScreen:MainScreen):void
		{
			removeChild(mainScreen);
			stage.focus = gameBoard;
		}
			
		public function emptyGameBoard():void 
		{
			stage.removeEventListener(Event.ENTER_FRAME, update);
			removeChild(gameBoard);
			gameBoard = null;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight,stage);
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
	}
}