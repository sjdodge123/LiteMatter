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
	
	import Interfaces.IInputHandling;
	
	import Models.Player1InputModel;
	import Models.Player2InputModel;
	

	public class GameBoardObjects extends GameObject 
	{
		public var pointArray:Array = new Array();
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
	
			collisionBuilder.createHitBox(ship,"objHitBox", 0,0,0,0,0);
			collisionBuilder.createHitBox(ship.objHitBox,"bodyHitBox", -71/2,-11,65,23,0);
			collisionBuilder.createHitBox(ship.objHitBox,"leftWingHitBox", -20,-38/2,18,10,0);
			collisionBuilder.createHitBox(ship.objHitBox,"rightWingHitBox", -20,11,18,10,0);
			collisionBuilder.createHitCircle(planet,"objHitBox",0,0,83.5,0);
		
			asteroid.velX = 200;
		}
		
		private function addDynamicObjects():void
		{
			ship = addPlayer("../Images/space ship.png",-73/2,-43/2,50,50,pointArray, new Player1InputModel(),this);  
			ship2 = addPlayer("../Images/space ship.png",-73/2,-43/2,100,50,pointArray, new Player2InputModel(),this);
			asteroid =  addDynamic("../Images/asteroid.png",-73/2,-43/2,100,100, pointArray);				
		}
		
		private function addStaticObjects():void
		{
			planet = addStatic("../Images/Moon.png",-83.5,-83.5,600,400);  
			//planet2 = addStatic("../Images/Moon.png",-83.5,-83.5,900,400);
		}
		
		private function collisionCalc():void
		{
			if(collisionEngine.testGeneralCollision(ship,"objHitBox",planet,"objHitBox"))
			{
				testHit = true;
			}
			else
			{
				testHit = false;
			}
		}
		
		public function updateGameBoard(deltaT:Number):void 
		{
			mousePoint = new Point(mouseX,mouseY);
			for(var i:int=0;i<objectArray.length;i++) 
			{
				objectArray[i].update(deltaT);
				collisionCalc();
				
			}
			
		}
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,pointArray:Array,inputModel:IInputHandling, gameBoard:GameBoardObjects):PlayerObject
		{
			
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new PlayerObject(pointArray, inputModel, gameBoard);
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
		private function addStatic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number):StaticObject
		{
			var tempSprite:StaticObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new StaticObject(objInitialX, objInitialY);
			pointArray.push(tempSprite.position);   
			addChild(tempSprite);		
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
	}
}