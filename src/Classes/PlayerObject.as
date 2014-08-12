package Classes
{
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import Classes.HealthBar;
	import Classes.GameBoard.GameBoardObjects;
	
	import Events.EFireCannon;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IImmunityModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPhysicsModel;
	import Interfaces.IWeaponModel;
	
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
		private var gameBoard:GameBoardObjects;
		private var shipHitBox:GameObject;
		private var weaponModel:IWeaponModel;
		private var scorePage:ScorePage;
		private var staticArray:Array;
		private var respawnX:int;
		private var respawnY:int;
		private var respawnsEmpty:Boolean;
		private var location:Point;
		private var canRecord:Boolean;
		private var recordTimer:Timer;
		private var shipExplode:Sound;
		private var shipRam:Sound;
		private var positionInfo:Vector.<Number>;
		
		public function PlayerObject(staticArray:Array, inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel,physicsModel:IPhysicsModel,staticArray:Array, gameBoard:GameBoardObjects,immuneModel:IImmunityModel,initialX:int,initialY:int,scorePage:ScorePage)
		{
			
			this.gameBoard = gameBoard;
			this.inputModel = inputModel;
			this.weaponModel = weaponModel;
			this.physicsModel = physicsModel;
			this.collisionModel = collisionModel;
			this.immuneModel = immuneModel;
			this.scorePage = scorePage;
			this.staticArray = staticArray;
			width = 0;
			height = 0;
			physicsModel.addEventListener(EFireCannon.FIRE_ONE,fireWeaponOne);
			physicsModel.addEventListener(EFireCannon.FIRE_TWO,fireWeaponTwo);
			shipExplode = gameBoard.soundLoader.loadSound("./Sounds/shipExplode.mp3");
			shipRam =  gameBoard.soundLoader.loadSound("./Sounds/shipRam.mp3");
			canRecord = true;
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
				x = gameBoard.gameStage.stageWidth - 50;
				y = gameBoard.gameStage.stageHeight - 50;
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
			weaponModel.buildModel(this);
			physicsModel.buildModel(staticArray,width,height,x,y,initialRotation,inputModel);
		}
		
		override public function update(deltaT:Number):void
		{
			updatePhysics(deltaT);
			if(checkHitStatic())
			{
				explode();
			}
			
			checkHitDyn(gameBoard.objectArray);
		}
		
		private function updatePhysics(deltaT:Number):void
		{
			positionInfo = physicsModel.update(deltaT);
			x = positionInfo[0];
			y = positionInfo[1];
			location.x = x;
			location.y = y;
			rotationZ = positionInfo[2];
		}
		
		public function checkHitStatic():Boolean
		{
			for(var i:int=0;i<staticArray.length;i++)
			{
				if (collisionModel.checkHit(staticArray[i]))
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
					if (objectArray[i].getImmuneStatus() == false && !immuneModel.getImmuneStatus())
					{	
						if(objectArray[i] as PlayerObject && this as PlayerObject)
						{
							var damageToOtherShip:int = calcDamage(this, objectArray[i] as PlayerObject);
							objectArray[i].takeAwayHP(damageToOtherShip);
							shipRam.play();
							if (objectArray[i].getHP() <= 0) 
							{
								recordKill(objectArray[i] as PlayerObject);
								objectArray[i].explode();
								
							}
							if (getHP() <= 0) 
							{
								objectArray[i].recordKill(this);
								explode();
								
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
			var damageDone:int;
			ship1.setImmuneStatus(true);
			ship2.setImmuneStatus(true);
			ship2.changeVelX(ship1.getVelX() + ship2.getVelX() - (ship1.getVelX() * .25));
			ship2.changeVelY(ship1.getVelY() + ship2.getVelY() - (ship1.getVelY() * .25));
			ship1.changeVelX((-ship2.getVelX()*.35)+50);
			ship1.changeVelY(( -ship2.getVelY()*.35)+50);
			ship1.setImmuneStatus(false);
			ship2.setImmuneStatus(false);
			var ship1Mag:Number = Math.sqrt(Math.pow(ship1.getVelX(), 2) + Math.pow(ship1.getVelY(), 2));
			var ship2Mag:Number = Math.sqrt(Math.pow(ship2.getVelX(), 2) + Math.pow(ship2.getVelY(), 2));
			damageDone =((int(ship1Mag * .20)));
			takeAwayHP((int(ship2Mag * .10)));
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
			canRecord = false;
			recordTimer.reset();
			recordTimer.start();
			var explosion:MovieClip = gameBoard.addExplosion(x, y,.5,.5);
			shipExplode.play();
			gameBoard.addChild(explosion);
			respawnCount--;
			scorePage.removeLife();
			if (gameBoard.contains(this) && respawnCount < 1)
			{
				gameBoard.removeObject(this);
			}
			else if (respawnCount >= 0)
			{
				respawn();
			}
		}
		
		public function fireWeaponOne(event:EFireCannon):void
		{
			weaponModel.fireWeaponOne(event);
		}
		public function fireWeaponTwo(event:EFireCannon):void
		{
			weaponModel.fireWeaponTwo(event);
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
		public function recordShot(cannonBallOne:DynamicObject,cannonBallTwo:DynamicObject):void 
		{
			scorePage.shotFired();
			cannonBallOne.setOwner(this);
			cannonBallTwo.setOwner(this);
			bulletArray.push(cannonBallOne, cannonBallTwo);
			
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
		protected function changeRecord(event:TimerEvent):void
		{
			canRecord = true;
		}
	}
}