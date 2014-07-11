package UI 
{
	import UI.Components.MessageBox;
	import UI.Components.LabelBox;
	import UI.Components.ButtonBox;
	import flash.display.Sprite;
	import Events.GameState;
	
	public class StartScreen extends Sprite
	{
		private var welcomeBox:MessageBox;
		private var mainLabel:LabelBox;
		private var singlePlayerLabel:LabelBox;
		private var multiPlayerLabel:LabelBox;
		private var singlePlayerButton:ButtonBox;
		private var multiPlayerButton:ButtonBox;
		public function StartScreen() 
		{
			welcomeBox = new MessageBox();
			mainLabel = new LabelBox("Please Choose:", 600, 210, 200);
			singlePlayerLabel = new LabelBox("Single Player:", 500, 300, 250);
			multiPlayerLabel = new LabelBox("Local multiplayer:", 500, 400, 250);
			singlePlayerButton = new ButtonBox(750, 300, 200,GameState.SINGLE_PLAYER);
			multiPlayerButton = new ButtonBox(750, 400, 200,GameState.MULTI_PLAYER);
			
			
			addChild(welcomeBox);
			addChild(mainLabel);
			addChild(singlePlayerLabel);
			addChild(multiPlayerLabel);
			addChild(singlePlayerButton);
			addChild(multiPlayerButton);
			singlePlayerButton.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			multiPlayerButton.addEventListener(GameState.MULTI_PLAYER, multiGame);
		}
		
		public function singleGame(event:GameState):void 
		{
			dispatchEvent(new GameState(GameState.SINGLE_PLAYER, null));
			singlePlayerButton.removeEventListener(GameState.SINGLE_PLAYER, singleGame);
		}
		public function multiGame(event:GameState):void 
		{
			dispatchEvent(new GameState(GameState.MULTI_PLAYER, null));
			multiPlayerButton.removeEventListener(GameState.MULTI_PLAYER, multiGame);
		}
		
		
	}

}