package Classes
{
	
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import Classes.HealthBar;
	
	import Events.EFireCannon;
	import Events.GameBoardEvent;
	import Events.PageEvent;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IImmunityModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPhysicsModel;
	import Interfaces.IWeaponModel;
	
	import Loaders.SoundLoader;
	
	import UI.ScoreBoard.ScorePage;

	public class PlayerObject extends GameObject
	{		
		private var shipId:int = 0;
		private var playerColor:uint;
		private var respawnCount:int;
		private var HP:int = 100;
		private var respawnHP:int = HP;
	
		public var bulletArray:Array;
		private var healthBar:HealthBar;
		private var initialRotation:int = 0;
		private var inputModel:IInputHandling;
		private var collisionModel:ICollisionModel;
		private var physicsModel:IPhysicsModel;
		private var immuneModel:IImmunityModel;
		private var shipHitBox:GameObject;
		private var weaponModel:IWeaponModel;
		private var scorePage:ScorePage;
		private var respawnX:int;
		private var respawnY:int;
		private var respawnsEmpty:Boolean;
		private var location:Point;
		private var canRecord:Boolean;
		private var recordTimer:Timer;
		private var shipExplode:Sound;
		private var shipRam:Sound;
		private var positionInfo:Vector.<Number>;
		private var soundLoader:SoundLoader;
		private var gameStage:Stage;
		private var gameObjects:Vector.<GameObject>;
		private var colOkay:Boolean = true;
		private var colTimer:Timer;
		
		public function PlayerObject(inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,physicsModel:IPhysicsModel,immuneModel:IImmunityModel,initialX:int,initialY:int,scorePage:ScorePage,stage:Stage)
		{
			this.inputModel = inputModel;
			this.weaponModel = weaponModel;
			this.physicsModel = physicsModel;
			this.collisionModel = collisionModel;
			this.immuneModel = immuneModel;
			this.scorePage = scorePage;
			this.gameStage = stage;
			soundLoader = new SoundLoader();
			width = 0;
			height = 0;
			physicsModel.addEventListener(EFireCannon.FIRE_ONE,fireWeaponOne);
			physicsModel.addEventListener(EFireCannon.FIRE_TWO,fireWeaponTwo);
			weaponModel.addEventListener(PageEvent.SHOT_FIRED,recordShot)
			weaponModel.addEventListener(GameBoardEvent.ADD_TO_POINT,addShot)
			shipExplode = soundLoader.loadSound("./Sounds/shipExplode.mp3");
			shipRam =  soundLoader.loadSound("./Sounds/shipRam.mp3");
			canRecord = true;
			colTimer = new Timer(500,1);
			colTimer.addEventListener(TimerEvent.TIMER_COMPLETE,changeColOkay);
			recordTimer = new Timer(100,1);
			recordTimer.addEventListener(TimerEvent.TIMER_COMPLETE,changeRecord);
			if (inputModel.getInputType() == 1) 
			{
				scorePage.setPlayerName("Easy Computer");
			}
			x = initialX;
			y = initialY;
			respawnX = initialX;
			respawnY = initialY;
			
			location = new Point(x, y);
			respawnCount = scorePage.getLives();
			shipId = scorePage.getPlayerNum();
			if(shipId+1 == 2)
			{
				initialRotation = 180;
				rotationZ = initialRotation;
				x = gameStage.stageWidth - 50;
				y = gameStage.stageHeight - 50;
			}
			playerColor = scorePage.getColor();
			bulletArray = new Array();
			healthBar = new HealthBar(respawnHP, playerColor);
			buildModel();
		}
		
		
		
		public function buildModel():void
		{
			shipHitBox = collisionModel.buildModel(this);
			immuneModel.buildModel(this);
			physicsModel.buildModel(width,height,x,y,initialRotation,inputModel);
		}
		
		override public function update(deltaT:Number,staticObjects:Vector.<StaticObject>,gameObjects:Vector.<GameObject>):void
		{
			this.gameObjects = gameObjects;
			checkHitDyn(gameObjects);
			updatePhysics(deltaT,staticObjects);
			if(checkHitStatic(staticObjects))
			{
				explode();
			}
			
		}
		
		private function updatePhysics(deltaT:Number,staticObjects:Vector.<StaticObject>):void
		{
			positionInfo = physicsModel.update(deltaT,staticObjects);
			x = positionInfo[0];
			y = positionInfo[1];
			location.x = x;
			location.y = y;
			rotationZ = positionInfo[2];
		}
		
		public function checkHitStatic(staticObjects:Vector.<StaticObject>):Boolean
		{
			for(var i:int=0;i<staticObjects.length;i++)
			{
				if (collisionModel.checkHit(staticObjects[i]))
				{
					this.scorePage.addDeathByPlanet();
					return true
				}
			}
			return false;
		}
		public function checkHitDyn(objectArray:Vector.<GameObject>):Boolean
		{
			for(var i:int=0;i<objectArray.length;i++)
			{
				if(objectArray[i] != this && objectArray[i] as PlayerObject && collisionModel.checkHit(objectArray[i]))
				{
					if (objectArray[i].getImmuneStatus() == false && immuneModel.getImmuneStatus() == false)
					{	
						if(colOkay && objectArray[i] as PlayerObject && this as PlayerObject)
						{
							colOkay = false;
							colTimer.reset();
							colTimer.start();
							var damageToOtherShip:int = calcDamage(this, objectArray[i] as PlayerObject);
							trace("Ship " + scorePage.getPlayerNum() +" hit Ship " + PlayerObject(objectArray[i]).scorePage.getPlayerNum());
							objectArray[i].takeAwayHP(damageToOtherShip);
							shipRam.play();
							if (getHP() <= 0) 
							{
								objectArray[i].recordKill(this);
								explode();
								
							}
							if (objectArray[i].getHP() <= 0) 
							{
								recordKill(objectArray[i] as PlayerObject);
								objectArray[i].explode();
								
							}
							return true;
						}
					}
				}
			}
			return false;
		}
		
		private function calcDamage(ship1:PlayerObject, ship2:PlayerObject):int
		{
			var damageDone:int = 0;
			
			//Update Ship 2
			ship2.changeVelX(ship1.getVelX()/2- ship2.getVelX()); //* .65));
			ship2.changeVelY(ship1.getVelY()/2 - ship2.getVelY()); //* .65));
			
			//Update Ship 1
			ship1.changeVelX((-ship2.getVelX()));
			ship1.changeVelY((-ship2.getVelY()));
			
			var ship1Mag:Number = Math.sqrt(Math.pow(ship1.getVelX(), 2) + Math.pow(ship1.getVelY(), 2));
			var ship2Mag:Number = Math.sqrt(Math.pow(ship2.getVelX(), 2) + Math.pow(ship2.getVelY(), 2));
			damageDone =((int(ship1Mag * .25)));
			takeAwayHP((int(ship2Mag * .125 )));
			return damageDone;
		}
		
		public function respawn():void
		{
			x = respawnX;
			y = respawnY;
			rotationZ = initialRotation;
			physicsModel.resetPhysics(x,y,rotationZ);
			HP = respawnHP;
			healthBar.updateHealthBar(respawnHP);
			immuneModel.resetImmuneTimer();
		}
		
		public function explode():void
		{	
			dispatchEvent(new GameBoardEvent(GameBoardEvent.EXPLODE,this));
			canRecord = false;
			recordTimer.reset();
			recordTimer.start();
			shipExplode.play();
			respawnCount--;
			scorePage.removeLife();
			if (respawnCount < 1)
			{
				dispatchEvent(new GameBoardEvent(GameBoardEvent.REMOVE,this));
			}
			else if (respawnCount >= 0)
			{
				respawn();
			}
		}
		
		public function fireWeaponOne(event:EFireCannon):void
		{
			var travelInfo:Vector.<Number> = new Vector.<Number>;
			travelInfo.push(getDirX());
			travelInfo.push(getDirY());
			travelInfo.push(getVelX());
			travelInfo.push(getVelY());
			weaponModel.fireWeaponOne(travelInfo);
		}
		public function fireWeaponTwo(event:EFireCannon):void
		{
			var travelInfo:Vector.<Number> = new Vector.<Number>;
			travelInfo.push(getDirX());
			travelInfo.push(getDirY());
			travelInfo.push(getVelX());
			travelInfo.push(getVelY());
			weaponModel.fireWeaponTwo(travelInfo);
		}
		
		public function getImmuneStatus():Boolean 
		{
			return immuneModel.getImmuneStatus();
		}
		public function setImmuneStatus(value:Boolean):void 
		{
			immuneModel.setImmuneStatus(value);
		}
		public function takeAwayHP(i:int):int
		{
			this.HP -= i;
			healthBar.updateHealthBar(this.HP);
			return this.HP;
		}
		public function getHP():int 
		{
			return HP;
		}
		public function setHP(hp:int):void
		{
			this.HP = hp;
			healthBar.updateHealthBar(this.HP);
		}
		public function getCollisionPoint():Point 
		{
			return collisionModel.getCollisionPoint();
		}
		override public function getHitArea():GameObject
		{
			return shipHitBox;
		}
			
		public function getDirY():Number
		{
			return physicsModel.getDirY();
		}
		public function getDirX():Number
		{
			return physicsModel.getDirX();
		}
		public function getRespawnCount():int 
		{
			return respawnCount;
		}
		public function setRespawnCount(value:int):void
		{
			respawnCount = value;
		}
		public function getVelX():Number
		{
			return  physicsModel.getVelX();
		}
		public function getLocation():Point 
		{
			return location;
		}
		
		public function getVelY():Number
		{
			return physicsModel.getVelY();
		}
		public function getShipId():int
		{
			return shipId;
		}
		public function isPlayer():Boolean
		{
			return true;
		}
		public function recordShot(bulletOne:BasicObject,bulletTwo:BasicObject):void 
		{
			scorePage.shotFired();
			bulletOne.setOwner(this);
			bulletTwo.setOwner(this);
			bulletArray.push(bulletOne ,bulletTwo);	
		}
		private function addShot(event:GameBoardEvent):void 
		{
			dispatchEvent(event);
		}
		public function recordHit(victim:PlayerObject):void 
		{
			if (victim != this) 
			{
				scorePage.addHit();
			}
		}
		public function recordKill(victim:PlayerObject):void 
		{
			if (victim != this) 
			{
				scorePage.addKill();
			}
			else 
			{
				scorePage.addSuicide();
			}
		}
		public function getHealthBar():HealthBar 
		{
			return healthBar;
		}
		
		public function getImmuneModel():Boolean
		{
			return immuneModel.getImmuneStatus();
		}
		
		public function setImmuneModel(newModel:Boolean):void
		{
			immuneModel.setImmuneStatus(newModel);
		}
		
		public function getCanRecord():Boolean
		{
			return canRecord;
		}
		public function changeVelX(value:Number):void
		{
			physicsModel.changeVelX(value);
		}
		public function changeVelY(value:Number):void
		{
			physicsModel.changeVelY(value);
		}
		public function fireOne(value:Boolean):void
		{
			if(value)
			{
				dispatchEvent(new EFireCannon(EFireCannon.FIRE_ONE, null));
			}
		}
		public function fireTwo(value:Boolean):void
		{
			if(value)
			{
				dispatchEvent(new EFireCannon(EFireCannon.FIRE_TWO, null));
			}
		}
		override public function getScale():Number
		{
			return .5;
		}
		protected function changeRecord(event:TimerEvent):void
		{
			canRecord = true;
		}
		protected function changeColOkay(event:TimerEvent):void
		{
			colOkay = true;
		}
	}
}