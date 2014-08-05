package UI.Screens 
{
	import flash.display.Sprite;
	
	import Events.UIEvent;
	
	import UI.Blocks.LabelBox;
	import UI.Blocks.LabelButton;
	import UI.Blocks.ClipLabel;
	
	public class MainMenu extends Sprite
	{
		private var title:LabelBox;
		private var playButton:ClipLabel;
		private var optionsButton:LabelButton;
		
		public function MainMenu() 
		{
			title = new LabelBox("Space Pirates",600,200,400,60);
			addChild(title);
			playButton = new ClipLabel("./Images/play.swf",600,600,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			optionsButton = new LabelButton("Options", 600, 650, 250,40,UIEvent.OPTIONS);
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
		
		
		