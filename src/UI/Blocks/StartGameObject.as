package UI.Blocks
{
	
	import UI.ScoreBoard.ScorePage;
	import flash.ui.GameInputDevice;

	public class StartGameObject
	{
		public var inputSignal:int;
		public var page:ScorePage;
		public var device:GameInputDevice;
		public function StartGameObject(inputSignal:int,page:ScorePage,device:GameInputDevice)
		{
			this.inputSignal = inputSignal;
			this.page = page;
			this.device = device;
		}
	}
}