package Models.Input 
{
	import Classes.GameBoard.GameBoardObjects;
	import Classes.GameObject;
	import Classes.ObjectBuilder;
	import Classes.PlayerObject;
	import Events.EFireCannon;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import Interfaces.IInputHandling;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Jake
	 */
	public class BasicAIModel implements IInputHandling
	{
		private var moveForward:Boolean = false;
		private var moveReverse:Boolean = false;
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var fireWeaponOne:Boolean = false;
		private var fireWeaponTwo:Boolean = false;
		private var gameStage:Stage;
		private var gameBoard:GameBoardObjects;
		private var objectBuilder:ObjectBuilder;
		private var AIShip:PlayerObject;
		private var location:Point;
		private var distX:Number = 0;
		private var distY:Number = 0;
		private var dist:Number = 0;
		private var startAI:Timer;
		private var fireTimer:Timer;
		private var staticArray:Array;
		private var dontSkip:Boolean = true;
		
		
		public function BasicAIModel(gameStage:Stage, gameBoard:GameBoardObjects, staticArray:Array) 
		{
			this.gameStage = gameStage;
			this.gameBoard = gameBoard;
			this.staticArray = staticArray;
		}
		
		public function buildModel(AIShip:PlayerObject):void
		{
			this.AIShip = AIShip;
			startAI = new Timer(1000, 1);
			startAI.start();
			fireTimer = new Timer(3000);
			fireTimer.start();
			fireTimer.addEventListener(TimerEvent.TIMER, fire);
			startAI.addEventListener(TimerEvent.TIMER_COMPLETE, setStart);
		}
		
		public function update(event:Event):void
		{
			location = AIShip.getLocation();
			checkForPlanets();
		}
		
		private function setStart(event:Event):void 
		{
			gameStage.addEventListener(Event.FRAME_CONSTRUCTED, update);
			startAI.removeEventListener(TimerEvent.TIMER_COMPLETE, setStart);
		}
		
		private function checkForPlanets():void 
		{
			for(var i:int=0;i<staticArray.length;i++)
			{
				calcDist(staticArray[i].getPosition());
				if(dist<randomRange(300,850))
				{
					avoidPlanet()
				}
				else
				{
					moveForward = false;
					moveReverse = false;
					moveLeft = false;
					moveRight = false;
				}
			}
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function avoidPlanet():void 
		{
			if (dist/AIShip.getDirX() < 0) 
			{
				moveForward = true;
			}
			if (dist/AIShip.getDirY() < 0) 
			{
				moveReverse= true;
			}
			if (dist < randomRange(375,420) && dist > randomRange(250,375))
			{
				moveLeft = true;
			}
			else 
			{
				moveLeft = false;
			}
		}
		
		private function calcDist(point:Point):void
		{
			distX = point.x - location.x;
			distY = point.y - location.y;
			dist = Math.sqrt(Math.pow(distX, 2) + Math.pow(distY, 2));
		}
		
		private function fire(event:Event):void 
		{
			var chance:Number = randomRange(1, 4);
			if (chance == 1) 
			{
				fireWeaponOne = true;
			}
			else if (chance == 2) 
			{
				fireWeaponTwo = true;
			}
			else 
			{
				fireWeaponOne = false;
				fireWeaponTwo = false;
			}
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