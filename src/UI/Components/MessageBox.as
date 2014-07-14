package UI.Components 
{
	import flash.display.Sprite;
  
	
	public class MessageBox extends Sprite
	{
		private var msgBox:Sprite;
		public function MessageBox() 
		{
			msgBox = new Sprite();
			msgBox.graphics.beginFill(0xFFFFFF);
			msgBox.graphics.drawRect(350, 200, 500, 500);
			msgBox.graphics.endFill();
			msgBox.graphics.lineStyle(2, 0x000000, 100);
			msgBox.graphics.drawRect(355, 205, 490, 490);
			addChild(msgBox);
		}
		
		
		
	}

}