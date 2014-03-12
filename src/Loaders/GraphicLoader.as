package Loaders
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Sprite;

	public class GraphicLoader extends Sprite
	{
		private var url:URLRequest;
		private var ldr:Loader;
		
		public function GraphicLoader(path:String, x:int, y:int)
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
			addChild(ldr.content);
		}
		
		
	}	
}