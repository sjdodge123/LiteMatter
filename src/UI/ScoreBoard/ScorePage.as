package UI.ScoreBoard 
{
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author ...
	 */
	public class ScorePage 
	{
		private var playerNum:int;
		private var kills:int;
		private var livesRemain:int;
		private var shotsFired:int;
		private var shotsHit:int;
		private var damageDealt:int;
		private var damageTaken:int;
		private var initialLives:int;
		public function ScorePage(playerNum:int) 
		{
			this.playerNum = playerNum;
		}
		
		public function removeLife():void
		{
			livesRemain -= 1;
		}
		
		public function addKill():void 
		{
			kills += 1;
		}
		
		public function getKills():int 
		{
			return kills;
		}
		
		public function getLives():int 
		{
			return livesRemain;
		}
		
		public function getShotsFired():int 
		{
			return shotsFired;
		}
		public function getShotsHit():int
		{
			return shotsHit;
		}
		public function getDamageDealt():int 
		{
			return damageDealt;
		}
		public function getDamageTaken():int 
		{
			return damageTaken;
		}
		public function getPlayerNum():int 
		{
			return playerNum;
		}
		public function setInitialLives(lives:int):void 
		{
			livesRemain = lives;
		}
		
		
		
		
		
	}

}