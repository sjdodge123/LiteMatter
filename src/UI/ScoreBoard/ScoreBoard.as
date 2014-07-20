package UI.ScoreBoard {
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author ...
	 */
	public class ScoreBoard 
	{
		private static var scoreBook:Vector.<ScorePage>;
		private static var index:int;
		private static var iterator:int = 0;
		public function ScoreBoard(numPlayers:int = 0) 
		{
			scoreBook = new Vector.<ScorePage>();
			for (var i:int = 0; i < numPlayers; i++) 
			{
				addPlayer(i);
			}
		}
		
		public function addKill(playerNum:int):void 
		{
			index = findIndex(playerNum);
			scoreBook[index].addKill();
		}
		public function addPlayer(playerNum:int):void 
		{
			scoreBook.push(new ScorePage(playerNum));
		}
		public function removePlayer(playerNum:int):void 
		{
			index = findIndex(playerNum);
			scoreBook.splice(index, 1, scoreBook[index]);
		}
		public function totalPlayers():int 
		{
			return scoreBook.length;
		}
		public function removeAllPlayers():void 
		{
			scoreBook = new Vector.<ScorePage>();
			iterator = 0;
		}
		public function openToPage(playerNum:int):void 
		{
			index = findIndex(playerNum);
		}
		
		public function getKills():int
		{
			return scoreBook[index].getKills();
		}
		public function getLives():int 
		{
			return scoreBook[index].getLives();
		}
		public function getShotsFired():int 
		{
			return scoreBook[index].getShotsFired();
		}
		public function getShotsHit():int 
		{
			return scoreBook[index].getShotsHit();
		}
		public function getAccuracy():Number 
		{
			return scoreBook[index].getAccuracy();
		}
		public function getSuicides():int 
		{
			return scoreBook[index].getSuicides();
		}
		public function getPlanetCrashes():int 
		{
			return scoreBook[index].getDeathsByPlanet();
		}
		public function getColor():uint 
		{
			return scoreBook[index].getColor();
		}
		
		private function findIndex(i:int):int 
		{
			return scoreBook.indexOf(scoreBook[i]);
		}
		public function getNextPage():ScorePage
		{
			var page:ScorePage = scoreBook[iterator];
			iterator += 1;
			return page;
			
		}
		public function getPlayerName():String 
		{
			return scoreBook[index].getPlayerName();
		}
		
		
		
	}

}