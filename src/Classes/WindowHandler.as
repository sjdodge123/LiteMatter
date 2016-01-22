package Classes
{
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeWindowBoundsEvent;
	
	public class WindowHandler extends EventDispatcher
	{
		private var mainWindow:NativeWindow;
		private var width:int;
		private var height:int;
		public function WindowHandler(mainWindow:NativeWindow)
		{
			this.mainWindow = mainWindow;
			mainWindow.addEventListener(Event.CLOSING,onClose);
			mainWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,windowMove);
			mainWindow.width = 1200;
			mainWindow.height = 900;
		}
		
		public function getWidth():int
		{
			return mainWindow.width;
		}
		
		public function getHeight():int
		{
			return mainWindow.height;
		}
		
		
		protected function windowMove(event:NativeWindowBoundsEvent):void
		{
			//.move(event);
		}
		
		protected function onClose(event:Event):void
		{
	
		}
	}
}