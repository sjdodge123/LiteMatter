package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameBoard.StopWatch;
	
	
	[SWF(backgroundColor= "0x000000", width="1200", height ="900", frameRate='30')]
	public class LiteMatter extends Sprite
	{
		private var text1:TextField = new TextField();
		private var text2:TextField = new TextField();
		private var mousePoint:Point;
		
		private var stopWatch:StopWatch;
		private var deltaT:Number;
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var gameBoard:GameBoardObjects; 
		
		public function LiteMatter()
		{
			Initialize();
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		 
		private function Initialize():void
		{
			this.stageWidth = stage.stageWidth;
			this.stageHeight = stage.stageHeight;
			text2.x = stageWidth - 110;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight,stage);
			gameBoard.initializeGameObjects();
			addChild(gameBoard);
			stopWatch = new StopWatch();
			addChild(text1);
			addChild(text2);
		}
		
		public function update(e:Event):void
		{
			if ((gameBoard.ship.getRespawnCount() != 0)&&(gameBoard.ship2.getRespawnCount() != 0)) 
			{
				
			deltaT = stopWatch.calcTime();
			gameBoard.updateGameBoard(deltaT);
			
//			mousePoint = new Point(stage.mouseX,stage.mouseY);
			
			print("Player 1 lives: " +gameBoard.ship.getRespawnCount()+ "\n" + "HP: " + gameBoard.ship.getHP(), text1);
			print("Player 2 lives: " +gameBoard.ship2.getRespawnCount() + "\n" + "HP: " + gameBoard.ship2.getHP(),text2);
			}
			if (gameBoard.ship.getRespawnCount() == 0) 
			{
				print("Player 2 wins!!!!", text2);
			}
			if (gameBoard.ship2.getRespawnCount() == 0) 
			{
				print("Player 1 wins!!!!", text1);
			}
			
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
	}
}