package UI 
{
	import flash.display.Sprite
	import UI.Components.LabelBox;
	import UI.Components.MessageBox;
	
	public class PauseScreen extends Sprite
	{
		private var pauseText:LabelBox;
		public function PauseScreen() 
		{
			var msg:MessageBox = new MessageBox();
			pauseText = new LabelBox("PAUSED", 600, 350, 250, 60);
			pauseText.text.textColor = 0xFF0000;
			addChild(msg);
			addChild(pauseText);
		}
		
	}

}