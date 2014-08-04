package UI 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.GameInputDevice;
	
	import Classes.Config.Reader;
	
	import Events.ButtonEvent;
	import Events.UIEvent;
	
	import UI.ScoreBoard.ScoreBoard;
	import UI.Screens.ControllerPopScreen;
	import UI.Screens.EndScreen;
	import UI.Screens.GameSelectionScreen;
	import UI.Screens.MainMenu;
	import UI.Screens.OptionsScreen;
	import UI.Screens.PauseScreen;
	
	
	public class UserInterfaceController extends Sprite
	{
		private var mainMenu:MainMenu;
		private var gameSelection:GameSelectionScreen;
		private var optionsScreen:OptionsScreen;
		private var endScreen:EndScreen;
		private var pauseScreen:PauseScreen;
		private var reader:Reader;
		private var deviceID:int;
		private var currentMenu:Sprite;

		public function UserInterfaceController(scoreBoard:ScoreBoard) 
		{
			displayMainMenuScreen();
			reader = new Reader();
			optionsScreen = new OptionsScreen();
			gameSelection = new GameSelectionScreen(scoreBoard);
			reader.readFile("version.txt"); 
		}
		
		public function displayMainMenuScreen():void
		{
			mainMenu = new MainMenu();
			currentMenu = mainMenu;
			mainMenu.addEventListener(UIEvent.PLAY, moveToSelection);
			mainMenu.addEventListener(UIEvent.OPTIONS, moveToOptions);
			addChild(mainMenu);
		}
		
		protected function moveToOptions(event:Event):void
		{
			clearScreen();
			addBackListners();
			addChild(optionsScreen);
		}
		
		protected function moveToSelection(event:Event):void
		{
			clearScreen();
			addBackListners();
			addChild(gameSelection);
		}
		
		protected function backToMain(event:Event):void
		{
			clearScreen();
			optionsScreen.removeEventListener(UIEvent.BACK,backToMain);
			gameSelection.removeEventListener(UIEvent.BACK,backToMain);
			gameSelection.removeEventListener(UIEvent.PLAY,playGame);
			displayMainMenuScreen();
		}
		
		protected function playGame(event:UIEvent):void
		{
			dispatchEvent(event);	
		}
		
		public function addBackListners():void
		{
			gameSelection.addEventListener(UIEvent.BACK,backToMain);
			optionsScreen.addEventListener(UIEvent.BACK,backToMain);
		}
		
		public function displayEndScreen(winPlayerNum:int,scoreBoard:ScoreBoard):void 
		{
			endScreen = new EndScreen(winPlayerNum,scoreBoard);
			addChild(endScreen);
		}
		
		
		public function displayPauseScreen():void 
		{
			pauseScreen = new PauseScreen(reader.text);
			addChild(pauseScreen);
		}
		
		public function clearScreen():void 
		{
			removeChildren(0, this.numChildren-1);
		}
		public function addControllerPopScreen(playNum:int,device:GameInputDevice):void 
		{
			gameSelection.addControllerPopScreen(playNum,device);
		}
		public function confirmControllerScreen(device:GameInputDevice):void 
		{
//			var id:Number =  Number(device.id.charAt(device.id.length-1));
//			controller[id].confirmController();
		}
		public function unConfirmControllerScreen(device:GameInputDevice):void 
		{
//			var id:Number =  Number(device.id.charAt(device.id.length-1));
//			controller[id].unConfirmController();
		}
		public function displayControllerScreens():void 
		{
			gameSelection.displayControllerScreens();
		}
		
		public function removeControllerPopScreen(playNum:int, device:GameInputDevice):void
		{
			gameSelection.removeControllerPopScreen(playNum, device);
		}
		
		public function buttonPressed(event:ButtonEvent):void
		{
			//make correct menu button press
		}
	}

}