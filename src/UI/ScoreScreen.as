package UI 
{
	import flash.display.Sprite
	import UI.Components.LabelBox;
	import UI.Components.MessageBox;
	import UI.ScoreBoard.ScorePage;
	import UI.ScoreBoard.ScoreBoard;
	
	public class ScoreScreen extends Sprite
	{
		private var scoreBoard:ScoreBoard;
		private var scoreLabel:LabelBox;
		public function ScoreScreen(scoreBoard:ScoreBoard) 
		{
			scoreLabel = new LabelBox("Scoreboard:", 600, 250, 350, 35);
			addChild(scoreLabel);
			for (var i:int = 0; i < scoreBoard.totalPlayers(); i++) 
			{
				var player:LabelBox = new LabelBox("Player  " + (i + 1) + " remaining lives: " + scoreBoard.getLives(i), 600, 300+(i*22), 450, 22);
				addChild(player);
			}
			
			
		}
		
	}

}