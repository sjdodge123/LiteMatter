package UI.Screens 
{
	import flash.display.Sprite;
	
	import Events.UIEvent;
	
	import UI.Blocks.LabelBox;
	import UI.Blocks.LabelButton;
	import UI.ScoreBoard.ScoreBoard;
	
	public class EndScreen extends Sprite
	{
		private var mainLabel:LabelBox;
		private var backButton:LabelButton;
		private var playAgainButton:LabelButton;
		private var scoreScreen:ScoreScreen;
		private var playerOneColor:uint;
		private var playerTwoColor:uint;
		public function EndScreen(endPlayerNum:int,scoreBoard:ScoreBoard) 
		{
			scoreBoard.openToPage(0);
			playerOneColor = scoreBoard.getColor();
			scoreBoard.openToPage(1);
			playerTwoColor = scoreBoard.getColor();
			scoreBoard.openToPage(endPlayerNum);
			mainLabel = new LabelBox(scoreBoard.getPlayerName() + " wins!", 600, 170, 300, 30);
			mainLabel.text.textColor =  scoreBoard.getColor();;
			scoreScreen = new ScoreScreen(scoreBoard);
			
			playAgainButton = new LabelButton("Play again",  600, 100,250,40,UIEvent.PLAY);
			playAgainButton.addEventListener(UIEvent.PLAY,playAgain);
			backButton = new LabelButton("Back to Menu",600,700,250,40,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMenu);
			
			addChild(mainLabel);
			addChild(playAgainButton);
			addChild(scoreScreen);
			addChild(backButton);
		}
		
		
		public function playAgain(event:UIEvent):void 
		{
			var infoArray:Array = new Array();
			infoArray.push(playerOneColor,playerTwoColor);
			dispatchEvent(new UIEvent(UIEvent.PLAY,infoArray));
			playAgainButton.removeEventListener(UIEvent.PLAY, playAgain);
		}
		public function backToMenu(event:UIEvent):void 
		{
			dispatchEvent(event);
			backButton.removeEventListener(UIEvent.BACK, backToMenu);
		}
		
	}

}