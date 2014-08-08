package UI.Screens 
{
	import flash.display.Sprite;
	
	import Events.UIEvent;
	
	import UI.Blocks.LabelBox;
	import UI.Blocks.AnimatedClipLabel;
	
	public class MainMenu extends Sprite
	{
		private var title:LabelBox;
		private var playButton:AnimatedClipLabel;
		private var optionsButton:AnimatedClipLabel;
		
		public function MainMenu() 
		{
			title = new LabelBox("Space Pirates",325,200,80,100);
			title.changeWidth(550);
			addChild(title);
			playButton = new AnimatedClipLabel("./Images/play.swf",600,600,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			optionsButton = new AnimatedClipLabel("./Images/optionsButton.swf", 600, 650,UIEvent.OPTIONS);
			optionsButton.addEventListener(UIEvent.OPTIONS,optionsMenu);
			addChild(optionsButton);
		}
		
		
		public function playGame(event:UIEvent):void
		{
			dispatchEvent(event);
		}
		public function optionsMenu(event:UIEvent):void
		{
			dispatchEvent(event);
		}
		
		
	}
}
		
		
		