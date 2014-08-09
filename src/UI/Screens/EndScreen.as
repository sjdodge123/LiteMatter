package UI.Screens 
{
	import flash.display.Sprite;
	
	import Events.UIEvent;
	
	import UI.Blocks.AnimatedClipLabel;
	import UI.Blocks.LabelBox;
	import UI.ScoreBoard.ScoreBoard;
	
	public class EndScreen extends Sprite
	{
		private var mainLabel:LabelBox;
		private var backButton:AnimatedClipLabel;
		private var playAgainButton:AnimatedClipLabel;
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
			
			mainLabel = new LabelBox(scoreBoard.getPlayerName() +" wins!", 430, 10, 45, 35);
			mainLabel.changeWidth(400);
			mainLabel.changeHeight(100);
			mainLabel.text.textColor =  scoreBoard.getColor();;
			scoreScreen = new ScoreScreen(scoreBoard);
			
			playAgainButton = new AnimatedClipLabel("./Images/playAgainButton.swf",600,600,UIEvent.PLAY);
			playAgainButton.addEventListener(UIEvent.PLAY,playAgain);
			addChild(playAgainButton);
			
			backButton = new AnimatedClipLabel("./Images/mainMenuButton.swf",600,700,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMenu);
			addChild(backButton);
			
			addChild(mainLabel);
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