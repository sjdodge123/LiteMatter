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
	
	import Models.AsteriodCollisionModel;
	import Models.PlanetCollisionModel;
	import Models.Player1InputModel;
	import Models.Player2InputModel;
	import Models.ShipCollisionModel;
	

	public class GameBoardObjects extends GameObject 
	{
		public var staticArray:Array = new Array();
		public var objectArray:Array = new Array();
		public var ship:PlayerObject;
		public var planet:StaticObject;
		public var ship2:PlayerObject;
		public var asteroid:DynamicObject;
		private var collisionBuilder:CollisionBuilder;
		private var collisionEngine:CollisionEngine;
		
		public var mousePoint:Point;
		
		public var testHit:Boolean = false;
		private var planet2:StaticObject;
		private var planet3:StaticObject;
		private var planet4:StaticObject;
		public var index:int;
		
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
			planet = addStatic("../Images/Moon.png",-83.5,-83.5,300,400, new PlanetCollisionModel());  
			planet2 = addStatic("../Images/Moon.png",-83.5,-83.5,900,400, new PlanetCollisionModel());
			planet3 = addStatic("../Images/Moon.png",-83.5,-83.5,600,100, new PlanetCollisionModel());
			planet4 = addStatic("../Images/Moon.png",-83.5,-83.5,600,700, new PlanetCollisionModel());

		}
		private function addDynamicObjects():void
		{
			ship = addPlayer("../Images/space ship.png",-73/2,-43/2,50,50,staticArray, new Player1InputModel(),new ShipCollisionModel());  
			ship2 = addPlayer("../Images/space ship.png",-73/2,-43/2,100,50,staticArray, new Player2InputModel(),new ShipCollisionModel());
			asteroid =  addDynamic("../Images/asteroid.png",-10,-10,100,100, staticArray,new AsteriodCollisionModel());
			asteroid.velX = 250;
		}
		
		public function removeObject(obj:GameObject):void
		{
			index = objectArray.lastIndexOf(obj);
			objectArray.splice(index,1);
			removeChild(obj);
		}
		
		
		public function updateGameBoard(deltaT:Number):void 
		{
			mousePoint = new Point(mouseX,mouseY);
			for(var i:int=0;i<objectArray.length;i++) 
			{
				objectArray[i].update(deltaT);
			}	
		}
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,pointArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new PlayerObject(pointArray, inputModel,collisionModel, this);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                
			addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		public function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, pointArray:Array,collisionModel:ICollisionModel):DynamicObject
		{
			var tempSprite:DynamicObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new DynamicObject(pointArray, this, collisionModel);
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