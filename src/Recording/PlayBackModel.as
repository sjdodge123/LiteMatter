package Recording
{
	import flash.events.EventDispatcher;
	
	import Classes.PlayerObject;
	
	import Interfaces.IInputHandling;

	public class PlayBackModel extends EventDispatcher implements IInputHandling
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
		public function PlayBackModel(eventArray:Array)
		{
			this.eventArray = eventArray;
			
		}
		public function playBack():Number
		{
			var objectArray:Array = new Array();
			if(eventArray[count] != null)
			{
				var value:FrameState = eventArray[count];
				deltaT = value.deltaT;
				moveForward = value.moveForward;
				moveReverse = value.moveReverse;
				moveLeft = value.moveLeft;
				moveRight = value.moveRight;
				ship.fireOne(value.fireOne);
				ship.fireTwo(value.fireTwo);
				ship.x = value.shipX;
				ship.y = value.shipY;
				ship.rotationZ = value.shipZ;
				ship.setHP(value.shipHP);
				ship.setRespawnCount(value.shipRespawn);
				ship.setImmuneModel(value.shipImmune);
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