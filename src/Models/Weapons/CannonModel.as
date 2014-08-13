package Models.Weapons
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	import Events.EFireCannon;
	import Events.GameBoardEvent;
	
	import Interfaces.IWeaponModel;
	
	import Loaders.SoundLoader;
	
	public class CannonModel extends EventDispatcher implements IWeaponModel
	{
		private var weaponCoolDownSeconds:int = 3;
		private var weaponOneTimer:Timer;
		private var weaponTwoTimer:Timer;
		private var oneCanShoot:Boolean = true;
		private var twoCanShoot:Boolean = true;
		private var fireSound:Sound;
		private var playerPoint:Point;
		private var convertedPoint:Point;
		private var projectileArray:Array;
		private var soundLoader:SoundLoader;
		private var bulletInfo:Array;
		private var velX:Number;
		private var velY:Number;
		
		public function CannonModel ()
		{
			soundLoader = new SoundLoader();
			fireSound = soundLoader.loadSound("./Sounds/cannonFire.mp3");
			weaponOneTimer = new Timer(weaponCoolDownSeconds * 1000, 1);
			weaponTwoTimer = new Timer(weaponCoolDownSeconds * 1000, 1);
			weaponOneTimer.addEventListener(TimerEvent.TIMER_COMPLETE, oneReadyToShoot);
			weaponTwoTimer.addEventListener(TimerEvent.TIMER_COMPLETE, twoReadyToShoot);
			weaponOneTimer.start();
			weaponTwoTimer.start();
		}
		
		public function fireWeaponOne(travelInfo:Vector.<Number>):void 
		{
			if(oneCanShoot)
				{
					bulletInfo = new Array();
					//FIRE ONE
					playerPoint = new Point(-8, -17.5);
					bulletInfo.push(playerPoint);
					//FIRE TWO
					playerPoint = new Point(9, -17.5);
					bulletInfo.push(playerPoint);
					//Finalize
					velX = (350*travelInfo[1])+travelInfo[2];
					velY = (-350*travelInfo[0])+travelInfo[3];
					bulletInfo.push(velX);
					bulletInfo.push(velY);
					fireSound.play();
					oneCanShoot = false;
					weaponOneTimer.reset();
					weaponOneTimer.start();
					dispatchEvent(new EFireCannon(EFireCannon.FIRE_ONE,null));
					dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD_TO_POINT,bulletInfo));
				}
		}
		public function fireWeaponTwo(travelInfo:Vector.<Number>):void 
		{
			if(twoCanShoot)
				{
					bulletInfo = new Array();
					
					//FIRE ONE
					playerPoint = new Point(-8, 17.5);
					bulletInfo.push(playerPoint);
					
					//FIRE TWO
					playerPoint = new Point(9, 17.5);
					bulletInfo.push(playerPoint);
					
					//Finalize
					velX = (-350*travelInfo[1])+travelInfo[2];
					velY = (350*travelInfo[0])+travelInfo[3];
					bulletInfo.push(velX);
					bulletInfo.push(velY);
					fireSound.play();
					twoCanShoot = false;
					weaponTwoTimer.reset();
					weaponTwoTimer.start();
					dispatchEvent(new EFireCannon(EFireCannon.FIRE_TWO,null));
					dispatchEvent(new GameBoardEvent(GameBoardEvent.ADD_TO_POINT,bulletInfo));
				}
		}
		private function oneReadyToShoot(e:Event):void
		{
			oneCanShoot = true;
		}
		private function twoReadyToShoot(e:Event):void
		{
			twoCanShoot = true;
		}
		public function getOneReadyToShoot():Boolean
		{
			return oneCanShoot;
		}
		public function getTwoReadyToShoot():Boolean
		{
			return twoCanShoot;
		}
	}
}