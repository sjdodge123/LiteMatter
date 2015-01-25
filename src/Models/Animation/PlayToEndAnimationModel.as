package Models.Animation 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import Interfaces.IAnimationModel;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Jake
	 */
	public class PlayToEndAnimationModel  extends EventDispatcher  implements IAnimationModel 
	{
		private var ldr:DisplayObject;
		
		public function PlayToEndAnimationModel() 
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