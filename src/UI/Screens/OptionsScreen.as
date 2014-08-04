package UI.Screens
{
	import flash.events.Event;
	
	import Events.UIEvent;
	
	import UI.Blocks.LabelButton;
	import flash.display.Sprite;

	public class OptionsScreen extends Sprite
	{
		private var backButton:LabelButton;
		public function OptionsScreen()
		{
			backButton = new LabelButton("Back",600,700,250,40,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
		
		protected function backToMain(event:Event):void
		{
			dispatchEvent(event);
		}		
	}
}