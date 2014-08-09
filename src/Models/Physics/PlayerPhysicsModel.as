package Models.Physics
{
	import flash.display.Stage;
	
	import Events.EFireCannon;
	
	import Interfaces.IInputHandling;
	import Interfaces.IPhysicsModel;
	import Interfaces.IStaticMethods;
	
	import Loaders.SoundLoader;
	
	import Models.Sound.thrusterModel;
	
	public class PlayerPhysicsModel extends ObjectPhysicsModel implements IPhysicsModel
	{
		private const thrustAccelConst:Number = 180;
		private const rotAccelConst:Number = 200;
		private var inputModel:IInputHandling;
		private var returnInfo:Vector.<Number>;
		private var velocityMax:Number = 150;
		private var velocityDirX:Number = 0;
		private var velocityDirY:Number = 0;
		private var thrustAccelX:Number = 0;
		private var thrustAccelY:Number = 0;
		private var rotAccel:Number = 0;
		private var dirX:Number = 0;
		private var dirY:Number = 0;
		private var soundLoader:SoundLoader;
		private var thrustSound:thrusterModel;
		private var burstSoundRight:thrusterModel;
		private var burstSoundLeft:thrusterModel;
		
		public function PlayerPhysicsModel(stage:Stage)
		{
			super(stage);
			soundLoader = new SoundLoader();
			thrustSound = new thrusterModel();
			burstSoundRight = new thrusterModel();
			burstSoundLeft = new thrusterModel();
			thrustSound.buildModel(soundLoader.loadSound("./Sounds/thrusterspart2.mp3"),800,.6);
			burstSoundRight.buildModel(soundLoader.loadSound("./Sounds/thrusterspart1.mp3"), 200, .8);
			burstSoundLeft.buildModel(soundLoader.loadSound("./Sounds/thrusterspart1.mp3"), 200, .8);
		}
		override public function buildModel(staticArray:Array,width:Number,height:Number,initialX:Number,initialY:Number,rotationZ:Number,inputModel:IInputHandling):void
		{
			this.staticArray = staticArray;
			this.width = width;
			this.height = height;
			this.positionX = initialX;
			this.positionY = initialY;
			this.rotationZ = rotationZ;
			this.inputModel = inputModel;
		}
		
		override public function update(deltaT:Number):Vector.<Number>
		{
			updateRotation(deltaT);
			calculateGravity();
			updateVelocity(deltaT);
			updatePosition(deltaT);
			checkScreenBounds();
			updatePlayerInput(deltaT);
			returnInfo = new Vector.<Number>;
			returnInfo.push(positionX);
			returnInfo.push(positionY);
			returnInfo.push(rotationZ);
			return returnInfo;
		}
		
		override protected function updateRotation(deltaT:Number):void
		{
			rotRate += rotAccel*deltaT;
			rotationZ += rotRate*deltaT;
			dirX=Math.cos((Math.PI*rotationZ)/180);
			dirY=Math.sin((Math.PI*rotationZ)/180);
		}
		
		override protected function updateVelocity(deltaT:Number):void
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
		override protected function calculateGravity():void
		{
			for(var i:int=0;i<staticArray.length;i++)
			{
				calcDist(staticArray[i].getPosition());
				if(dist>83.5)
				{
					calcGravAccel(staticArray[i]);
				}
			}
		}
		override protected function calcGravAccel(staticObj:IStaticMethods):void
		{
			gravAccelContribution = (staticObj.getGravityConst()/6)/Math.pow(dist,2);
			gravAccelX += gravAccelContribution*distX/dist;
			gravAccelY += gravAccelContribution*distY/dist;
		}
		
		private function updatePlayerInput(deltaT:Number):void
		{
			if (inputModel.getMoveForward() == true)
			{
				thrustAccelX = thrustAccelConst*dirX;
				thrustAccelY = thrustAccelConst * dirY;
				thrustSound.playSound();
			}
			else 
			{
				thrustSound.stopSound();
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
				burstSoundLeft.playSound();
			}
			else 
			{
				burstSoundLeft.stopSound();
			}
			if (inputModel.getMoveRight() == true)
			{
				rotAccel = rotAccelConst;
				burstSoundRight.playSound();
			}
			else 
			{
				burstSoundRight.stopSound();
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
				dispatchEvent(new EFireCannon(EFireCannon.FIRE_ONE, null));
			}
			if(inputModel.getFireWeaponTwo()==true)
			{
				dispatchEvent(new EFireCannon(EFireCannon.FIRE_TWO, null));
			}
		}
		
		override public function resetPhysics(x:Number,y:Number,z:Number):void
		{
			positionX = x;
			positionY = y;
			rotationZ = z;
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
		}
		override public function getDirX():Number
		{
			return dirX;
		}
		override public function getDirY():Number
		{
			return dirY;
		}
	}
}