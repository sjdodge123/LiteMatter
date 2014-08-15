package Classes.GameBoard
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	
	import Classes.BasicObject;
	import Classes.GameObject;
	import Classes.ObjectBuilder;
	import Classes.PlayerObject;
	import Classes.StaticObject;
	
	import Events.GameBoardEvent;
	
	import Interfaces.IInputHandling;
	
	import Loaders.SoundLoader;
	
	import Models.Input.BasicAIModel;
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	
	import Recording.PlayBackModel;
	import Recording.Rabbit;
	
	import UI.ScoreBoard.ScorePage;
	

	public class GameBoardObjects extends GameObject 
	{
		
		public var ship:PlayerObject;
		public var ship2:PlayerObject;
		public var inputPlayer1:IInputHandling;
		public var inputPlayer2:IInputHandling;
		public var gameObjects:Vector.<GameObject>;
		private var planet:StaticObject;
		private var backGround:MovieClip;
		private var objectBuilder:ObjectBuilder;
		private var soundLoader:SoundLoader;
		private var defaultAI:BasicAIModel;
		private var staticObjects:Vector.<StaticObject>;
		private var stageWidth:int;
		private var stageHeight:int;
		private var gameStage:Stage;
		
		public function GameBoardObjects(stageWidth:int,stageHeight:int,gameStage:Stage)
		{
			gameObjects = new Vector.<GameObject>;
			staticObjects = new Vector.<StaticObject>;
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			this.gameStage = gameStage;
			objectBuilder = new ObjectBuilder(gameStage);
			objectBuilder.addEventListener(GameBoardEvent.ADD,addObject);
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
			planet = objectBuilder.buildTokenPlanet(stageWidth/2, stageHeight/2);
			planet.scaleX = .50;
			planet.scaleY = .50;
			//var planet2:StaticObject = objectBuilder.buildTokenPlanet(stageWidth-200, stageHeight-200);
			var cannonball:BasicObject = objectBuilder.buildAsteroid(stageWidth/2, (stageHeight/2)+350);
			cannonball.scaleX = .08;
			cannonball.scaleY = .08;
			cannonball.changeVelX(250);
		}
		private function addStaticObjects():void
		{
			backGround = objectBuilder.buildBackGroundImage();
			planet = objectBuilder.buildTokenPlanet(stageWidth / 2, stageHeight / 2);
		}
		private function addPlayer1(scorePage:ScorePage):void
		{
			defaultAI = new BasicAIModel(gameStage, this,staticObjects);
			if (inputPlayer1 != null) 
			{
				ship = objectBuilder.buildPiratePlayer(inputPlayer1, 50, 50, scorePage);
			}
			else 
			{
				ship = objectBuilder.buildPiratePlayer(new Player1InputModel(gameStage), 50, 50,scorePage);
			}
				
		}
		private function addCannonBall(event:GameBoardEvent):void
		{
			var player:PlayerObject = event.target as PlayerObject;
			var infoArray:Array = event.params as Array;
			var convertedPoint:Point = player.localToGlobal(infoArray[0]);
			var bulletOne:BasicObject = objectBuilder.buildTokenCannonBall(convertedPoint.x, convertedPoint.y);
			convertedPoint = player.localToGlobal(infoArray[1]);
			var bulletTwo:BasicObject = objectBuilder.buildTokenCannonBall(convertedPoint.x, convertedPoint.y);
			bulletOne.changeVelX(infoArray[2]);
			bulletOne.changeVelY(infoArray[3]);
			bulletTwo.changeVelX(infoArray[2]);
			bulletTwo.changeVelY(infoArray[3]);
			player.recordShot(bulletOne,bulletTwo);
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
		}
		public function addPlayer2HU(scorePage:ScorePage):void 
		{
			ship2 =  objectBuilder.buildPiratePlayer(inputPlayer2, stageWidth - 50, stageHeight - 50,scorePage);
		}
		
		private function deleteObject(obj:GameObject):void
		{
			gameObjects.splice(gameObjects.lastIndexOf(obj),1);
			removeChild(obj);
			obj = null;
		}
		
		
		public function updateGameBoard(deltaT:Number):void 
		{
			for(var i:int=0;i<gameObjects.length;i++) 
			{
				gameObjects[i].update(deltaT,staticObjects,gameObjects);
			}	
		}
		
		public function initializePlayBack(player1Events:Array,player2Events:Array,scorePage1:ScorePage,scorePage2:ScorePage,rabbit:Rabbit):void
		{
			inputPlayer1 = new PlayBackModel(player1Events);
			inputPlayer2 = new PlayBackModel(player2Events);
			addStaticObjects();
			addPlayer1(scorePage1);
			ship2 =  objectBuilder.buildPiratePlayer(inputPlayer2, stageWidth - 50, stageHeight - 50,scorePage2);
			PlayBackModel(inputPlayer1).setShip(ship);
			PlayBackModel(inputPlayer2).setShip(ship2);
		}
		public function addObject(event:GameBoardEvent):void
		{
			var obj:Object;
			if(event.params as GameObject)
			{
				obj =  event.params as GameObject;
				addChild(obj as GameObject);
			}
			if(event.params as MovieClip)
			{
				obj =  event.params as MovieClip;
				addChild(obj as MovieClip);
			}
			
			if(obj as BasicObject)
			{
				gameObjects.push(obj);
				obj.addEventListener(GameBoardEvent.EXPLODE,explodeObject);
				obj.addEventListener(GameBoardEvent.REMOVE,removeObjectEvent);
			}
			if( obj as PlayerObject)
			{
				gameObjects.push(obj);
				obj.addEventListener(GameBoardEvent.ADD_TO_POINT,addCannonBall);
				obj.addEventListener(GameBoardEvent.EXPLODE,explodeObject);
				obj.addEventListener(GameBoardEvent.REMOVE,removeObjectEvent);
			}
			if(obj as StaticObject)
			{
				staticObjects.push(obj);	
			}
			
		}
		
		public function removeObjectEvent(event:GameBoardEvent):void
		{
			var obj:GameObject =  GameObject(event.params);
			if(contains(obj))
			{
				if(obj as BasicObject)
				{
					deleteObject(obj);	
				}
				if(obj as PlayerObject)
				{
					deleteObject(obj);	
				}
				if(obj as StaticObject)
				{
					//TODO Delete Static Object
				}
			}
		}
		public function explodeObject(event:GameBoardEvent):void
		{
			var obj:GameObject =  GameObject(event.params);
			addChild(objectBuilder.buildExplosion(obj.x, obj.y,obj.getScale(),obj.getScale()));
		}
		public function playBack(infoArray:Array):void
		{
			gameObjects = infoArray[1];
		}
	}
}