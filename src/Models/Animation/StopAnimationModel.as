package Models.Animation 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import Interfaces.IAnimationModel;
	
	/**
	 * ...
	 * @author Jake
	 */
	public class StopAnimationModel extends EventDispatcher implements IAnimationModel 
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
			MovieClip(ldr).gotoAndStop(1);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		
	}
	
}