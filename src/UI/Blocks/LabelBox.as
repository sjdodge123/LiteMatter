package UI.Blocks 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LabelBox extends Sprite
	{
		public var text:TextField;
		private var xPass:int;
		private var myFormat:TextFormat;
		private var color:uint;
		public function LabelBox(message:String,x:int, y:int,size:int,height:int = 100,color:uint = 0x000000, alignment:String = "CENTER") 
		{
			this.x = x;
			this.y = y;
			myFormat = new TextFormat();
			myFormat.size = size;
			myFormat.font = "Verdana";
			myFormat.bold = true;
			myFormat.italic = true;
			myFormat.align = TextFormatAlign[alignment];
			this.color = color;
			text = new TextField();
			text.selectable = false;
			text.defaultTextFormat = myFormat;
			text.textColor = 0x00CC99;
			text.text = message;
			text.height = height;
			text.width = 150;
			addChild(text);
		}
		public function changeHeight(value:int):void 
		{
			text.height = value;
		}
		public function changeWidth(value:int):void 
		{
			text.width = value;
		}
		
		public function noAutoCenter():void 
		{
			text.x = xPass;
		}
		public function getColor():uint
		{
			return color;
		}
	}

}