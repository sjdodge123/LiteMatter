package UI 
{
	import flash.display.Sprite;
	import Events.GameState;
	
	
	public class MainScreen extends Sprite
	{
		private var startPanel:StartScreen;
		public function MainScreen() 
		{
			startPanel = new StartScreen();
			startPanel.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			startPanel.addEventListener(GameState.MULTI_PLAYER, multiGame);
			addChild(startPanel);
		}
		
		public function singleGame(event:GameState):void 
		{
			dispatchEvent(new GameState(GameState.SINGLE_PLAYER, null));
			startPanel.removeEventListener(GameState.SINGLE_PLAYER, singleGame);
		}
		public function multiGame(event:GameState):void 
		{
			dispatchEvent(new GameState(GameState.MULTI_PLAYER, null));
			startPanel.removeEventListener(GameState.MULTI_PLAYER, multiGame);
		}
		
		
	}

}