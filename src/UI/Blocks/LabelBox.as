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
		public function LabelBox(message:String,xValue:int, y:int,width:int,size:int,height:int = 100,color:uint = 0x000000, alignment:String = "CENTER") 
		{
			myFormat = new TextFormat();
			myFormat.size = size;
			myFormat.align = TextFormatAlign[alignment];
			xPass = xValue;
			this.color = color;
			text = new TextField();
			text.selectable = false;
			text.defaultTextFormat = myFormat;
			text.textColor = 0xFFFFFF;
			text.text = message;
			text.height = height;
			text.width = width;
			text.x = xValue - text.width/2;
			text.y = y;
			addChild(text);
		}
		public function changeHeight(value:int):void 
		{
			text.height = value;
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