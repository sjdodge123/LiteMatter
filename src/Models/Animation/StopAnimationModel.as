package Models.Animation 
{
	import Loaders.AnimationLoader;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import Interfaces.IAnimationModel;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jake
	 */
	public class StopAnimationModel implements IAnimationModel 
	{
		private var ldr:DisplayObject;
		
		public function StopAnimationModel() 
		{
			
		}
		public function buildModel(ldr:DisplayObject):void 
		{
			this.ldr = ldr;
		}
		public function update(event:Event):void 
		{
			var currentFrame:int = MovieClip(ldr).currentFrame;
			var endFrame:int = MovieClip(ldr).totalFrames;
			if(currentFrame === endFrame)
			{
				MovieClip(ldr).stop();
			}
		}
		
		
		
	}

}