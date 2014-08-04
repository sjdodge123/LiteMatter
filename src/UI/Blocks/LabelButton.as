package UI.Blocks 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import Events.UIEvent;
	
	public class LabelButton extends Sprite
	{
		public var text:TextField;
		private var xPass:int;
		private var eventType:String;
		private var myFormat:TextFormat;
		public function LabelButton(message:String,xValue:int, y:int,width:int,size:int,eventType:String,alignment:String = "CENTER") 
		{
			this.eventType = eventType;
			myFormat = new TextFormat();
			myFormat.size = size;
			myFormat.align = TextFormatAlign[alignment];
			xPass = xValue;
			text = new TextField();
			text.defaultTextFormat = myFormat;
			text.textColor = 0xFFFFFF;
			text.text = message;
			text.width = width;
			text.x = xValue - text.width/2;
			text.y = y;
			text.selectable = false;
			addChild(text);
			var box:Sprite = new Sprite();
			box.graphics.beginFill(0xFFFFFF,0);
			box.graphics.drawRect(text.x,text.y,width,text.height);
			box.graphics.endFill();
			box.buttonMode = true;
			box.useHandCursor = true;
			box.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			addChild(box);
		}
		
		protected function buttonClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new UIEvent(eventType,null));
			
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

