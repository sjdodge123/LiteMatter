package Recording
{

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
		
		
		public function record(deltaT:Number,ship:PlayerObject,objectArray:Array):void
		{
			eventInfo = new Array();
			eventInfo.push(deltaT);
			eventInfo.push(inputModel.getMoveForward());
			eventInfo.push(inputModel.getMoveReverse());
			eventInfo.push(inputModel.getMoveLeft());
			eventInfo.push(inputModel.getMoveRight());
			eventInfo.push(inputModel.getFireWeaponOne());
			eventInfo.push(inputModel.getFireWeaponTwo());
			eventInfo.push(ship.x);
			eventInfo.push(ship.y);
			eventInfo.push(ship.rotationZ);
			eventInfo.push(ship.getHP());
			eventInfo.push(ship.getRespawnCount());
			eventInfo.push(count);
			events[count] = eventInfo;
			count += 1; 
		}
		public function getEventArray():Array
		{
			return events;
		}
		
	}
}