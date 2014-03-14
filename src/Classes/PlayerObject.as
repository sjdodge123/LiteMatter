package Classes
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IImmunityModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPlayerMethods;
	import Interfaces.IStaticMethods;
	import Interfaces.IWeaponModel;

	public class PlayerObject extends DynamicObject implements IPlayerMethods
	{		
		
		private var respawnCount:int = 10;
		
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
		
		public function PlayerObject(staticArray:Array, inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel, gameBoard:GameBoardObjects,immuneModel:IImmunityModel,initialX:int,initialY:int)
		{
			this.gameBoard = gameBoard;
			this.inputModel = inputModel;
			this.weaponModel = weaponModel;
			this.collisionModel = collisionModel;
			this.immuneModel = immuneModel;
			x = initialX;
			y = initialY;
			respawnX = initialX;
			respawnY = initialY;
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
						objectArray[i].explode();
						explode();
						return true;
					}
				}
			}
			return false;
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
					immuneModel.resetShotTimer();
					weaponModel.fireWeapon(1);
			}
			if(inputModel.getFireWeaponTwo()==true)
			{
					immuneModel.resetShotTimer();
					weaponModel.fireWeapon(2);
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
			respawnCount--;
			x = respawnX;
			y = respawnY;
			gravAccelX = 0;
			gravAccelY = 0;
			thrustAccelX = 0;
			thrustAccelY = 0;
			rotAccel = 0;
			velocityDirX = 0;
			velocityDirY = 0;
			velocity = 0;
			velX = 0;
			velY = 0;
			rotationZ = 0;
			immuneModel.resetImmuneTimer();
		}
		
		override public function explode():void
		{	
			var explosion:MovieClip = gameBoard.addExplosion(x, y);
			explodeSound.play();
			gameBoard.addChild(explosion);
			if (gameBoard.contains(this) && respawnCount < 1)
			{
				gameBoard.removeObject(this);
			}
			else if (respawnCount >= 1) 
			{
				respawn();
			}
		}
		
		override public function getImmuneStatus():Boolean 
		{
			return immuneModel.getImmuneStatus();
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
		
		public function getVelY():Number
		{
			return this.velY;
		}
		
		override public function isPlayer():Boolean
		{
			return true;
		}
	}
}