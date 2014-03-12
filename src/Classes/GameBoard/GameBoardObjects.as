package Classes.GameBoard
{
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

	import Loaders.GraphicLoader;
	import Loaders.SoundLoader;
	import Loaders.AnimationLoader;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IInputHandling;
	import Interfaces.IStaticPhysicsModel;
	import Interfaces.IWeaponModel;
	import Interfaces.IAnimationModel;
	
	import Models.Collision.AsteriodCollisionModel;
	import Models.Collision.PlanetCollisionModel;
	import Models.Collision.ShipCollisionModel;
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Physics.PlanetPhysicsModel;
	import Models.Weapons.CannonModel;
	import Models.Animation.TokenAnimationModel;
	

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
		private var gameStage:Stage;
		public var soundLoader:SoundLoader;
		
		public function GameBoardObjects(stageWidth:int, stageHeight:int,stage:Stage)
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			gameStage = stage;
			collisionBuilder = new CollisionBuilder();
			soundLoader =  new SoundLoader();
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
			ship = buildTokenShip(new Player1InputModel(gameStage), 50, 50);
			ship2 =  buildTokenShip(new Player2InputModel(gameStage), stageWidth-50,stageHeight-50);
		}
		
		public function removeObject(obj:GameObject):void
		{
			index = objectArray.lastIndexOf(obj);
			objectArray.splice(index,1);
			removeChild(obj);
		}
		
		public function buildTokenShip(inputModel:IInputHandling,x:int,y:int):PlayerObject
		{
			return addPlayer("./Images/shipThrust.swf",0,0,x,y,staticArray,inputModel,new ShipCollisionModel(), new CannonModel(this), new TokenAnimationModel(inputModel));
		}
		
		
		public function updateGameBoard(deltaT:Number):void 
		{
			mousePoint = new Point(mouseX,mouseY);
			for(var i:int=0;i<objectArray.length;i++) 
			{
				objectArray[i].update(deltaT);
			}	
		}
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,staticArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,animationModel:IAnimationModel):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new PlayerObject(staticArray, inputModel,collisionModel,weaponModel,this);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			objectArray.push(tempSprite);                
			addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		public function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, staticArray:Array,collisionModel:ICollisionModel,animationModel:IAnimationModel):DynamicObject
		{
			var tempSprite:DynamicObject;
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
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
		public function addClip(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, scaleX:Number, scaleY:Number,animationModel:IAnimationModel):MovieClip
		{
			var tempClip:MovieClip = new MovieClip();
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
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