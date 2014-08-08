package UI.Blocks
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import Events.ButtonEvent;
	import Loaders.AnimationLoader;
	import Loaders.SoundLoader;
	
	import Models.Animation.PlayAnimationModel;

	public class AnimatedArrow extends MovieClip
	{
		private var tempClip:MovieClip;
		private var imageLoad:AnimationLoader;
		private var cycle:Sound;
		private var soundLoader:SoundLoader;
		
		public function AnimatedArrow(imageLocation:String,x:int,y:int)
		{
			this.x = x;
			this.y = y;
			soundLoader = new SoundLoader();
			cycle = soundLoader.loadSound("./Sounds/cycle.mp3");
			tempClip = new MovieClip();
			imageLoad = new AnimationLoader(imageLocation,0, 0,new PlayAnimationModel());
			tempClip.addChild(imageLoad);
			addChild(tempClip);
			addEventListener(MouseEvent.CLICK, buttonClickHandler);
		}	
			
		private function buttonClickHandler(event:MouseEvent):void
		{
			cycle.play();
			dispatchEvent(new ButtonEvent(ButtonEvent.PRESSED,null));
		}
		
			
	}
}