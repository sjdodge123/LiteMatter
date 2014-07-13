package UI.Components 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.Sprite
	
	public class LabelBox extends Sprite
	{
		public var text:TextField;
		public function LabelBox(message:String,x:int, y:int,width:int,size:int) 
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = size;
			myFormat.align = TextFormatAlign.CENTER;
			
			text = new TextField();
			text.defaultTextFormat = myFormat;
			text.text = message;
			text.width = width;
			text.x = x - text.width/2;
			text.y = y;

			addChild(text);	
		}
		
	}

}