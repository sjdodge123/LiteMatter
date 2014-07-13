package Classes 
{
	import Events.GameState;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class KeyboardMonitor extends GameObject
	{	
		public function KeyboardMonitor(gameStage:Stage) 
		{
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		}
		
		private function keyPressed(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.P:
				{
					dispatchEvent(new GameState(GameState.PAUSE_GAME, null));
					break;
				}
				case Keyboard.R:
				{
					dispatchEvent(new GameState(GameState.RESET, null));
					break;
				}
			}
			
		}
		
	}

}