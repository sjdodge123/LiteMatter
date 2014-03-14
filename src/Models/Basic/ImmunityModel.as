package Models.Basic
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Classes.PlayerObject;
	
	import Interfaces.IImmunityModel;

	public class ImmunityModel implements IImmunityModel
	{
		private var respawnImmuneDurationSeconds:Number = 5;
		private var shootImmuneDurationSeconds:Number = .1;
		
		private var immunityBarrier:Sprite = new Sprite();
		private var immuneBorder:Sprite = new Sprite();

		private var playerObject:PlayerObject;
		private var immuneTimer:Timer;
		private var shotTimer:Timer;
		private var immuneStatus:Boolean = false;
		
		public function ImmunityModel()
		{
			immuneTimer = new Timer(respawnImmuneDurationSeconds * 1000, 1);
			shotTimer = new Timer(shootImmuneDurationSeconds * 1000, 1);
			
			immuneTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setImmunity);
			shotTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setImmunity);
			shotTimer.start();
			immuneTimer.start();
			
		}
		public function buildModel(playerObject:PlayerObject):void
		{
			this.playerObject = playerObject;
			
			immunityBarrier.graphics.beginFill(0x8FD8D8, .25);
			immunityBarrier.graphics.drawCircle(0,0, 50);
			immunityBarrier.graphics.endFill()
			
			
			immuneBorder.graphics.beginFill(0xFFA500, .25);
			immuneBorder.graphics.drawCircle(0,0, 55);
			immuneBorder.graphics.endFill()
		}
		
		public function resetShotTimer():void
		{
			shotTimer.reset();
			shotTimer.start();
			immuneStatus = true;
		}
		public function resetImmuneTimer():void
		{
			immuneTimer.reset();
			immuneTimer.start();
			immuneStatus = true;
			showImmunityBarrier();
		}
		public function getImmuneStatus():Boolean
		{
			return immuneStatus;
		}
		
		private function setImmunity(e:Event):void
		{
			immuneStatus = false;
			if (playerObject.contains(immuneBorder) && playerObject.contains(immunityBarrier))
			{
				playerObject.removeChild(immunityBarrier);
				playerObject.removeChild(immuneBorder);
			}
		}
		private function showImmunityBarrier():void
		{
			playerObject.addChild(immuneBorder);
			playerObject.addChild(immunityBarrier);
		}
	
		
	}
}