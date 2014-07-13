package Classes.Config 
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class Reader 
	{
		private var url:URLRequest;
		private var loader:URLLoader;
		public var text:String;
		public function Reader() 
		{
			
		}
		
		public function readFile(filePath:String):void
		{
			url = new URLRequest(filePath);
			loader = new URLLoader();
			loader.load(url);
			loader.addEventListener(Event.COMPLETE,loadComplete)
		}
		private function loadComplete(event:Event):void 
		{
			text = loader.data;
		}
		
		
	}

}