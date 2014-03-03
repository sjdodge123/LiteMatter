package Classes.GameBoard
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import Classes.CollisionBuilder;
	import Classes.CollisionEngine;
	import Classes.DynamicObject;
	import Classes.GameObject;
	import Classes.PlayerObject;
	import Classes.StaticObject;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IInputHandling;
	
	import Models.Player1InputModel;
	import Models.Player2InputModel;
	import Models.ShipCollisionModel;
	import Models.PlanetCollisionModel;
	

	public class GameBoardObjects extends GameObject 
	{
		public var staticArray:Array = new Array();
		public var objectArray:Array = new Array();
		public var ship:PlayerObject;
		public var planet:StaticObject;
		public var ship2:PlayerObject;
		private var asteroid:DynamicObject;
		private var collisionBuilder:CollisionBuilder;
		private var collisionEngine:CollisionEngine;
		
		public var mousePoint:Point;
		
		public var testHit:Boolean = false;
		private var planet2:StaticObject;
		
		
		public function GameBoardObjects()
		{
			collisionBuilder = new CollisionBuilder();
			collisionEngine = new CollisionEngine();
		}

		public function initializeGameObjects(): void
		{
			addStaticObjects();
			addDynamicObjects();	
		}
		private function addStaticObjects():void
		{
			planet = addStatic("../Images/Moon.png",-83.5,-83.5,600,400, new PlanetCollisionModel());  
			//planet2 = addStatic("../Images/Moon.png",-83.5,-83.5,900,400);
		}
		private function addDynamicObjects():void
		{
			ship = addPlayer("../Images/space ship.png",-73/2,-43/2,50,50,staticArray, new Player1InputModel(),new ShipCollisionModel(),this);  
			ship2 = addPlayer("../Images/space ship.png",-73/2,-43/2,100,50,staticArray, new Player2InputModel(),new ShipCollisionModel(),this);
			asteroid =  addDynamic("../Images/asteroid.png",-73/2,-43/2,100,100, staticArray);
			asteroid.velX = 200;
		}
		
		
		public function updateGameBoard(deltaT:Number):void 
		{
			mousePoint = new Point(mouseX,mouseY);
			for(var i:int=0;i<objectArray.length;i++) 
			{
				objectArray[i].update(deltaT);
			}	
		}
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,pointArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel, gameBoard:GameBoardObjects):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new PlayerObject(pointArray, inputModel,collisionModel, gameBoard);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                
			addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		private function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, pointArray:Array):DynamicObject
		{
			var tempSprite:DynamicObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new DynamicObject(pointArray);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                  
			addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		private function addStatic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,collisionModel:ICollisionModel):StaticObject
		{
			var tempSprite:StaticObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new StaticObject(objInitialX, objInitialY,collisionModel);
			staticArray.push(tempSprite);   
			addChild(tempSprite);		
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
	}
}