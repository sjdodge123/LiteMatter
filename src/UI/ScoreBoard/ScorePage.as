package UI.ScoreBoard 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ScorePage 
	{
		private var playerNum:int;
		private var playerName:String;
		private var kills:int;
		private var livesRemain:int;
		private var shotsFired:int;
		private var shotsHit:int;
		private var damageDealt:int;
		private var damageTaken:int;
		private var initialLives:int;
		private var deathByPlanet:int;
		private var suicides:int;
		private var accuracy:int;
		private var color:uint;
		public function ScorePage(playerNum:int) 
		{
			this.playerNum = playerNum-1;
			this.playerName = "Player " + playerNum;
		}
		
		public function removeLife():void
		{
			livesRemain -= 1;
		}		
		public function addDeathByPlanet():void 
		{
			deathByPlanet += 1;
		}
		public function setColor(color:uint):void 
		{
			this.color = color;
		}
		
		public function addSuicide():void 
		{
			suicides += 1;
		}
		
		public function addKill():void 
		{
			kills += 1;
		}
		public function addHit():void 
		{
			shotsHit += 1;
		}
		
		public function getKills():int 
		{
			return kills;
		}
		public function shotFired():void 
		{
			shotsFired += 2;
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
		public function getDeathsByPlanet():int 
		{
			return deathByPlanet;
		}
		public function getSuicides():int 
		{
			return suicides;
		}
		public function getAccuracy():int 
		{
			accuracy = int((int((shotsHit /shotsFired)*100)/100)*100);
			return accuracy;
		}
		public function getPlayerName():String 
		{
			return playerName;
		}
		public function setInitialLives(lives:int):void 
		{
			livesRemain = lives;
		}
		public function setPlayerName(name:String):void 
		{
			playerName = name;
		}
		public function getColor():uint 
		{
			return color;
		}
		
		
		
		
	}

}