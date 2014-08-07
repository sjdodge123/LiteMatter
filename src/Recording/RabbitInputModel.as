package Recording
{
	import flash.events.EventDispatcher;
	
	import Classes.PlayerObject;
	
	import Interfaces.IInputHandling;

	public class RabbitInputModel extends EventDispatcher implements IInputHandling
	{
		private var moveForward:Boolean = false;
		private var moveReverse:Boolean = false;
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var fireWeaponOne:Boolean = false;
		private var fireWeaponTwo:Boolean = false;
		private var eventArray:Array;
		private var ship:PlayerObject;
		private var count:int = 0;
		private var deltaT:Number;
		public function RabbitInputModel(eventArray:Array)
		{
			this.eventArray = eventArray;
			
		}
		public function playBack():Number
		{
			var objectArray:Array = new Array();
			if(eventArray[count] != null)
			{
				var value:Array = eventArray[count];
				deltaT = value[0];
				moveForward = value[1];
				moveReverse = value[2];
				moveLeft = value[3];
				moveRight = value[4];
				ship.fireOne(value[5]);
				ship.fireTwo(value[6]);
				ship.x = value[7];
				ship.y = value[8];
				ship.rotationZ = value[9];
				ship.setHP(value[10]);
				ship.setRespawnCount(value[11]);
			}
			else
			{
				moveForward = false;
				moveReverse = false;
				moveLeft = false;
				moveRight = false;
				fireWeaponOne = false;
				fireWeaponTwo = false;
			}
			count+=1;
			return deltaT;
		}
		
		public function setShip(ship:PlayerObject):void
		{
			this.ship = ship;
		}
		
		public function getInputType():int
		{
			return 0;
		}
		public function getMoveForward():Boolean
		{
			return moveForward;
		}
		public function getMoveReverse():Boolean
		{
			return moveReverse;
		}
		public function getMoveLeft():Boolean
		{
			return moveLeft;
		}
		public function getMoveRight():Boolean
		{
			return moveRight;
		}
		public function getFireWeaponOne():Boolean
		{
			return fireWeaponOne;
		}
		public function getFireWeaponTwo():Boolean
		{
			return fireWeaponTwo;
		}
	}
}