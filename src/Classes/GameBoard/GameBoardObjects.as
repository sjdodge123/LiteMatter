package Classes.GameBoard
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import Classes.DynamicObject;
	import Classes.GameObject;
	import Classes.ObjectBuilder;
	import Classes.PlayerObject;
	import Classes.StaticObject;
	
	import Interfaces.IInputHandling;
	
	import Loaders.SoundLoader;
	
	import Models.Input.BasicAIModel;
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	
	import Recording.Rabbit;
	import Recording.PlayBackModel;
	
	import UI.ScoreBoard.ScorePage;
	import Events.EFireCannon;
	

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
		public var inputPlayer1:IInputHandling;
		public var inputPlayer2:IInputHandling;
		
		public function GameBoardObjects(stageWidth:int, stageHeight:int,stage:Stage)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			gameStage = stage;
			objectBuilder = new ObjectBuilder(this);
			soundLoader = new SoundLoader();
			inputPlayer1 = new Player1InputModel(gameStage);
			inputPlayer2 = new Player2InputModel(gameStage);
		}

		public function initializeGameObjects(scorePage:ScorePage): void
		{
			addStaticObjects();
			addPlayer1(scorePage);	
		}
		public function intitalizeBackgroundObjects():void 
		{
			backGround = objectBuilder.buildBackGroundImage();
			planet = objectBuilder.buildTokenPlanet(stageWidth/2, (stageHeight/2)-50);
			planet.scaleX = .50;
			planet.scaleY = .50;
			//var planet2:StaticObject = objectBuilder.buildTokenPlanet(stageWidth-200, stageHeight-200);
			var cannonball:DynamicObject = objectBuilder.buildAsteroid(stageWidth/2, (stageHeight/2)+350);
			cannonball.scaleX = .08;
			cannonball.scaleY = .08;
			cannonball.velX = 250;
		}
		private function addStaticObjects():void
		{
			backGround = objectBuilder.buildBackGroundImage();
			planet = objectBuilder.buildTokenPlanet(stageWidth / 2, stageHeight / 2);
		}
		private function addPlayer1(scorePage:ScorePage):void
		{
			defaultAI = new BasicAIModel(gameStage, this, objectBuilder.staticArray);
			if (inputPlayer1 != null) 
			{
				ship = objectBuilder.buildPiratePlayer(inputPlayer1, 50, 50, scorePage);
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
		public function checkInputType(playerNum:int):IInputHandling 
		{
			if (playerNum == 1) 
			{
				return inputPlayer1;
			}
			if (playerNum == 2) 
			{
				return inputPlayer2;
			}
			return null;
		}
		
		public function addPlayer2AI(scorePage:ScorePage):void 
		{
			inputPlayer2 = defaultAI;
			ship2 =  objectBuilder.buildPiratePlayer(inputPlayer2, stageWidth - 50, stageHeight - 50,scorePage);
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
		
		public function initializePlayBack(player1Events:Array,player2Events:Array,scorePage1:ScorePage,scorePage2:ScorePage,rabbit:Rabbit):void
		{
			inputPlayer1 = new PlayBackModel(player1Events);
			inputPlayer2 = new PlayBackModel(player2Events);
			addStaticObjects();
			addPlayer1(scorePage1);
			ship2 =  objectBuilder.buildPiratePlayer(inputPlayer2, stageWidth - 50, stageHeight - 50,scorePage2);
			ship2.initialRotation = 180;
			ship2.rotationZ= 180;
			PlayBackModel(inputPlayer1).setShip(ship);
			PlayBackModel(inputPlayer2).setShip(ship2);
		}
		
		public function playBack(infoArray:Array):void
		{
			objectArray = infoArray[1];
		}
	}
}