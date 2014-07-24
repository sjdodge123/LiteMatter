package UI 
{
	import flash.display.Shape;
	import flash.display.Sprite
	import UI.Components.LabelBox;
	import UI.Components.MessageBox;
	import UI.ScoreBoard.ScorePage;
	import UI.ScoreBoard.ScoreBoard;
	
	public class ScoreScreen extends Sprite
	{
		private var scoreBoard:ScoreBoard;
		private var scoreLabel:LabelBox;
		private var scoreColumn:LabelBox;
		public function ScoreScreen(scoreBoard:ScoreBoard) 
		{
			scoreLabel = new LabelBox("Scoreboard:", 600, 250, 350, 35);
			addChild(scoreLabel);
			scoreColumn = new LabelBox(("Lives Remaining:\n" + "Kills:\n" + "Shots Fired:\n" + "Shots Hit:\n"+ "Accuracy:\n" +"Suicides by bullet:\n" + "Planet Crashes:\n" ), 345, 315, 200, 20,"CENTER");
			scoreColumn.changeHeight(400);
			scoreColumn.noAutoCenter();
			addChild(scoreColumn);
			
			for (var i:int = 0; i < scoreBoard.totalPlayers(); i++) 
			{	
				scoreBoard.openToPage(i);
				var playerColumn:LabelBox = new LabelBox(scoreBoard.getPlayerName() + "\n" + scoreBoard.getLives() +"\n" + scoreBoard.getKills() + "\n" + scoreBoard.getShotsFired() + "\n" + scoreBoard.getShotsHit() + "\n" +  scoreBoard.getAccuracy() + "%\n" + scoreBoard.getSuicides()+"\n"  + scoreBoard.getPlanetCrashes(), 475+(i*100), 290, 200, 20);			
				playerColumn.text.textColor = scoreBoard.getColor();
				playerColumn.noAutoCenter();
				playerColumn.changeHeight(400);
				addChild(playerColumn);
			}
			
			
		}
		
	}

}