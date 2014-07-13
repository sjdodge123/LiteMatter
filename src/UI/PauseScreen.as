package UI 
{
	import flash.display.Sprite
	import UI.Components.LabelBox;
	import UI.Components.MessageBox;
	
	public class PauseScreen extends Sprite
	{
		private var pauseText:LabelBox;
		private var resetText:LabelBox;
		public function PauseScreen() 
		{
			var msg:MessageBox = new MessageBox();
			pauseText = new LabelBox("PAUSED", 600, 350, 250, 60);
			resetText = new LabelBox("Press R to reset", 600, 450, 250, 30);
			pauseText.text.textColor = 0xFF0000;
			addChild(msg);
			addChild(pauseText);
			addChild(resetText);
			
			
		}
		
	}

}