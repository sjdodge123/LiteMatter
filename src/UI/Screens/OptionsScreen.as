package UI.Screens
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Events.UIEvent;
	
	import UI.Blocks.AnimatedClipLabel;

	public class OptionsScreen extends Sprite
	{
		private var backButton:AnimatedClipLabel;
		public function OptionsScreen()
		{
			backButton = new AnimatedClipLabel("./Images/backButton.swf",600,700,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
		
		protected function backToMain(event:Event):void
		{
			dispatchEvent(event);
		}		
	}
}