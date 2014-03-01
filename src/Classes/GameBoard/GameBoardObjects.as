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
	
	import Models.Player1InputModel;
	

	public class GameBoardObjects extends GameObject 
	{
		public var pointArray:Array = new Array();
		public var objectArray:Array = new Array();
		public var ship:PlayerObject;
		public var planet:StaticObject;
		private var ship2:PlayerObject;
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
			planet = addStatic("../Images/Moon.png",-83.5,-83.5,300,400);  
			planet2 = addStatic("../Images/Moon.png",-83.5,-83.5,900,400);				//Static Objects need to be added first to generate the points to push into the dynamic objects
			ship = addPlayer("../Images/space ship.png",-73/2,-43/2,50,50,pointArray);         // added a new parameter to player and dynamic. They new take a pointArray. This is the array of all static object points
			asteroid =  addDynamic("../Images/asteroid.png",-73/2,-43/2,100,100, pointArray);
			
			
			collisionBuilder.createHitBox(ship,"objHitBox", 0,0,0,0,1);
			collisionBuilder.createHitBox(ship.objHitBox,"bodyHitBox", -71/2,-11,65,23,0);
			collisionBuilder.createHitBox(ship.objHitBox,"leftWingHitBox", -20,-38/2,18,10,0);
			collisionBuilder.createHitBox(ship.objHitBox,"rightWingHitBox", -20,11,18,10,0);
			collisionBuilder.createHitCircle(planet,"objHitBox",0,0,83.5,1);
		
			asteroid.velX = 200;
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
			for(var i:int=0;i<objectArray.length;i++) //This for loop cycles through all of the objects in objectArray and calls their updates. Only dynamic Objects are stored in this array.
			{
				objectArray[i].update(deltaT);
				collisionCalc();
				
			}
			
		}
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,pointArray:Array):PlayerObject
		{
			
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new PlayerObject(pointArray, new Player1InputModel);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                 // Adding on creation to the objectArray
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
			objectArray.push(tempSprite);                   // Adding on creation to the objectArray
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
			addChild(tempSprite);					// Adding on creation to the pointArray
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
	}
}