package Classes 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import Events.GameBoardEvent;
	
	import Interfaces.IAnimationModel;
	import Interfaces.IAnimationPart;
	import Interfaces.ICollisionModel;
	import Interfaces.IImmunityModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPhysicsModel;
	import Interfaces.IStaticPhysicsModel;
	import Interfaces.IWeaponModel;
	
	import Loaders.AnimationLoader;
	import Loaders.AnimationPartLoader;
	import Loaders.GraphicLoader;
	
	import Models.Animation.PirateShipAnimationModel;
	import Models.Animation.PlayAnimationModel;
	import Models.Animation.PlayToEndAnimationModel;
	import Models.Animation.PortCannonsAnimationPart;
	import Models.Animation.PortThrustAnimationModel;
	import Models.Animation.StarCannonsAnimationPart;
	import Models.Animation.StarThrustAnimationModel;
	import Models.Animation.StopAnimationModel;
	import Models.Animation.TokenAnimationModel;
	import Models.Collision.AsteriodCollisionModel;
	import Models.Collision.CannonBallCollisionModel;
	import Models.Collision.PirateShipCollisionModel;
	import Models.Collision.PlanetCollisionModel;
	import Models.Collision.TokenCollisionModel;
	import Models.Immunity.ImmunityModel;
	import Models.Physics.ObjectPhysicsModel;
	import Models.Physics.PlanetPhysicsModel;
	import Models.Physics.PlayerPhysicsModel;
	import Models.Weapons.CannonModel;
	import Models.Weapons.FlakModel;
	
	import UI.ScoreBoard.ScorePage;

	/**
	 * ...
	 * @author Jake
	 */
	public class ObjectBuilder extends EventDispatcher
	{
		private var stageWidth:Number;
		private var stageHeight:Number;
		private var gameStage:Stage;
		
		public function ObjectBuilder(stage:Stage) 
		{
			gameStage = stage;
		}
		
		
		public function buildTokenShip(inputModel:IInputHandling,x:int,y:int,scorePage:ScorePage):PlayerObject
		{
			return addPlayer("./Images/shipThrust.swf",0,0,x,y,inputModel,new TokenCollisionModel(),new CannonModel(), new TokenAnimationModel(inputModel),new ImmunityModel(),scorePage);
		}
		public function buildPirateShip(inputModel:IInputHandling,x:int,y:int,scorePage:ScorePage):PlayerObject
		{
			return addPlayer("./Images/PirateShip.swf",0,0,x,y,inputModel,new PirateShipCollisionModel(),new CannonModel() , new PlayToEndAnimationModel(), new ImmunityModel(),scorePage);
		}
		public function buildTokenMoon(x:int,y:int):StaticObject 
		{
			return addStatic("./Images/moon.swf",0,0,x,y,83.5, new PlanetCollisionModel(),new PlanetPhysicsModel());  
		}
		
		public function buildTokenPlanet(x:int,y:int):StaticObject
		{
			return addAnimationStatic("./Images/planet2WIP.swf",0,0,x,y,83.5, new PlanetCollisionModel(),new PlanetPhysicsModel(),new PlayAnimationModel());  
		}
		
		public function buildExplosion(x:int,y:int,scaleX:Number,scaleY:Number):MovieClip 
		{
			return addClip("./Images/explosion.swf", -321, -185, x, y, scaleX, scaleY, new PlayToEndAnimationModel());
		}
		public function buildTokenCannonBall(x:int, y:int):BasicObject
		{
			return addDynamic("./Images/cannonball.swf", 0, 0, x, y, new CannonBallCollisionModel(),new PlayAnimationModel());
		}
		public function buildAsteroid(x:int, y:int):BasicObject
		{
			return addDynamic("./Images/moon.swf", 0, 0, x, y, new AsteriodCollisionModel(),new PlayAnimationModel());
		}
		public function buildPiratePlayer(inputModel:IInputHandling,x:int,y:int,scorePage:ScorePage):PlayerObject
		{
			return addPiratePlayer("./Images/shipNEWWORK.swf","./Images/ShipPortThrust.swf","./Images/ShipStarThrust.swf","./Images/ShipPortCannons.swf","./Images/ShipStarCannons.swf",0,0,x,y,inputModel,new PirateShipCollisionModel(), new CannonModel(), new StopAnimationModel(), new PortThrustAnimationModel(inputModel), new StarThrustAnimationModel(inputModel), new ImmunityModel(),scorePage);
		}
		
		public function buildBackGroundImage():MovieClip 
		{
			return addClip("./Images/Background.swf", 0, 0, 0, 0, 1, 1, new PlayToEndAnimationModel());
		}

		private function addPlayer(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,animationModel:IAnimationModel,respawnModel:IImmunityModel,scorePage:ScorePage):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			//tempSprite = new PlayerObject(inputModel,collisionModel, weaponModel,new PlayerPhysicsModel(gameStage),respawnModel,objInitialX,objInitialY,scorePage,gameStage);
			tempSprite.addChild(imageLoad);
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempSprite));
			return tempSprite;
		}
		private function addPiratePlayer(imageLocationMain:String,imageLocationPortThrust:String,imageLocationStarThrust:String,imageLocationPortCannons:String,imageLocationStarCannons:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,aniModelBody:IAnimationModel,aniModelPortThrust:IAnimationModel,aniModelStarThrust:IAnimationModel,respawnModel:IImmunityModel,scorePage:ScorePage):PlayerObject
		{
			var tempSprite: PlayerObject;
			Sprite(tempSprite);
			var imageLoadBody:AnimationLoader;
			var imageLoadPortThrust:AnimationLoader;
			var imageLoadStarThrust:AnimationLoader;
			var imageLoadPortCannons:AnimationPartLoader;
			var imageLoadStarCannons:AnimationPartLoader;
			
			var indicators:AnimationLoader = new AnimationLoader("./Images/indicators.swf",0,0,new PlayAnimationModel());
			var portCannonsPart:IAnimationPart = new PortCannonsAnimationPart(weaponModel);
			var starCannonsPart:IAnimationPart = new StarCannonsAnimationPart(weaponModel);
			
			
			//Spawn Animations
		
			
			imageLoadBody = new AnimationLoader(imageLocationMain,imageOffsetX, imageOffsetY,aniModelBody);
			imageLoadPortThrust = new AnimationLoader(imageLocationPortThrust,imageOffsetX, imageOffsetY,aniModelPortThrust);
			imageLoadStarThrust = new AnimationLoader(imageLocationStarThrust,imageOffsetX, imageOffsetY,aniModelStarThrust);
			imageLoadPortCannons = new AnimationPartLoader(imageLocationPortCannons,imageOffsetX, imageOffsetY,portCannonsPart);
			imageLoadStarCannons = new AnimationPartLoader(imageLocationStarCannons,imageOffsetX, imageOffsetY,starCannonsPart);
			
			var aniModel:PirateShipAnimationModel = new PirateShipAnimationModel(imageLoadBody,indicators,imageLoadPortThrust,imageLoadStarThrust,imageLoadPortCannons,imageLoadStarCannons);
			tempSprite = new PlayerObject(inputModel,collisionModel,weaponModel,new PlayerPhysicsModel(gameStage),respawnModel,aniModel,objInitialX,objInitialY,scorePage,gameStage);
			//tempSprite.addChild(tempSprite.getHealthBar());
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempSprite));
			return tempSprite;
		}
	
		private function addDynamic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,collisionModel:ICollisionModel,animationModel:IAnimationModel):BasicObject
		{
			var tempSprite:BasicObject;
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new BasicObject(collisionModel,new ObjectPhysicsModel(gameStage),objInitialX,objInitialY);
			tempSprite.addChild(imageLoad);
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempSprite));
			return tempSprite;
		}
		
		private function addAnimationStatic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,radius:Number,collisionModel:ICollisionModel,physicsModel:IStaticPhysicsModel,animationModel:IAnimationModel):StaticObject
		{
			var tempSprite:StaticObject;
			var imageLoad:AnimationLoader;
			imageLoad = new AnimationLoader(imageLocation,imageOffsetX, imageOffsetY,animationModel);
			tempSprite = new StaticObject(objInitialX, objInitialY,radius,collisionModel,physicsModel);
			tempSprite.addChild(imageLoad);
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempSprite));
			return tempSprite;
		}
		
		private function addStatic(imageLocation:String, imageOffsetX:Number, imageOffsetY:Number , objInitialX:Number, objInitialY:Number,radius:Number,collisionModel:ICollisionModel,physicsModel:IStaticPhysicsModel):StaticObject
		{
			var tempSprite:StaticObject;
			var imageLoad:GraphicLoader;
			imageLoad = new GraphicLoader(imageLocation,imageOffsetX, imageOffsetY);
			tempSprite = new StaticObject(objInitialX, objInitialY,radius,collisionModel,physicsModel);
			tempSprite.addChild(imageLoad);
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempSprite));
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
			tempClip.addChild(imageLoad);
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempClip));
			return tempClip;
		}
		
	}

}