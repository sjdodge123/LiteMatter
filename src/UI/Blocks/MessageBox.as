package UI.Blocks 
{
	import flash.display.Sprite;
  
	
	public class MessageBox extends Sprite
	{
		private var msgBox:Sprite;
		public function MessageBox() 
		{
			msgBox = new Sprite();
			msgBox.graphics.beginFill(0xFFFFFF);
			msgBox.graphics.drawRect(350, 150, 500, 500);
			msgBox.graphics.endFill();
			msgBox.graphics.lineStyle(2, 0x000000, 100);
			msgBox.graphics.drawRect(355, 155, 490, 490);
			addChild(msgBox);
		}
		
		
		
	}

}