package Classes.GameBoard
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	
	public class AnimationLoader extends MovieClip
	{
		private var url:URLRequest;
		private var ldr:Loader;
		
		public function AnimationLoader(path:String, x:int, y:int)
		{
			url = new URLRequest(path);
			ldr = new Loader();
			ldr.load(url);	
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			this.x = x;
			this.y = y;
		}
		
		public function onComplete(event:Event):void
		{
			addEventListener(Event.ENTER_FRAME,update);
			addChild(ldr.content);
		}
		
		public function update(event:Event):void
		{
			var currentFrame:int = MovieClip(ldr.content).currentFrame;
			var endFrame:int = MovieClip(ldr.content).totalFrames;
			if(currentFrame == endFrame)
			{
				MovieClip(ldr.content).stop();
			}
			
		}		
		
	}	
}

