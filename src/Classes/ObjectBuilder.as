package Classes 
{
	import Classes.GameBoard.GameBoardObjects;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IInputHandling;
	import Interfaces.IStaticPhysicsModel;
	import Interfaces.IWeaponModel;
	import Interfaces.IAnimationModel;
	
	import Models.Collision.AsteriodCollisionModel;
	import Models.Collision.PlanetCollisionModel;
	import Models.Collision.ShipCollisionModel;
	import Models.Collision.CannonBallCollisionModel
	
	import Models.Physics.PlanetPhysicsModel;
	import Models.Animation.StopAnimationModel;
	import Models.Animation.TokenAnimationModel;
	import Models.Animation.PlayAnimationModel;
	
	
	import Models.Weapons.CannonModel;
	
	
	import Loaders.GraphicLoader;
	import Loaders.SoundLoader;
	import Loaders.AnimationLoader;
	/**
	 * ...
	 * @author Jake
	 */
	public class ObjectBuilder 
	{
		private var gameBoard:GameBoardObjects;
		private var staticArray:Array = new Array();
		
		public function ObjectBuilder(gameBoard:GameBoardObjects) 
		{
			this.gameBoard = gameBoard;
		}
		
		
		public function buildTokenShip(inputModel:IInputHandling,x:int,y:int):PlayerObject
		{
			return addPlayer("./Images/shipThrust.swf",0,0,x,y,staticArray,inputModel,new ShipCollisionModel(), new CannonModel(gameBoard), new TokenAnimationModel(inputModel));
		}
		public function buildTokenPlanet(x:int,y:int):StaticObject 
		{
			return addStatic("./Images/Moon.png",-83.5,-83.5,x,y, new PlanetCollisionModel(),new PlanetPhysicsModel());  
		}
		public function buildExplosion(x:int,y:int):MovieClip 
		{
			return addClip("./Images/explosion.swf", -321, -185, x, y, .5, .5, new StopAnimationModel());
		}
		public function buildTokenCannonBall(x:int, y:int):DynamicObject
		{
			return addDynamic("./Images/cannonball.swf", 0, 0, x, y, staticArray, new CannonBallCollisionModel(),new PlayAnimationModel());
		}
		
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,staticArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,animationModel:IAnimationModel):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new PlayerObject(staticArray, inputModel,collisionModel,weaponModel,gameBoard);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			gameBoard.objectArray.push(tempSprite);                
			gameBoard.addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		private function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, staticArray:Array,collisionModel:ICollisionModel,animationModel:IAnimationModel):DynamicObject
		{
			var tempSprite:DynamicObject;
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new DynamicObject(staticArray, gameBoard, collisionModel);
			tempSprite.x = objInitialX;
			tempSprite.y = objInitialY;
			gameBoard.objectArray.push(tempSprite);                  
			gameBoard.addChild(tempSprite);
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
			gameBoard.addChild(tempSprite);		
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		private function addClip(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, scaleX:Number, scaleY:Number,animationModel:IAnimationModel):MovieClip
		{
			var tempClip:MovieClip = new MovieClip();
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempClip.x = objInitialX;
			tempClip.y = objInitialY;   
			tempClip.scaleX = scaleX;
			tempClip.scaleY = scaleY;
			gameBoard.addChild(tempClip);
			tempClip.addChild(imageLoad);
			return tempClip;
		}
		
	}

}