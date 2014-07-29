package UI 
{
	import UI.Components.MessageBox;
	import UI.Components.LabelBox;
	import UI.Components.ButtonBox;
	import flash.display.Sprite;
	import Events.GameState;
	import UI.Components.SideScrollBox;
	
	public class StartScreen extends Sprite
	{
		private var welcomeBox:MessageBox;
		private var mainLabel:LabelBox;
		private var singlePlayerLabel:LabelBox;
		private var multiPlayerLabel:LabelBox;
		private var singlePlayerButton:ButtonBox;
		private var multiPlayerButton:ButtonBox;
		private var scrollBox:SideScrollBox;
		public function StartScreen() 
		{
			welcomeBox = new MessageBox();
			mainLabel = new LabelBox("Space Pirates", 600, 210, 250,30);
			singlePlayerLabel = new LabelBox("Single Player:", 500, 300, 250,30);
			multiPlayerLabel = new LabelBox("Local multiplayer:", 500, 400, 250,30);
			singlePlayerButton = new ButtonBox(750, 300, 200,GameState.SINGLE_PLAYER);
			multiPlayerButton = new ButtonBox(750, 400, 200, GameState.MULTI_PLAYER);
			scrollBox = new SideScrollBox(485,500);
			addChild(welcomeBox);
			addChild(mainLabel);
			addChild(singlePlayerLabel);
			addChild(multiPlayerLabel);
			addChild(singlePlayerButton);
			addChild(multiPlayerButton);
			//addChild(scrollBox);
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
		public function disableButtons():void 
		{
			singlePlayerButton.removeEventListener(GameState.SINGLE_PLAYER, singleGame);
			singlePlayerButton.disableButton();
			multiPlayerButton.removeEventListener(GameState.MULTI_PLAYER, multiGame);
			multiPlayerButton.disableButton();
		}
		public function enableButtons():void 
		{
			singlePlayerButton.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			singlePlayerButton.enableButton();
			multiPlayerButton.addEventListener(GameState.MULTI_PLAYER, multiGame);
			multiPlayerButton.enableButton();
		}
		
		
	}

}