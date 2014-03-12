package Models.Weapons
{
	import Classes.DynamicObject;
	import Classes.PlayerObject;
	import Classes.GameBoard.GameBoardObjects;
	import Loaders.SoundLoader;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import Models.Animation.PlayAnimationModel;
	import Models.Collision.CannonBallCollisionModel;
	
	import Interfaces.IWeaponModel;
	
	public class CannonModel implements IWeaponModel
	{
		private var weaponCoolDownSeconds:int = 3;
		private var gameBoard:Object;
		private var playerObject:PlayerObject;
		private var weaponOneTimer:Timer;
		private var weaponTwoTimer:Timer;
		private var oneCanShoot:Boolean = true;
		private var twoCanShoot:Boolean = true;
		private var fireSound:Sound;
		public function CannonModel(gameBoard:GameBoardObjects)
		{
			this.gameBoard = gameBoard;
			weaponOneTimer = new Timer(weaponCoolDownSeconds * 1000, 1);
			weaponTwoTimer = new Timer(weaponCoolDownSeconds * 1000, 1);
			weaponOneTimer.addEventListener(TimerEvent.TIMER_COMPLETE, oneReadyToShoot);
			weaponTwoTimer.addEventListener(TimerEvent.TIMER_COMPLETE, twoReadyToShoot);
			weaponOneTimer.start();
			weaponTwoTimer.start();
		}
		
		public function buildModel(playerObject:PlayerObject):void
		{
			this.playerObject = playerObject;
			fireSound = gameBoard.soundLoader.loadSound("./Sounds/cannonFire.mp3");
		}
		
		public function fireWeapon(weaponNum:int):void
		{
				if(weaponNum == 1 && oneCanShoot)
				{
					var projectileOne:DynamicObject = gameBoard.addDynamic("./Images/cannonball.swf", 0, 0, playerObject.getX(), playerObject.getY(), playerObject.getStaticArray(), new CannonBallCollisionModel(),new PlayAnimationModel());
					fireSound.play();
					projectileOne.velX = (350*playerObject.getDirY())+playerObject.getVelX();
					projectileOne.velY = (-350*playerObject.getDirX())+playerObject.getVelY();
					projectileOne.rotRate = -100;
					oneCanShoot = false;
					weaponOneTimer.reset();
					weaponOneTimer.start();
				}
				else if(weaponNum == 2 && twoCanShoot)
				{
					var projectileTwo:DynamicObject = gameBoard.addDynamic("./Images/cannonball.swf", 0, 0, playerObject.getX(), playerObject.getY(), playerObject.getStaticArray(), new CannonBallCollisionModel(),new PlayAnimationModel());
					fireSound.play();
					projectileTwo.velX = (-350*playerObject.getDirY())+playerObject.getVelX();
					projectileTwo.velY = (350*playerObject.getDirX())+playerObject.getVelY();
					projectileTwo.rotRate = 100;
					twoCanShoot = false;
					weaponTwoTimer.reset();
					weaponTwoTimer.start();
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
		
	}
}