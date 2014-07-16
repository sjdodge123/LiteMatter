package UI 
{
	import flash.display.Sprite
	import UI.Components.LabelBox;
	import UI.Components.MessageBox;
	
	public class PauseScreen extends Sprite
	{
		private var pauseText:LabelBox;
		private var resetText:LabelBox;
		private var muteText:LabelBox;
		private var versionText:LabelBox;
		public function PauseScreen(version:String) 
		{
			var msg:MessageBox = new MessageBox();
			pauseText = new LabelBox("PAUSED", 600, 350, 250, 60);
			resetText = new LabelBox("Press R to reset", 600, 450, 250, 30);
			muteText = new LabelBox("Press M to Mute/Unmute", 600, 550, 350, 30);
			versionText = new LabelBox(version, 600, 650, 350, 15);
			pauseText.text.textColor = 0xFF0000;
			addChild(msg);
			addChild(pauseText);
			addChild(muteText);
			addChild(resetText);
			addChild(versionText);
		}	
	}

}