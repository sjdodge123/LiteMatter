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
		public function ButtonBox(x:int, y:int,width:int,gameState:String) 
		{
			var button:Sprite = new Sprite();
			this.gameState = gameState;
			button.graphics.beginFill(0x0033CC);
			button.graphics.drawRect(x-width/2, y, width/2, 30);
			button.graphics.endFill();
			button.graphics.lineStyle(2, 0x000000, 100);
			button.graphics.drawRect(x-width/2, y, width/2, 30);
			button.buttonMode = true;
			button.useHandCursor = true;
			button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			addChild(button);
		}
		private function buttonClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new GameState(this.gameState,null));
		}	
	}

}