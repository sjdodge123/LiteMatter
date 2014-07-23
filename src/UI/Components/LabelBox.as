package UI.Components 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.Sprite
	
	public class LabelBox extends Sprite
	{
		public var text:TextField;
		private var xPass:int;
		private var myFormat:TextFormat;
		public function LabelBox(message:String,xValue:int, y:int,width:int,size:int,alignment:String = "CENTER") 
		{
			myFormat = new TextFormat();
			myFormat.size = size;
			myFormat.align = TextFormatAlign[alignment];
			xPass = xValue;
			text = new TextField();
			text.defaultTextFormat = myFormat;
			text.text = message;
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
		
	}

}