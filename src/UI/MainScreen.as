package UI 
{
	import flash.display.Sprite;
	import Events.GameState;
	
	
	public class MainScreen extends Sprite
	{
		private var startPanel:StartScreen;
		private var endPanel:EndScreen;
		private var pausePanel:PauseScreen;
		public function MainScreen() 
		{
			startPanel = new StartScreen();
			startPanel.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			startPanel.addEventListener(GameState.MULTI_PLAYER, multiGame);
			addChild(startPanel);
		}
		
		public function displayEndScreen(winPlayerNum:int):void 
		{
			endPanel = new EndScreen(winPlayerNum);
			endPanel.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			endPanel.addEventListener(GameState.MULTI_PLAYER, multiGame);
			addChild(endPanel);
		}
		public function displayPauseScreen():void 
		{
			pausePanel = new PauseScreen();
			addChild(pausePanel);
		}
		
		public function clearMainScreen():void 
		{
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				removeChildAt(i);
			}
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