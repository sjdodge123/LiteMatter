package UI 
{
	import Classes.Config.Reader;
	import flash.display.Sprite;
	import Events.GameState;
	import flash.ui.GameInputDevice;
	import UI.ScoreBoard.ScoreBoard;
	
	
	public class MainScreen extends Sprite
	{
		private var startPanel:StartScreen;
		private var endPanel:EndScreen;
		private var pausePanel:PauseScreen;
		private var reader:Reader;
		private var controller:Vector.<ControllerPopScreen>;
		private var deviceID:int;
		public function MainScreen() 
		{
			displayStartScreen();
			reader = new Reader();
			controller = new Vector.<ControllerPopScreen>;
			reader.readFile("version.txt"); 
		}
		
		public function displayStartScreen():void
		{
			startPanel = new StartScreen();
			startPanel.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			startPanel.addEventListener(GameState.MULTI_PLAYER, multiGame);
			addChild(startPanel);
		}
		
		public function displayEndScreen(winPlayerNum:int,scoreBoard:ScoreBoard):void 
		{
			endPanel = new EndScreen(winPlayerNum,scoreBoard);
			endPanel.addEventListener(GameState.SINGLE_PLAYER, singleGame);
			endPanel.addEventListener(GameState.MULTI_PLAYER, multiGame);
			addChild(endPanel);
		}
		
		
		public function displayPauseScreen():void 
		{
			pausePanel = new PauseScreen(reader.text);
			addChild(pausePanel);
		}
		
		public function clearMainScreen():void 
		{
			removeChildren(0, this.numChildren-1);
		}
		
		public function singleGame(event:GameState):void 
		{
			dispatchEvent(new GameState(GameState.SINGLE_PLAYER, null));
			startPanel.removeEventListener(GameState.SINGLE_PLAYER, singleGame);
		}
		public function multiGame(event:GameState):void 
		{
			dispatchEvent(new GameState(GameState.MULTI_PLAYER, null));
			startPanel.removeEventListener(GameState.MULTI_PLAYER, multiGame);
		}
		public function addControllerPopScreen(playNum:int,device:GameInputDevice):void 
		{
			var screen:ControllerPopScreen = new ControllerPopScreen(playNum);
			var id:Number = Number(device.id.charAt(device.id.length-1));
			controller.splice(id, 0, screen);
			addChild(screen);
		}
		public function confirmControllerScreen(device:GameInputDevice):void 
		{
			var id:Number =  Number(device.id.charAt(device.id.length-1));
			controller[id].confirmController();
		}
		public function displayControllerScreens():void 
		{
			for (var i:int = 0; i < controller.length; i++) 
			{
				controller[i].resetMenu();
				addChild(controller[i]);
			}
		}
		
		
	}

}