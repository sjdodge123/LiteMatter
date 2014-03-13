package Classes.GameBoard
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	
	import Classes.CollisionBuilder;
	import Classes.CollisionEngine;
	import Classes.DynamicObject;
	import Classes.GameObject;
	import Classes.PlayerObject;
	import Classes.StaticObject;
	import Classes.ObjectBuilder;

	import Loaders.GraphicLoader;
	import Loaders.SoundLoader;
	import Loaders.AnimationLoader;
	
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Physics.PlanetPhysicsModel;
	import Models.Animation.TokenAnimationModel;
	

	public class GameBoardObjects extends GameObject 
	{
		public var objectArray:Array = new Array();
		public var ship:PlayerObject;
		private var ship2:PlayerObject;
		private var planet:StaticObject;
		
		public var stageWidth:int;
		public var stageHeight:int;
		private var gameStage:Stage;
		private var objectBuilder:ObjectBuilder;
		public var soundLoader:SoundLoader;
		
		public function GameBoardObjects(stageWidth:int, stageHeight:int,stage:Stage)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			gameStage = stage;
			objectBuilder = new ObjectBuilder(this);
			soundLoader = new SoundLoader();
		}

		public function initializeGameObjects(): void
		{
			addStaticObjects();
			addDynamicObjects();	
		}
		private function addStaticObjects():void
		{
			planet = objectBuilder.buildTokenPlanet(stageWidth / 2, stageHeight / 2);
		}
		private function addDynamicObjects():void
		{
			ship = objectBuilder.buildTokenShip(new Player1InputModel(gameStage), 50, 50);
			ship2 =  objectBuilder.buildTokenShip(new Player2InputModel(gameStage), stageWidth - 50, stageHeight - 50);
		}
		
		public function addExplosion(x:int,y:int):MovieClip
		{
			return objectBuilder.buildExplosion(x, y);
		}
		public function addCannonBall(x:int,y:int):DynamicObject
		{
			return objectBuilder.buildTokenCannonBall(x, y);
		}
		
		public function removeObject(obj:GameObject):void
		{
			objectArray.splice(objectArray.lastIndexOf(obj),1);
			removeChild(obj);
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