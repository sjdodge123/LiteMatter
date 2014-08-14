package UI 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.ui.GameInputDevice;
	
	import Classes.Config.Reader;
	
	import Events.ButtonEvent;
	import Events.UIEvent;
	
	import Loaders.SoundLoader;
	
	import UI.ScoreBoard.ScoreBoard;
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
		private var selectSound:Sound;
		private var soundLoader:SoundLoader;
		private var controllerCount:int;
		private var controllerArray:Array;

		public function UserInterfaceController(scoreBoard:ScoreBoard) 
		{
			mainMenu = new MainMenu();
			soundLoader = new SoundLoader();
			selectSound = soundLoader.loadSound("./Sounds/select.mp3");
			reader = new Reader();
			optionsScreen = new OptionsScreen();
			gameSelection = new GameSelectionScreen(scoreBoard);
			mainMenu.addEventListener(ButtonEvent.ON_HOVER,displayToolTip,true);
			optionsScreen.addEventListener(ButtonEvent.ON_HOVER,displayToolTip,true);
			gameSelection.addEventListener(ButtonEvent.ON_HOVER,displayToolTip,true);
			reader.readFile("version.txt"); 
			controllerArray = new Array();
			displayMainMenuScreen();
			
		}
		
		protected function displayToolTip(event:ButtonEvent):void
		{
			event.stopPropagation();
			event.currentTarget.addEventListener(ButtonEvent.OFF_HOVER,removeToolTip);
			if(event.params != null)
			{
				addChild(Sprite(event.params));
			}
		}
		protected function removeToolTip(event:ButtonEvent):void
		{
			event.currentTarget.removeEventListener(ButtonEvent.OFF_HOVER,removeToolTip);
			if(event.params != null && contains(Sprite(event.params)))
			{
				removeChild(Sprite(event.params));
			}
		}
		
		public function displayMainMenuScreen():void
		{
			currentMenu = mainMenu;
			mainMenu.addEventListener(UIEvent.PLAY, moveToSelection);
			mainMenu.addEventListener(UIEvent.OPTIONS, moveToOptions);
			addChild(mainMenu);
		}
		
		protected function moveToOptions(event:Event):void
		{
			selectSound.play();
			clearScreen();
			addBackListners();
			addChild(optionsScreen);
		}
		
		protected function moveToSelection(event:Event):void
		{
			selectSound.play();
			clearScreen();
			addBackListners();
			addChild(gameSelection);
		}
		
		protected function backToMain(event:Event):void
		{
			selectSound.play();
			clearScreen();
			gameSelection.removeEventListener(UIEvent.PLAY,playGame);
			displayMainMenuScreen();
			dispatchEvent(new UIEvent(UIEvent.BACK,optionsScreen.collectInfo()));
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
			endScreen.addEventListener(ButtonEvent.ON_HOVER,displayToolTip,true);
			endScreen.addEventListener(UIEvent.PLAY,playAgain);
			endScreen.addEventListener(UIEvent.BACK,backToMain);
		}
		
		protected function playAgain(event:UIEvent):void
		{
			backToMain(null);
			gameSelection.addEventListener(UIEvent.PLAY,playGame);
			gameSelection.replay(event.params[0],event.params[1]);
		}
		
		public function displayPauseScreen():void 
		{
			pauseScreen = new PauseScreen(reader.text);
			addChild(pauseScreen);
		}
		
		public function clearScreen():void 
		{
			if(numChildren > 0)
			{
				removeChildren(0, this.numChildren-1);
			}
		}
		public function addControllerPopScreen(playNum:int,device:GameInputDevice):void 
		{
			gameSelection.addControllerToScroll(playNum,device);
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
		
		public function removeControllerPopScreen(playNum:int):void
		{
			gameSelection.removeControllerFromScroll(playNum);
			controllerArray.splice(playNum-1,1);
		}
		
		public function buttonPressed(event:ButtonEvent):void
		{
			//make correct menu button press
		}
		
		public function resetToMenu(colorOne:uint,colorTwo:uint):void
		{
			gameSelection.reset(colorOne,colorTwo);
		}
		private function removeBackEvent(obj:Sprite):void
		{
			if(obj.hasEventListener(UIEvent.BACK))
			{
				obj.removeEventListener(UIEvent.BACK,backToMain)
			}
		}
	}

}