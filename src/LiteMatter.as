package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameBoard.StopWatch;
	
//	import Interfaces.IDynamicMethods;
//	import Interfaces.IObjectMethods;
//	import Interfaces.IPlayerMethods;
//	import Interfaces.IStaticMethods;
	
	[SWF(backgroundColor= "0xffffff", width="1200", height ="900")]
	public class LiteMatter extends Sprite
	{
		private var text1:TextField = new TextField();
		private var mousePoint:Point;
		
		private var stopWatch:StopWatch;
		private var deltaT:Number;
		private var gameBoard:GameBoardObjects = new GameBoardObjects();
		
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
			gameBoard.initializeGameObjects();
			addChild(gameBoard);
			stopWatch = new StopWatch();
			addChild(text1);
		}
		
		
		public function update(e:Event):void
		{
			deltaT = stopWatch.calcTime();
			gameBoard.updateGameBoard(deltaT);
//			gameBoard.planet.updateGravity();
//			gameBoard.planet2.updateGravity();
//			mousePoint = new Point(stage.mouseX,stage.mouseY);
			
			
			print("Astroid hit = " + gameBoard.asteroid.hit, text1);
		}
		
		public function print(o:Object, field:TextField):void
		{
			field.text = o.toString();
		}
	}
}