package UI.Screens 
{
	import flash.display.Sprite;
	
	import Events.UIEvent;
	
	import UI.Blocks.LabelBox;
	import UI.Blocks.LabelButton;
	
	public class MainMenu extends Sprite
	{
		private var title:LabelBox;
		private var playButton:LabelButton;
		private var optionsButton:LabelButton;
//		private var singlePlayerLabel:LabelBox;
//		private var multiPlayerLabel:LabelBox;
//		private var singlePlayerButton:ButtonBox;
//		private var multiPlayerButton:ButtonBox;
//		private var scrollBox:SideScrollBox;
		public function MainMenu() 
		{
			title = new LabelBox("Space Pirates",600,200,400,60);
			addChild(title);
			playButton = new LabelButton("Play", 600, 600, 250,40,UIEvent.PLAY);
			playButton.addEventListener(UIEvent.PLAY,playGame);
			addChild(playButton);
			optionsButton = new LabelButton("Options", 600, 650, 250,40,UIEvent.OPTIONS);
			optionsButton.addEventListener(UIEvent.OPTIONS,optionsMenu);
			addChild(optionsButton);
			//singlePlayerLabel = new LabelBox("Single Player:", 500, 300, 250,30);
			//multiPlayerLabel = new LabelBox("Local multiplayer:", 500, 400, 250,30);
			//singlePlayerButton = new ButtonBox(750, 300, 200,GameState.SINGLE_PLAYER);
			//multiPlayerButton = new ButtonBox(750, 400, 200, GameState.MULTI_PLAYER);
			//scrollBox = new SideScrollBox(485,500);
			
			//addChild(singlePlayerLabel);
			//addChild(multiPlayerLabel);
			//addChild(singlePlayerButton);
			//addChild(multiPlayerButton);
			//addChild(scrollBox);
			//singlePlayerButton.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			//multiPlayerButton.addEventListener(GameState.MULTI_PLAYER, multiGame);
		}
		
		
		public function playGame(event:UIEvent):void
		{
			dispatchEvent(event);
		}
		public function optionsMenu(event:UIEvent):void
		{
			dispatchEvent(event);
		}
		
		
//		public function singleGame(event:UIEvent):void 
//		{
//			dispatchEvent(new UIEvent(UIEvent.SINGLE_PLAYER, null));
//			singlePlayerButton.removeEventListener(UIEvent.SINGLE_PLAYER, singleGame);
//		}
//		public function multiGame(event:UIEvent):void 
//		{
//			dispatchEvent(new UIEvent(UIEvent.MULTI_PLAYER, null));
//			multiPlayerButton.removeEventListener(UIEvent.MULTI_PLAYER, multiGame);
//		}
//		public function disableButtons():void 
//		{
//			singlePlayerButton.removeEventListener(UIEvent.SINGLE_PLAYER, singleGame);
//			singlePlayerButton.disableButton();
//			multiPlayerButton.removeEventListener(UIEvent.MULTI_PLAYER, multiGame);
//			multiPlayerButton.disableButton();
//		}
//		public function enableButtons():void 
//		{
//			singlePlayerButton.addEventListener(UIEvent.SINGLE_PLAYER, singleGame);
//			singlePlayerButton.enableButton();
//			multiPlayerButton.addEventListener(UIEvent.MULTI_PLAYER, multiGame);
//			multiPlayerButton.enableButton();
//		}
		
		
	}

}