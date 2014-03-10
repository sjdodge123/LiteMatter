package Classes
{
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.ICollisionModel;
	import Interfaces.IInputHandling;
	import Interfaces.IPlayerMethods;
	import Interfaces.IStaticMethods;
	
	import Models.Collision.AsteriodCollisionModel;


	public class PlayerObject extends DynamicObject implements IPlayerMethods
	{		
		private const thrustAccelConst:Number = 40;
		public var thrustAccelX:Number = 0;
		private var thrustAccelY:Number = 0;
		private var rotAccel:Number = 0;
		private var rotJerk:Number = 15;
		
		private var velocityMax:Number = 120;
		private var velocityDirX:Number = 0;
		private var velocityDirY:Number = 0;
		private var dirX:Number = 1;
		private var dirY:Number = 0;
		
		public var inputModel:IInputHandling;
		public var collisionModel:ICollisionModel;
		private var gameBoard:GameBoardObjects;
		private var shipHitBox:GameObject;
		
		public function PlayerObject(staticArray:Array, inputModel:IInputHandling,collisionModel:ICollisionModel, gameBoard:GameBoardObjects)
		{
			this.gameBoard = gameBoard;
			this.inputModel = inputModel;
			this.collisionModel = collisionModel;
			buildModel();
			super(staticArray,gameBoard,collisionModel);
		}
		override public function buildModel():void
		{
			shipHitBox = collisionModel.buildModel(this);
		}
		
		override public function update(deltaT:Number):void
		{
			updatePlayerInput(deltaT);
			updateRotation(deltaT);
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			checkScreenBounds();
			if(checkHitStatic())
			{
				explode();
			}
		}
		override public function calcGravAccel(staticObj:IStaticMethods):void
		{
			gravAccelContribution = (staticObj.getGravityConst()/10)/Math.pow(dist,2);
			
			gravAccelX += gravAccelContribution*distX/dist;
			gravAccelY += gravAccelContribution*distY/dist;
		}
	
		public function updatePlayerInput(deltaT:Number):void
		{
			if (inputModel.getMoveForward() == true)
			{
				thrustAccelX += thrustAccelConst*dirX;
				thrustAccelY += thrustAccelConst*dirY;
			}
			if (inputModel.getMoveReverse() == true)
			{
				thrustAccelX -= thrustAccelConst*dirX;
				thrustAccelY -= thrustAccelConst*dirY;
			}
			if (inputModel.getMoveForward()== false && inputModel.getMoveReverse() == false)
			{
				if (velocity <= velocityMax)
				{	
					thrustAccelX = 0;
					thrustAccelY = 0;
				}
				if (velocity > velocityMax)
				{
					if (velX > 0 && velY > 0)			
					{
						thrustAccelX = -.5*velocity*Math.abs(velocityDirX);
						thrustAccelY = -.5*velocity*Math.abs(velocityDirY);
					}
					if (velX > 0 && velY < 0)			
					{
						thrustAccelX = -.5*velocity*Math.abs(velocityDirX);
						thrustAccelY = .5*velocity*Math.abs(velocityDirY);
					}
					if (velX < 0 && velY > 0)			
					{
						thrustAccelX = .5*velocity*Math.abs(velocityDirX);
						thrustAccelY = -.5*velocity*Math.abs(velocityDirY);
					}
					if (velX < 0 && velY < 0)	
					{
						thrustAccelX = .5*velocity*Math.abs(velocityDirX);
						thrustAccelY = .5*velocity*Math.abs(velocityDirY);
					}
				}	
			}
			if (inputModel.getMoveLeft() == true)
			{
				rotAccel -= rotJerk;
				
			}
			if (inputModel.getMoveRight() == true)
			{
				rotAccel += rotJerk;
			}	
			if (inputModel.getMoveLeft() == false && inputModel.getMoveRight() == false)
			{
				if (rotRate > 1)
				{
					rotAccel = -30;
				}
				if (rotRate < -1)
				{
					rotAccel =  30;
				}
				if (rotRate > -0.10 && rotRate < 0.10)
				{	
					rotRate = 0;
					rotAccel = 0;
				}
			}
			if(inputModel.getFireWeaponOne()==true)
			{
				var projectileOne:DynamicObject = gameBoard.addDynamic("../Images/asteroid.png",-10,-10,x,y-35, staticArray,new AsteriodCollisionModel());
				projectileOne.velX = (350*dirY)+this.velX;;
				projectileOne.velY = (-350*dirX)+this.velY;;
				projectileOne.rotRate =-100;	
			}
			if(inputModel.getFireWeaponTwo()==true)
			{
				var projectileTwo:DynamicObject = gameBoard.addDynamic("../Images/asteroid.png",-10,-10,x,y+35, staticArray,new AsteriodCollisionModel());
				projectileTwo.velX = -350*dirY+this.velX;
				projectileTwo.velY = (350*dirX)+this.velY;
				projectileTwo.rotRate = 100;
			}
			
		}
		override public function updateVelocity(deltaT:Number):void
		{
			velX += thrustAccelX*deltaT + gravAccelX*deltaT;
			velY += thrustAccelY*deltaT + gravAccelY*deltaT;
			velocity = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
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
		override public function getHitArea():GameObject
		{
			return shipHitBox;
		}
	
	}
}