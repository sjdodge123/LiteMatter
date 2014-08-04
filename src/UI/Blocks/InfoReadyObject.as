package UI.Blocks
{
	public class InfoReadyObject
	{
		public var playerOne:StartGameObject;
		public var playerTwo:StartGameObject;
		public function InfoReadyObject(playerOne:StartGameObject,playerTwo:StartGameObject)
		{
			this.playerOne = playerOne;
			this.playerTwo = playerTwo;
		}
	}
}