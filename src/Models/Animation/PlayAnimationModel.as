package Models.Animation 
{
	import flash.events.Event;
	import flash.display.DisplayObject;
	import Interfaces.IAnimationModel;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Jake
	 */
	public class PlayAnimationModel  extends EventDispatcher  implements IAnimationModel 
	{
		private var ldrCont:DisplayObject;
		
		public function PlayAnimationModel() 
		{
			
		}
		
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
		}
		
		public function update(event:Event):void 
		{
			MovieClip(ldrCont).play();
		}
		
	}

}