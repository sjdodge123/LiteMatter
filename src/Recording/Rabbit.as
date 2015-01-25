package Recording
{

	import Classes.GameObject;
	import Classes.PlayerObject;
	
	import Interfaces.IInputHandling;
	import Interfaces.IWeaponModel;

	public class Rabbit
	{
		private var events:Array;
		private var eventInfo:Array;
		private var inputModel:IInputHandling;
		private var weaponModel:IWeaponModel;
		private var count:int = 0;
		private var bulletArray:Array;
		
		public function Rabbit()
		{
			events = new Array();;
		}
		
		public function buildModel(inputModel:IInputHandling):void
		{
			this.inputModel = inputModel;
		}
		
		
		public function record(deltaT:Number,ship:PlayerObject,objectArray:Vector.<GameObject>):void
		{
			var frameState:FrameState = new FrameState();
			frameState.deltaT = deltaT;
			frameState.moveForward = inputModel.getMoveForward();
			frameState.moveReverse = inputModel.getMoveReverse();
			frameState.moveLeft = inputModel.getMoveLeft();
			frameState.moveRight = inputModel.getMoveRight();
			frameState.fireOne = inputModel.getFireWeaponOne();
			frameState.fireTwo = inputModel.getFireWeaponTwo();
			frameState.shipX = ship.x;
			frameState.shipY = ship.y;
			frameState.shipZ = ship.rotationZ;
			frameState.shipHP = ship.getHP();
			frameState.shipRespawn = ship.getRespawnCount();
			frameState.shipImmune = ship.getImmuneModel();
			frameState.frameCount = count;
			events[count] = frameState;
			count += 1; 
		}
		public function getEventArray():Array
		{
			return events;
		}
		
	}
}