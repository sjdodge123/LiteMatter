package UI.Screens 
{
	import UI.Blocks.MessageBox;
	import UI.Blocks.LabelBox;
	import UI.Blocks.ButtonBox;
	import flash.display.Sprite;
	import Events.UIEvent;
	import UI.ScoreBoard.ScoreBoard;
	
	public class EndScreen extends Sprite
	{
		private var mainLabel:LabelBox;
		private var singlePlayerLabel:LabelBox;
		private var multiPlayerLabel:LabelBox;
		private var singlePlayerButton:ButtonBox;
		private var multiPlayerButton:ButtonBox;
		private var playAgainLabel:LabelBox;
		private var scoreScreen:ScoreScreen;
		
		public function EndScreen(endPlayerNum:int,scoreBoard:ScoreBoard) 
		{
			scoreBoard.openToPage(endPlayerNum);
			mainLabel = new LabelBox(scoreBoard.getPlayerName() + " wins!", 600, 170, 300, 30);
			mainLabel.text.textColor =  scoreBoard.getColor();;
			scoreScreen = new ScoreScreen(scoreBoard);
			
			playAgainLabel = new LabelBox("Play again?",  600, 490, 300,25);
			singlePlayerLabel = new LabelBox("Single Player:", 500, 520, 250,30);
			multiPlayerLabel = new LabelBox("Local multiplayer:", 500, 590, 250,30);
			singlePlayerButton = new ButtonBox(750, 520, 200,UIEvent.SINGLE_PLAYER);
			multiPlayerButton = new ButtonBox(750, 590, 200,UIEvent.MULTI_PLAYER);

			addChild(mainLabel);
			addChild(playAgainLabel);
			addChild(scoreScreen);
			addChild(singlePlayerLabel);
			addChild(multiPlayerLabel);
			addChild(singlePlayerButton);
			addChild(multiPlayerButton);
			singlePlayerButton.addEventListener(UIEvent.SINGLE_PLAYER, singleGame);
			multiPlayerButton.addEventListener(UIEvent.MULTI_PLAYER, multiGame);
		}
		
		
		public function singleGame(event:UIEvent):void 
		{
			dispatchEvent(new UIEvent(UIEvent.SINGLE_PLAYER, null));
			singlePlayerButton.removeEventListener(UIEvent.SINGLE_PLAYER, singleGame);
		}
		public function multiGame(event:UIEvent):void 
		{
			dispatchEvent(new UIEvent(UIEvent.MULTI_PLAYER, null));
			multiPlayerButton.removeEventListener(UIEvent.MULTI_PLAYER, multiGame);
		}
		
	}

}