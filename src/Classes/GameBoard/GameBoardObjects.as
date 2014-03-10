package Classes.GameBoard
{
	import flash.display.MovieClip;
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
	import Interfaces.IStaticPhysicsModel;
	import Interfaces.IWeaponModel;
	
	import Models.Collision.AsteriodCollisionModel;
	import Models.Collision.PlanetCollisionModel;
	import Models.Collision.ShipCollisionModel;
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Physics.PlanetPhysicsModel;
	import Models.Weapons.CannonModel;
	

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
		public var stageWidth:int;
		public var stageHeight:int;
		public var index:int;
		
		public function GameBoardObjects(stageWidth:int, stageHeight:int)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
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
			planet = addStatic("./Images/Moon.png",-83.5,-83.5,stageWidth/2,stageHeight/2, new PlanetCollisionModel(),new PlanetPhysicsModel());  

		}
		private function addDynamicObjects():void
		{
			ship = addPlayer("./Images/space ship.png",-73/2,-43/2,50,50,staticArray, new Player1InputModel(),new ShipCollisionModel(), new CannonModel(this));  
			ship2 = addPlayer("./Images/space ship.png",-73/2,-43/2,stageWidth-50,stageHeight-50,staticArray, new Player2InputModel(),new ShipCollisionModel(), new CannonModel(this));
			asteroid =  addDynamic("./Images/asteroid.png",-10,-10,100,100, staticArray,new AsteriodCollisionModel());
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
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,staticArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new PlayerObject(staticArray, inputModel,collisionModel,weaponModel,this);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                
			addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		public function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, staticArray:Array,collisionModel:ICollisionModel):DynamicObject
		{
			var tempSprite:DynamicObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new DynamicObject(staticArray, this, collisionModel);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                  
			addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		private function addStatic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,collisionModel:ICollisionModel,physicsModel:IStaticPhysicsModel):StaticObject
		{
			var tempSprite:StaticObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new StaticObject(objInitialX, objInitialY,collisionModel,physicsModel);
			staticArray.push(tempSprite);   
			addChild(tempSprite);		
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		public function addClip(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, scaleX:Number, scaleY:Number):MovieClip
		{
			var tempClip:MovieClip = new MovieClip();
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempClip.x = objInitialX;
			tempClip.y = objInitialY;   
			tempClip.scaleX = scaleX;
			tempClip.scaleY = scaleY;
			addChild(tempClip);
			tempClip.addChild(imageLoad);
			return tempClip;
		}
	}
}