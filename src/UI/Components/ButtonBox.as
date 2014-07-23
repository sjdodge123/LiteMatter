package UI.Components 
{
	import Events.GameState;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	
	public class ButtonBox extends Sprite
	{
		private var gameState:String;
		private var enableColor:uint = 0x0033CC;
		private var disableColor:uint = 0xFFFFFF;
		private var button:Sprite;
		private var xValue:int;
		private var yValue:int;
		private var widthValue:int;
		public function ButtonBox(x:int, y:int,width:int,gameState:String) 
		{
			button = new Sprite();
			xValue = x;
			yValue = y;
			widthValue = width;
			this.gameState = gameState;
			enableButton();
		}
		private function buttonClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GameState(this.gameState,null));
		}
		public function disableButton():void
		{
			button.graphics.clear();
			button.graphics.beginFill(disableColor);
			button.graphics.drawRect(xValue- widthValue/2, yValue, widthValue/2, 30);
			button.graphics.endFill();
			button.graphics.lineStyle(2, 0xC0C0C0, 100);
			button.graphics.drawRect(xValue - widthValue/2,yValue, widthValue/2, 30);
			button.buttonMode = false;
			button.useHandCursor = false;
			button.removeEventListener(MouseEvent.CLICK, buttonClickHandler);
			addChild(button);
		}
		public function enableButton():void
		{
			button.graphics.clear();
			button.graphics.beginFill(enableColor);
			button.graphics.drawRect(xValue- widthValue/2, yValue, widthValue/2, 30);
			button.graphics.endFill();
			button.graphics.lineStyle(2, 0x000000, 100);
			button.graphics.drawRect(xValue - widthValue/2,yValue, widthValue/2, 30);
			button.buttonMode = true;
			button.useHandCursor = true;
			button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			addChild(button);
		}
	}

}