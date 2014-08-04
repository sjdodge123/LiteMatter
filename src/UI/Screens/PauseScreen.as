package UI.Screens 
{
	import flash.display.Sprite
	import UI.Blocks.LabelBox;
	
	public class PauseScreen extends Sprite
	{
		private var pauseText:LabelBox;
		private var resetText:LabelBox;
		private var muteText:LabelBox;
		private var versionText:LabelBox;
		public function PauseScreen(version:String) 
		{
			pauseText = new LabelBox("PAUSED", 600, 250, 250, 60);
			resetText = new LabelBox("Press R/Back to reset", 600, 350, 300, 30);
			muteText = new LabelBox("Press M to Mute/Unmute", 600, 450, 350, 30);
			versionText = new LabelBox(version, 600, 550, 350, 15);
			pauseText.text.textColor = 0xFF0000;
			addChild(pauseText);
			addChild(muteText);
			addChild(resetText);
			addChild(versionText);
		}	
	}

}