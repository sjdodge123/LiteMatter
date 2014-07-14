package UI.ScoreBoard {
	/**
	 * ...
	 * @author ...
	 */
	public class ScoreBoard 
	{
		private static var scoreBook:Vector.<ScorePage>;
		private static var index:int;
		private static var iterator:int = 0;
		public function ScoreBoard(numPlayers:int = 0 ) 
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
			for (var i:int = 0; i < scoreBook.length; i++) 
			{
				scoreBook.pop();
			}
			iterator = 0;
		}
		public function getKills(playerNum:int):int
		{
			index = findIndex(playerNum);
			return scoreBook[index].getKills();
		}
		public function getLives(playerNum:int):int 
		{
			index = findIndex(playerNum);
			return scoreBook[index].getLives();
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
		
		
		
	}

}