package UI.Blocks
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Events.UIEvent;
	import Loaders.AnimationLoader;
	import Models.Animation.PlayAnimationModel;
	
	public class ClipLabel extends MovieClip
	{
		private var customEvent:String;
		private var tempClip:MovieClip;
		private var imageLoad:AnimationLoader;
		public function ClipLabel(imageLocation:String,x:int,y:int,event:String) 
		{
			this.x = x;
			this.y = y;
			customEvent = event;
			tempClip = new MovieClip();
			imageLoad = new AnimationLoader(imageLocation,0, 0,new PlayAnimationModel());
			imageLoad.addEventListener(MouseEvent.CLICK,buttonPressed);
			tempClip.addChild(imageLoad);
			addChild(tempClip);
		}
		
		protected function buttonPressed(event:MouseEvent):void
		{
			dispatchEvent(new UIEvent(customEvent,null));
		}
	}
}