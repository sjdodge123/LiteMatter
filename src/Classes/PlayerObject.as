package Classes
{
	import Interfaces.IInputHandling;
	import Interfaces.IPlayerMethods;


	public class PlayerObject extends DynamicObject implements IPlayerMethods
		
	{
		private var fireWeapon:Boolean = false;
		
		private var thrustAccelConst:Number = 4;
		public var thrustAccelX:Number = 0;
		private var thrustAccelY:Number = 0;
		private var rotAccel:Number = 0;
		private var rotJerk:Number = 15;
		
		private var velocityMax:Number = 120;
		private var velocityDirX:Number = 0;
		private var velocityDirY:Number = 0;
		private var dirX:Number = 1;
		private var dirY:Number = 0;
		
		public var inputModel;
		
		public function PlayerObject(pointArray:Array, inputModel)
		{
			this.inputModel = inputModel;
			super(pointArray);
		}
		override public function update(deltaT:Number):void
		{
			updatePlayerInput(deltaT);
			updateRotation(deltaT);  // Added this pass to rotate the object. The directional movement doesn't quite work yet.
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			checkScreenBounds();    // Added this pass to keep the object on the screen. 
			
		}
		public function updatePlayerInput(deltaT:Number):void
		{
			if (inputModel.moveForward == true)
			{
				thrustAccelX += thrustAccelConst*dirX;
				thrustAccelY += thrustAccelConst*dirY;
			}
			if (inputModel.moveReverse == true)
			{
				thrustAccelX -= thrustAccelConst*dirX;
				thrustAccelY -= thrustAccelConst*dirY;
			}
			if (inputModel.moveForward == false && inputModel.moveReverse == false)
			{
				if (velocity <= velocityMax)
				{	
					thrustAccelX = 0;
					thrustAccelY = 0;
				}
				if (velocity > velocityMax)
				{
					if (velX > 0 && velY > 0)			//moving right and down
					{
						thrustAccelX = -.5*velocity*Math.abs(velocityDirX);
						thrustAccelY = -.5*velocity*Math.abs(velocityDirY);
					}
					if (velX > 0 && velY < 0)			//moving right and up
					{
						thrustAccelX = -.5*velocity*Math.abs(velocityDirX);
						thrustAccelY = .5*velocity*Math.abs(velocityDirY);
					}
					if (velX < 0 && velY > 0)			//moving left and down
					{
						thrustAccelX = .5*velocity*Math.abs(velocityDirX);
						thrustAccelY = -.5*velocity*Math.abs(velocityDirY);
					}
					if (velX < 0 && velY < 0)			//moving left and up
					{
						thrustAccelX = .5*velocity*Math.abs(velocityDirX);
						thrustAccelY = .5*velocity*Math.abs(velocityDirY);
					}
				}
				
			}
			
			if (inputModel.moveLeft == true)
			{
				rotAccel -= rotJerk;
				
			}
			if (inputModel.moveRight == true)
			{
				rotAccel += rotJerk;
			}	
			if (inputModel.moveLeft == false && inputModel.moveRight == false)
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
			if(fireWeapon==true)
			{
				
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
		override public function updatePosition(deltaT:Number):void
		{
			this.x += velX*deltaT;
			this.y += velY*deltaT;
		}
		public function updateRotation(deltaT:Number):void
		{
			rotRate += rotAccel*deltaT;
			rotationZ += rotRate*deltaT;
			dirX=Math.cos((Math.PI*rotationZ)/180);
			dirY=Math.sin((Math.PI*rotationZ)/180);
		}
	
	}
}