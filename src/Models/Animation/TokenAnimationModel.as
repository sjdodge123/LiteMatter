package Models.Animation 
{
	import Loaders.AnimationLoader;
	import flash.display.DisplayObject;
	import Interfaces.IAnimationModel;
	import flash.events.Event;
	import flash.display.MovieClip;
	import Interfaces.IInputHandling;
	/**
	 * ...
	 * @author Jake
	 */
	public class TokenAnimationModel implements IAnimationModel
	{
		private var ldrCont:DisplayObject;
		private var inputModel:IInputHandling;
		
		public function TokenAnimationModel(inputModel:IInputHandling) 
		{
			this.inputModel = inputModel;
		}
		
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
			MovieClip(ldrCont).gotoAndStop(1);
		}
		
		public function update(event:Event):void 
		{
			
			var startThrust:int = 2;
			var thrustAccelEnd:int = 25;
			var thrustLoopEnd:int = 48;
			var currentFrame:int = MovieClip(ldrCont).currentFrame;
			var endFrame:int = MovieClip(ldrCont).totalFrames;
			
			if (inputModel.getMoveForward() == true)
			{	
				if (currentFrame == 1)
				{
					MovieClip(ldrCont).gotoAndPlay(2);
				}
				if(currentFrame == thrustAccelEnd)
				{
					MovieClip(ldrCont).gotoAndPlay(26);
				}
				if(currentFrame == thrustLoopEnd)
				{
					MovieClip(ldrCont).gotoAndPlay(26);
				}
			}
			if (inputModel.getMoveForward() == false)
			{
				if (currentFrame == 1)
				{
				}
				if (currentFrame < 49 && currentFrame > 1)
				{
					MovieClip(ldrCont).gotoAndPlay(49);
				}
				if (currentFrame == endFrame)
				{
					MovieClip(ldrCont).gotoAndStop(1);
				}
			}
		}
		
	}

}