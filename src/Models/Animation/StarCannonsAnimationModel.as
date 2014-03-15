package Models.Animation
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Interfaces.IAnimationModel;
	import Interfaces.IInputHandling;
	import Interfaces.IWeaponModel;
	
	public class StarCannonsAnimationModel implements IAnimationModel
	{
		private var ldrCont:DisplayObject;
		private var inputModel:IInputHandling;
		private var weaponModel:IWeaponModel;
		
		public function StarCannonsAnimationModel(inputModel:IInputHandling, weaponModel:IWeaponModel)
		{
			this.inputModel = inputModel;
			this.weaponModel = weaponModel;
		}
		
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
			MovieClip(ldrCont).gotoAndStop(1);
		}
		
		public function update(event:Event):void
		{
			var currentFrame:int = MovieClip(ldrCont).currentFrame;
			if (inputModel.getFireWeaponTwo() && weaponModel.getTwoReadyToShoot())
			{
				weaponModel.fireWeapon(2);
				if (currentFrame == 1)
				{
					MovieClip(ldrCont).gotoAndPlay(1);
				}
			}
			if (currentFrame == 48)
			{
				MovieClip(ldrCont).gotoAndStop(1);
			}
		}
	}
}