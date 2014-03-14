package Classes
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPlayerMethods;
	import Interfaces.IStaticMethods;
	import Interfaces.IWeaponModel;

	public class PlayerObject extends DynamicObject implements IPlayerMethods
	{		
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
		private var gameBoard:GameBoardObjects;
		private var shipHitBox:GameObject;
		private var weaponModel:IWeaponModel;
		
		private var immuneDurationSeconds:Number = 5;
		private var shootImmuneDurationSeconds:Number = .1;
		private var immuneStatus:Boolean = false;
		private var immuneTimer:Timer;
		private var shotTimer:Timer;
		private var immunityBarrier:Sprite = new Sprite();
		public var immuneBorder:Sprite = new Sprite();
		
		public function PlayerObject(staticArray:Array, inputModel:IInputHandling,collisionModel:ICollisionModel,weaponModel:IWeaponModel, gameBoard:GameBoardObjects,initialX:int,initialY:int)
		{
			this.gameBoard = gameBoard;
			this.inputModel = inputModel;
			this.weaponModel = weaponModel;
			this.collisionModel = collisionModel;
			x = initialX;
			y = initialY;
			respawnX = initialX;
			respawnY = initialY;
			
			immunityBarrier.graphics.beginFill(0x8FD8D8, .25);
			immunityBarrier.graphics.drawCircle(respawnX -x , respawnY-y, 45);
			immunityBarrier.graphics.endFill()

			
			immuneBorder.graphics.beginFill(0xFFA500, .25);
			immuneBorder.graphics.drawCircle(respawnX -x , respawnY-y, 50);
			immuneBorder.graphics.endFill()
			
			immuneTimer = new Timer(immuneDurationSeconds * 1000, 1);
			shotTimer = new Timer(shootImmuneDurationSeconds * 1000, 1);
			
			immuneTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setImmunity);
			shotTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setImmunity);
			shotTimer.start();
			immuneTimer.start();
			buildModel();
		
			super(staticArray,gameBoard,collisionModel,initialX,initialY);
		}
		override public function buildModel():void
		{
			shipHitBox = collisionModel.buildModel(this);
			weaponModel.buildModel(this);
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
					shotTimer.reset();
					shotTimer.start();
					immuneStatus = true;
					weaponModel.fireWeapon(1);
			}
			if(inputModel.getFireWeaponTwo()==true)
			{
					shotTimer.reset();
					shotTimer.start();
					immuneStatus = true;
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
			showImmunityBarrier();
			immuneTimer.reset();
			immuneTimer.start();
			immuneStatus = true;
		}
		
		public function showImmunityBarrier():void
		{
			addChild(immuneBorder);
			addChild(immunityBarrier);
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
		
		private function setImmunity(e:Event):void
		{
			immuneStatus = false;
			
			if (this.contains(immuneBorder) && this.contains(immunityBarrier))
			{
				removeChild(immunityBarrier);
				removeChild(immuneBorder);
			}
		}
		
		override public function getImmuneStatus():Boolean 
		{
			return immuneStatus;
		}
		
		override public function getHitArea():GameObject
		{
			return shipHitBox;
		}
	
		public function getX():int
		{
			return this.x;
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
		
		public function getY():int
		{
			return this.y;
		}
		
		public function getStaticArray():Array
		{
			return this.staticArray;
		}
	}
}