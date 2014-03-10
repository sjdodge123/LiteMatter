package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameBoard.StopWatch;
	
	
	[SWF(backgroundColor= "0xffffff", width="1200", height ="900")]
	public class LiteMatter extends Sprite
	{
		private var text1:TextField = new TextField();
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
			stage.addEventListener(KeyboardEvent.KEY_DOWN, gameBoard.ship.inputModel.keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, gameBoard.ship.inputModel.keyReleased);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, gameBoard.ship2.inputModel.keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, gameBoard.ship2.inputModel.keyReleased);
		}
		 
		private function Initialize():void
		{
			this.stageWidth = stage.stageWidth;
			this.stageHeight = stage.stageHeight;
			gameBoard = new GameBoardObjects(stageWidth,stageHeight);
			gameBoard.initializeGameObjects();
			addChild(gameBoard);
			stopWatch = new StopWatch();
			addChild(text1);
		}
		
		public function update(e:Event):void
		{
			deltaT = stopWatch.calcTime();
			gameBoard.updateGameBoard(deltaT);
			
//			mousePoint = new Point(stage.mouseX,stage.mouseY);
			
			//print(gameBoard.ship.coolDownTime,text1);
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
	}
}