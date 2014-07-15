package Models.Weapons
{
	import Events.PageEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	import Events.EFireCannon;
	import Classes.DynamicObject;
	import Classes.PlayerObject;
	import Classes.GameBoard.GameBoardObjects;
	import Interfaces.IAnimationPart;
	import Events.EFireCannon;
	
	import Interfaces.IWeaponModel;
	
	public class CannonModel extends Sprite implements IWeaponModel
	{
		private var weaponCoolDownSeconds:int = 3;
		private var gameBoard:GameBoardObjects;
		private var playerObject:PlayerObject;
		private var weaponOneTimer:Timer;
		private var weaponTwoTimer:Timer;
		private var oneCanShoot:Boolean = true;
		private var twoCanShoot:Boolean = true;
		private var fireSound:Sound;
		private var playerPoint:Point;
		private var convertedPoint:Point;
		public function CannonModel (gameBoard:GameBoardObjects)
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
			playerObject.addEventListener(EFireCannon.FIRE_ONE, fireWeaponOne);
			playerObject.addEventListener(EFireCannon.FIRE_TWO, fireWeaponTwo);
			fireSound = gameBoard.soundLoader.loadSound("./Sounds/cannonFire.mp3");
		}
		private function fireWeaponOne(event:EFireCannon):void 
		{
			if(oneCanShoot)
				{
					dispatchEvent(new EFireCannon(EFireCannon.FIRE_ONE, null));
					dispatchEvent(new PageEvent(PageEvent.SHOT_FIRED, null));
					playerPoint = new Point(-8, -17.5);
					convertedPoint = playerObject.localToGlobal(playerPoint);
					var projectileOne:DynamicObject = gameBoard.addCannonBall(convertedPoint.x, convertedPoint.y);
					projectileOne.velX = (350*playerObject.getDirY())+playerObject.getVelX();
					projectileOne.velY = (-350*playerObject.getDirX())+playerObject.getVelY();
					playerPoint = new Point(9, -17.5);
					convertedPoint = playerObject.localToGlobal(playerPoint);
					var projectileOne2:DynamicObject = gameBoard.addCannonBall(convertedPoint.x, convertedPoint.y);
					projectileOne2.velX = (350*playerObject.getDirY())+playerObject.getVelX();
					projectileOne2.velY = (-350*playerObject.getDirX())+playerObject.getVelY();
					fireSound.play();
					oneCanShoot = false;
					playerObject.recordShot(projectileOne,projectileOne2);
					weaponOneTimer.reset();
					weaponOneTimer.start();
				}
		}
		private function fireWeaponTwo(event:EFireCannon):void 
		{
			if(twoCanShoot)
				{
					dispatchEvent(new EFireCannon(EFireCannon.FIRE_TWO, null));
					dispatchEvent(new PageEvent(PageEvent.SHOT_FIRED, null));
					playerPoint = new Point(-8, 17.5);
					convertedPoint = playerObject.localToGlobal(playerPoint);
					var projectileTwo:DynamicObject = gameBoard.addCannonBall(convertedPoint.x, convertedPoint.y);
					projectileTwo.velX = (-350*playerObject.getDirY())+playerObject.getVelX();
					projectileTwo.velY = (350*playerObject.getDirX())+playerObject.getVelY();
					playerPoint = new Point(9, 17.5);
					convertedPoint = playerObject.localToGlobal(playerPoint);
					var projectileTwo2:DynamicObject = gameBoard.addCannonBall(convertedPoint.x, convertedPoint.y);
					projectileTwo2.velX = (-350*playerObject.getDirY())+playerObject.getVelX();
					projectileTwo2.velY = (350 * playerObject.getDirX()) + playerObject.getVelY();
					fireSound.play();
					twoCanShoot = false;
					playerObject.recordShot(projectileTwo,projectileTwo2);
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