package Classes.GameBoard
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import Interfaces.IInputHandling;
	import Interfaces.IObjectMethods;
	import Models.Input.BasicAIModel;
	import UI.ScoreBoard.ScorePage;
	
	import Classes.DynamicObject;
	import Classes.GameObject;
	import Classes.ObjectBuilder;
	import Classes.PlayerObject;
	import Classes.StaticObject;
	
	import Loaders.SoundLoader;
	
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Weapons.CannonModel;
	

	public class GameBoardObjects extends GameObject 
	{
		public var objectArray:Array = new Array();
		public var ship:PlayerObject;
		public var ship2:PlayerObject;
		private var planet:StaticObject;
		public var stageWidth:int;
		public var stageHeight:int;
		private var gameStage:Stage;
		private var backGround:MovieClip;
		private var objectBuilder:ObjectBuilder;
		public var soundLoader:SoundLoader;
		private var defaultAI:BasicAIModel;
		private var inputPlayer1:IInputHandling;
		private var inputPlayer2:IInputHandling;
		
		public function GameBoardObjects(stageWidth:int, stageHeight:int,stage:Stage)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			gameStage = stage;
			objectBuilder = new ObjectBuilder(this);
			soundLoader = new SoundLoader();
			inputPlayer2 = new Player2InputModel(gameStage);
		}

		public function initializeGameObjects(scorePage:ScorePage): void
		{
			addStaticObjects();
			addDynamicObjects(scorePage);	
		}
		private function addStaticObjects():void
		{
			backGround = objectBuilder.buildBackGroundImage();
			planet = objectBuilder.buildTokenPlanet(stageWidth / 2, stageHeight / 2);
		}
		private function addDynamicObjects(scorePage:ScorePage):void
		{
			defaultAI = new BasicAIModel(gameStage, this, objectBuilder.staticArray);
			if (inputPlayer1 != null) 
			{
				ship = objectBuilder.buildPiratePlayer(inputPlayer1, 50, 50,scorePage);
			}
			else 
			{
				ship = objectBuilder.buildPiratePlayer(new Player1InputModel(gameStage), 50, 50,scorePage);
			}
				
		}
		public function addExplosion(x:int,y:int,scaleX:Number,scaleY:Number):MovieClip
		{
			return objectBuilder.buildExplosion(x, y,scaleX,scaleY);
		}
		public function addCannonBall(x:int,y:int):DynamicObject
		{
			return objectBuilder.buildTokenCannonBall(x, y);
		}
		public function changeInputType(playerNum:int,inputType:IInputHandling):void 
		{
			if (playerNum == 1) 
			{
				inputPlayer1 = inputType;
			}
			if (playerNum == 2) 
			{
				inputPlayer2 = inputType;
			}
		}
		
		public function addPlayer2AI(scorePage:ScorePage):void 
		{
			ship2 =  objectBuilder.buildPiratePlayer(defaultAI, stageWidth - 50, stageHeight - 50,scorePage);
			defaultAI.buildModel(ship2);
			ship2.initialRotation = 180;
			ship2.rotationZ= 180;
		}
		public function addPlayer2HU(scorePage:ScorePage):void 
		{
			ship2 =  objectBuilder.buildPiratePlayer(inputPlayer2, stageWidth - 50, stageHeight - 50,scorePage);
			ship2.initialRotation = 180;
			ship2.rotationZ= 180;
		}
		
		public function removeObject(obj:GameObject):void
		{
			objectArray.splice(objectArray.lastIndexOf(obj),1);
			removeChild(obj);
			obj = null;
		}
		
		
		public function updateGameBoard(deltaT:Number):void 
		{
			//mousePoint = new Point(mouseX,mouseY);
			for(var i:int=0;i<objectArray.length;i++) 
			{
				objectArray[i].update(deltaT);
			}	
		}
		
	}
}