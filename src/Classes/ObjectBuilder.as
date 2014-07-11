package Classes 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import Interfaces.IAnimationPart;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.IAnimationModel;
	import Interfaces.ICollisionModel;
	import Interfaces.IImmunityModel;
	import Interfaces.IInputHandling;
	import Interfaces.IStaticPhysicsModel;
	import Interfaces.IWeaponModel;
	
	import Loaders.AnimationLoader;
	import Loaders.AnimationPartLoader;
	import Loaders.GraphicLoader;
	
	import Models.Animation.PlayAnimationModel;
	import Models.Animation.PortCannonsAnimationPart;
	import Models.Animation.PortThrustAnimationModel;
	import Models.Animation.StarCannonsAnimationPart;
	import Models.Animation.StarThrustAnimationModel;
	import Models.Animation.StopAnimationModel;
	import Models.Animation.TokenAnimationModel;
	import Models.Basic.ImmunityModel;
	import Models.Collision.CannonBallCollisionModel;
	import Models.Collision.PirateShipCollisionModel;
	import Models.Collision.PlanetCollisionModel;
	import Models.Collision.TokenCollisionModel;
	import Models.Physics.PlanetPhysicsModel;
	import Models.Weapons.CannonModel;

	/**
	 * ...
	 * @author Jake
	 */
	public class ObjectBuilder 
	{
		private var gameBoard:GameBoardObjects;
		public var staticArray:Array = new Array();
		
		public function ObjectBuilder(gameBoard:GameBoardObjects) 
		{
			this.gameBoard = gameBoard;
		}
		
		
		public function buildTokenShip(inputModel:IInputHandling,x:int,y:int):PlayerObject
		{
			return addPlayer("./Images/shipThrust.swf",0,0,x,y,staticArray,inputModel,new TokenCollisionModel(),new CannonModel(gameBoard), new TokenAnimationModel(inputModel),new ImmunityModel());
		}
		public function buildPirateShip(inputModel:IInputHandling,x:int,y:int):PlayerObject
		{
			return addPlayer("./Images/PirateShip.swf",0,0,x,y,staticArray,inputModel,new PirateShipCollisionModel(),new CannonModel(gameBoard) , new StopAnimationModel(), new ImmunityModel());
		}
		public function buildTokenPlanet(x:int,y:int):StaticObject 
		{
			return addStatic("./Images/moon.swf",0,0,x,y, new PlanetCollisionModel(),new PlanetPhysicsModel());  
		}
		public function buildExplosion(x:int,y:int,scaleX:Number,scaleY:Number):MovieClip 
		{
			return addClip("./Images/explosion.swf", -321, -185, x, y, scaleX, scaleY, new StopAnimationModel());
		}
		public function buildTokenCannonBall(x:int, y:int):DynamicObject
		{
			return addDynamic("./Images/cannonball.swf", 0, 0, x, y, staticArray, new CannonBallCollisionModel(),new PlayAnimationModel());
		}
		public function buildPiratePlayer(inputModel:IInputHandling,x:int,y:int):PlayerObject
		{
			return addPiratePlayer("./Images/ShipBody.swf","./Images/ShipPortThrust.swf","./Images/ShipStarThrust.swf","./Images/ShipPortCannons.swf","./Images/ShipStarCannons.swf",0,0,x,y,staticArray,inputModel,new PirateShipCollisionModel(), new CannonModel(gameBoard), new StopAnimationModel(), new PortThrustAnimationModel(inputModel), new StarThrustAnimationModel(inputModel), new ImmunityModel());
		}
		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,staticArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,animationModel:IAnimationModel,respawnModel:IImmunityModel):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new PlayerObject(staticArray, inputModel,collisionModel, weaponModel,gameBoard,respawnModel,objInitialX,objInitialY);
			gameBoard.objectArray.push(tempSprite);                
			gameBoard.addChild(tempSprite);
			tempSprite.addChild(imageLoad);
			return tempSprite;
		}
		private function addPiratePlayer(imageLocationMain:String,imageLocationPortThrust:String,imageLocationStarThrust:String,imageLocationPortCannons:String,imageLocationStarCannons:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,staticArray:Array,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,aniModelBody:IAnimationModel,aniModelPortThrust:IAnimationModel,aniModelStarThrust:IAnimationModel,respawnModel:IImmunityModel):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoadBody:AnimationLoader;
			var imageLoadPortThrust:AnimationLoader;
			var imageLoadStarThrust:AnimationLoader;
			var imageLoadPortCannons:AnimationPartLoader;
			var imageLoadStarCannons:AnimationPartLoader;
			
			var portCannonsPart:IAnimationPart = new PortCannonsAnimationPart(weaponModel);
			var starCannonsPart:IAnimationPart = new StarCannonsAnimationPart(weaponModel);
			
			imageLoadBody = new AnimationLoader(imageLocationMain,imageOffsetX, imageOffsetY,aniModelBody);
			imageLoadPortThrust = new AnimationLoader(imageLocationPortThrust,imageOffsetX, imageOffsetY,aniModelPortThrust);
			imageLoadStarThrust = new AnimationLoader(imageLocationStarThrust,imageOffsetX, imageOffsetY,aniModelStarThrust);
			imageLoadPortCannons = new AnimationPartLoader(imageLocationPortCannons,imageOffsetX, imageOffsetY,portCannonsPart);
			imageLoadStarCannons = new AnimationPartLoader(imageLocationStarCannons,imageOffsetX, imageOffsetY,starCannonsPart);

			tempSprite = new PlayerObject(staticArray, inputModel,collisionModel,weaponModel,gameBoard,respawnModel,objInitialX,objInitialY);
			gameBoard.objectArray.push(tempSprite);                
			gameBoard.addChild(tempSprite);
			
			
			tempSprite.addChild(imageLoadPortThrust);
			tempSprite.addChild(imageLoadStarThrust);
			tempSprite.addChild(imageLoadPortCannons);
			tempSprite.addChild(imageLoadStarCannons);
			tempSprite.addChild(imageLoadBody);
			
			return tempSprite;
		}
		private function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number, staticArray:Array,collisionModel:ICollisionModel,animationModel:IAnimationModel):DynamicObject
		{
			var tempSprite:DynamicObject;
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new DynamicObject(staticArray, gameBoard, collisionModel,objInitialX,objInitialY);
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