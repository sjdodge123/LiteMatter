package UI.Components
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import Classes.GameObject;
	import Classes.PlayerObject;
	
	import Events.GameBoardEvent;
	
	import Interfaces.IAnimationPart;
	import Interfaces.IInputHandling;
	import Interfaces.IWeaponModel;
	
	import Loaders.AnimationLoader;
	import Loaders.AnimationPartLoader;
	
	import Models.Animation.PirateShipAnimationModel;
	import Models.Animation.PlayAnimationModel;
	import Models.Animation.PortCannonsAnimationPart;
	import Models.Animation.PortThrustAnimationModel;
	import Models.Animation.StarCannonsAnimationPart;
	import Models.Animation.StarThrustAnimationModel;
	import Models.Animation.StopAnimationModel;
	import Models.Collision.PirateShipCollisionModel;
	import Models.Immunity.ImmunityModel;
	import Models.Physics.SelectionPhysicsModel;
	import Models.Weapons.CannonModel;
	
	import UI.ScoreBoard.ScorePage;

	public class ShipBox extends Sprite
	{
		private var page:ScorePage;
		private var shipBox:Sprite = new Sprite();
		private var inputModel:IInputHandling;
		private var gameStage:Stage;
		private var tempSprite:GameObject = new GameObject();
		public function ShipBox(x,y,page,gameStage:Stage) 
		{
			this.x = x;
			this.y = y;
			this.page = page;
			this.gameStage = gameStage;
			
		}
		
		public function reDraw(inputModel):void
		{
			if(this.contains(shipBox)) {
				removeChild(shipBox);
				this.inputModel = null;
				shipBox = null;
			}
			
			shipBox = new Sprite();
			shipBox.graphics.beginFill(this.page.getColor(),1);
			shipBox.graphics.drawRect(0,0,450,250);
			shipBox.graphics.endFill();
			this.inputModel = inputModel;
			//this.addChild(shipBox);
			if(page.getPlayerNum() == 0){
				buildShip(this.x+250,this.y+125);
			}
			if(page.getPlayerNum() == 1){
				buildShip(this.x+575,this.y+125);
			}
		}
		
		
		private function buildShip(drawX,drawY):Sprite
		{
			removeShip();
			Sprite(tempSprite);
			var weaponModel:IWeaponModel = new CannonModel();
			var imageOffsetX:Number = 0;
			var imageOffsetY:Number = 0;
			var imageLoadBody:AnimationLoader;
			var imageLoadPortThrust:AnimationLoader;
			var imageLoadStarThrust:AnimationLoader;
			var imageLoadPortCannons:AnimationPartLoader;
			var imageLoadStarCannons:AnimationPartLoader;
			
			var overLay:AnimationLoader = new AnimationLoader("./Images/indicators.swf",0,0,new PlayAnimationModel());
			var portCannonsPart:IAnimationPart = new PortCannonsAnimationPart(weaponModel);
			var starCannonsPart:IAnimationPart = new StarCannonsAnimationPart(weaponModel);
			
			
			//Spawn Animations
			imageLoadBody = new AnimationLoader("./Images/shipNEWWORK.swf",imageOffsetX, imageOffsetY,new StopAnimationModel());
			imageLoadPortThrust = new AnimationLoader("./Images/ShipPortThrust.swf",imageOffsetX, imageOffsetY, new PortThrustAnimationModel(this.inputModel));
			imageLoadStarThrust = new AnimationLoader("./Images/ShipStarThrust.swf",imageOffsetX, imageOffsetY, new StarThrustAnimationModel(this.inputModel));
			imageLoadPortCannons = new AnimationPartLoader("./Images/ShipPortCannons.swf",imageOffsetX, imageOffsetY,portCannonsPart);
			imageLoadStarCannons = new AnimationPartLoader("./Images/ShipStarCannons.swf",imageOffsetX, imageOffsetY,starCannonsPart);		
			var aniModel:PirateShipAnimationModel = new PirateShipAnimationModel(imageLoadBody,overLay,imageLoadPortThrust,imageLoadStarThrust,imageLoadPortCannons,imageLoadStarCannons);
			tempSprite = new PlayerObject(this.inputModel,new PirateShipCollisionModel(),weaponModel,new SelectionPhysicsModel(this.gameStage),new ImmunityModel(),aniModel,drawX,drawY,this.page,this.gameStage);
			tempSprite.scaleX = 3.5;
			tempSprite.scaleY = 3.5;
			dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD,tempSprite,true));
			//tempSprite.addChild(tempSprite.getHealthBar());
			return tempSprite;
		}
		
		public function removeShip():void{
			dispatchEvent(new GameBoardEvent(GameBoardEvent.REMOVE,tempSprite,true));
		}
	}
}