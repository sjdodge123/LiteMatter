package Models.Animation
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Interfaces.IAnimationPart;
	import Interfaces.IWeaponModel;
	import Events.EFireCannon;

	public class PortCannonsAnimationPart implements IAnimationPart
	{
		private var ldrCont:DisplayObject;
		private var weaponModel:IWeaponModel;
		private var portCannons:MovieClip;
		private var currentFrame:int;
		
		public function PortCannonsAnimationPart(weaponModel:IWeaponModel)
		{			
			this.weaponModel = weaponModel;
			weaponModel.addEventListener(EFireCannon.FIRE_ONE, fire);
		}
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
			portCannons =  MovieClip(ldrCont);
			portCannons.gotoAndStop(1);
		}
		private function fire(event:EFireCannon):void
		{
			portCannons.addEventListener(Event.ENTER_FRAME, update);
			portCannons.gotoAndPlay(1);
		}
		private function update(event:Event):void
		{
			currentFrame = portCannons.currentFrame;
			if (currentFrame == 48)
			{
				portCannons.gotoAndStop(1);
				portCannons.removeEventListener(Event.ENTER_FRAME, update);
			}
		}
	}
}