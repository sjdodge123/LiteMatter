package Classes
{
	
	import Events.EFireCannon;
	import flash.display.MovieClip;	
	import Classes.GameBoard.GameBoardObjects;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IImmunityModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPlayerMethods;
	import Interfaces.IStaticMethods;
	import Interfaces.IWeaponModel;

	public class PlayerObject extends DynamicObject implements IPlayerMethods
	{		
		private static var shipCount:int = 0;
		private var shipId:int = 0;
		private var respawnCount:int = 5;
		private var HP:int = 100;
		private var respawnHP:int = HP;
		
		private const thrustAccelConst:Number = 180;
		public var thrustAccelX:Number = 0;
		private var thrustAccelY:Number = 0;
		private var rotAccel:Number = 0;
		private var rotAccelConst:Number = 200;
	
		
		private var velocityMax:Number = 150;
		private var velocityDirX:Number = 0;
		private var velocityDirY:Number = 0;
		private var dirX:Number = 0;
		private var dirY:Number = 0;
		
		public var inputModel:IInputHandling;
		public var collisionModel:ICollisionModel;
		private var immuneModel:IImmunityModel;
		private var gameBoard:GameBoardObjects;
		private var shipHitBox:GameObject;
		private var weaponModel:IWeaponModel;
		
		private var respawnX:int;
		private var respawnY:int;
		private var respawnsEmpty:Boolean;
		private var location:Point;
		
		public function PlayerObject(staticArray:Array, inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel, gameBoard:GameBoardObjects,immuneModel:IImmunityModel,initialX:int,initialY:int)
		{
			shipCount += 1;
			shipId = shipCount;
			this.gameBoard = gameBoard;
			this.inputModel = inputModel;
			this.weaponModel = weaponModel;
			this.collisionModel = collisionModel;
			this.immuneModel = immuneModel;
			x = initialX;
			y = initialY;
			respawnX = initialX;
			respawnY = initialY;
			location = new Point(x, y);
			buildModel();
			super(staticArray,gameBoard,collisionModel,initialX,initialY);
		}
		override public function buildModel():void
		{
			shipHitBox = collisionModel.buildModel(this);
			weaponModel.buildModel(this);
			immuneModel.buildModel(this);
		}
		
		override public function update(deltaT:Number):void
		{
			updateRotation(deltaT);
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			checkScreenBounds();
			if(checkHitStatic())
			{
				explode();
			}
			updatePlayerInput(deltaT);
			location.x = x;
			location.y = y;
			checkHitDyn(gameBoard.objectArray);
		}
		
		override public function checkHitDyn(objectArray:Array):Boolean
		{
			for(var i:int=0;i<objectArray.length;i++)
			{
				if(objectArray[i] != this && objectArray[i].isPlayer() && collisionModel.checkHit(objectArray[i]))
				{
					if (objectArray[i].getImmuneStatus() == false && !immuneModel.getImmuneStatus())
					{	
						var damageToOtherShip:int = calcDamage(this, objectArray[i]);
						objectArray[i].takeAwayHP(damageToOtherShip);
						if (objectArray[i].getHP() <= 0) 
						{
							objectArray[i].explode();
						}
						if (getHP() <= 0) 
						{
							explode();
						}
						return true;
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
			ship2.velX = ship1.getVelX() + ship2.getVelX() - (ship1.getVelX() * .25);
			ship2.velY = ship1.getVelY() + ship2.getVelY() - (ship1.getVelY() * .25);
			ship1.velX = ( -ship2.getVelX()*.25);
			ship1.velY = ( -ship2.getVelY()*.25);
			ship1.setImmuneStatus(false);
			ship2.setImmuneStatus(false);
			var ship1Mag:Number = Math.sqrt(Math.pow(ship1.getVelX(), 2) + Math.pow(ship1.getVelY(), 2));
			var ship2Mag:Number = Math.sqrt(Math.pow(ship2.getVelX(), 2) + Math.pow(ship2.getVelY(), 2));
			damageDone =((int(ship1Mag * .60)));
			takeAwayHP((int(ship2Mag * .10)));
			return damageDone;
		}
		
		override public function calcGravAccel(staticObj:IStaticMethods):void
		{
			gravAccelContribution = (staticObj.getGravityConst()/6)/Math.pow(dist,2);
			
			gravAccelX += gravAccelContribution*distX/dist;
			gravAccelY += gravAccelContribution*distY/dist;
		}
		
		public function updatePlayerInput(deltaT:Number):void
		{
			if (inputModel.getMoveForward() == true)
			{
					thrustAccelX = thrustAccelConst*dirX;
					thrustAccelY = thrustAccelConst*dirY;
			}
			
			if (inputModel.getMoveReverse() == true)
			{
					thrustAccelX = -thrustAccelConst*dirX;
					thrustAccelY = -thrustAccelConst*dirY;
			}	
			
			if (inputModel.getMoveForward()== false && inputModel.getMoveReverse() == false)
			{
				thrustAccelX = 0;
				thrustAccelY = 0;
			}
			if (inputModel.getMoveLeft() == true)
			{
				
				rotAccel = -rotAccelConst;
				
			}
			if (inputModel.getMoveRight() == true)
			{
				
				rotAccel = rotAccelConst;
			}	
			if (inputModel.getMoveLeft() == false && inputModel.getMoveRight() == false)
			{
				if (rotRate > 1)
				{
					rotAccel = -100;
				}
				if (rotRate < -1)
				{
					rotAccel =  100;
				}
				if (rotRate > -0.10 && rotRate < 0.10)
				{	
					rotRate = 0;
					rotAccel = 0;
				}
			}
			if(inputModel.getFireWeaponOne()==true)
			{
				dispatchEvent(new EFireCannon(EFireCannon.FIRE_ONE,null));
					//bulletArray.push(weaponModel.fireWeapon(1));
			}
			if(inputModel.getFireWeaponTwo()==true)
			{
				dispatchEvent(new EFireCannon(EFireCannon.FIRE_TWO,null));
					//bulletArray.push(weaponModel.fireWeapon(2));
			}
			
		}
		override public function updateVelocity(deltaT:Number):void
		{
			if (velocity < velocityMax)
			{
				velX += thrustAccelX*deltaT + gravAccelX*deltaT - .005*velX;
				velY += thrustAccelY*deltaT + gravAccelY*deltaT - .005*velY;
			}
			if (velocity > velocityMax)
			{
				velX += thrustAccelX*deltaT + gravAccelX*deltaT - .025*velX;
				velY += thrustAccelY*deltaT + gravAccelY*deltaT - .025*velY;
			}
			velocity = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
			velocityDirX = velX/velocity;
			velocityDirY = velY/velocity;
			gravAccelX = 0;
			gravAccelY = 0;

		}
		override public function updateRotation(deltaT:Number):void
		{
			rotRate += rotAccel*deltaT;
			rotationZ += rotRate*deltaT;
			dirX=Math.cos((Math.PI*rotationZ)/180);
			dirY=Math.sin((Math.PI*rotationZ)/180);
		}
		override public function respawn():void
		{
			x = respawnX;
			y = respawnY;
			gravAccelX = 0;
			gravAccelY = 0;
			thrustAccelX = 0;
			thrustAccelY = 0;
			rotAccel = 0;
			rotRate = 0;
			velocityDirX = 0;
			velocityDirY = 0;
			velocity = 0;
			velX = 0;
			velY = 0;
			HP = respawnHP;
			rotationZ = 0;
			immuneModel.resetImmuneTimer();
		}
		
		override public function explode():void
		{	
			var explosion:MovieClip = gameBoard.addExplosion(x, y,.5,.5);
			explodeSound.play();
			gameBoard.addChild(explosion);
			respawnCount--;
			if (gameBoard.contains(this) && respawnCount < 1)
			{
				gameBoard.removeObject(this);
			}
			else if (respawnCount >= 0)
			{
				respawn();
			}
		}
		
		override public function getImmuneStatus():Boolean 
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
			return HP;
		}
		public function getHP():int 
		{
			return HP;
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
			return dirY;
		}
		public function getDirX():Number
		{
			return dirX;
		}
		public function getRespawnCount():int 
		{
			return respawnCount;
		}
		public function getVelX():Number
		{
			return this.velX;
		}
		public function getLocation():Point 
		{
			return location;
		}
		
		public function getVelY():Number
		{
			return this.velY;
		}
		public function getShipId():int
		{
			return shipId;
		}	
		override public function isPlayer():Boolean
		{
			return true;
		}
	}
}