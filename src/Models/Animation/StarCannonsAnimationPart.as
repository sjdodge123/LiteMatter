package Models.Animation
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Interfaces.IAnimationPart;
	import Interfaces.IWeaponModel;
	import Events.EFireCannon;
	
	public class StarCannonsAnimationPart implements IAnimationPart
	{
		private var ldrCont:DisplayObject;
		private var weaponModel:IWeaponModel;
		private var starCannons:MovieClip;
		private var currentFrame:int;
		
		public function StarCannonsAnimationPart(weaponModel:IWeaponModel)
		{
			this.weaponModel = weaponModel;
			weaponModel.addEventListener(EFireCannon.FIRE_TWO, fire);
		}
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
			starCannons = MovieClip(ldrCont);
			starCannons.gotoAndStop(1);
		}
		private function fire(event:EFireCannon):void
		{
			starCannons.addEventListener(Event.ENTER_FRAME, update);
			starCannons.gotoAndPlay(1);
		}
		private function update(event:Event):void
		{
			currentFrame = starCannons.currentFrame;
			if (currentFrame == 48)
			{
				starCannons.gotoAndStop(1);
				starCannons.removeEventListener(Event.ENTER_FRAME, update);
			}
		}
	}
}