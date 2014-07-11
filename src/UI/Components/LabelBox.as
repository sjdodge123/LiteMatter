package UI.Components 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.Sprite
	
	public class LabelBox extends Sprite
	{
		public function LabelBox(message:String,x:int, y:int,width:int) 
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 30;
			myFormat.align = TextFormatAlign.CENTER;
			
			var textfield:TextField = new TextField();
			textfield.defaultTextFormat = myFormat;
			textfield.text = message;
			textfield.width = width;
			textfield.x = x - textfield.width/2;
			textfield.y = y;

			addChild(textfield);	
		}
		
	}

}