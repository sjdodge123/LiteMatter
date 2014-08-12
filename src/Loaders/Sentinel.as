package Loaders
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import Events.UIEvent;
	
	import UI.Screens.LoadScreen;

	public class Sentinel extends Sprite
	{
		private var loadScreen:LoadScreen;
		private var paths:Vector.<String>;
		private var type:int;
		private var currentCount:int;
		private var ldr:Loader;
		public function Sentinel()
		{
			paths = new Vector.<String>;
			addAllAssets();
			loadScreen = new LoadScreen(paths.length);
			addChild(loadScreen);
			loadBatch(paths);
		}
		
		private function addAllAssets():void
		{
			//Add Sounds
			addAsset("./Sounds/cannonFire.mp3");
			addAsset("./Sounds/cycle.mp3");
			addAsset("./Sounds/explode.mp3");
			addAsset("./Sounds/mainMenuTheme.mp3");
			addAsset("./Sounds/respawn.mp3");
			addAsset("./Sounds/select.mp3");
			addAsset("./Sounds/shipExplode.mp3");
			addAsset("./Sounds/shipRam.mp3");
			addAsset("./Sounds/thrusterspart1.mp3");
			addAsset("./Sounds/thrusterspart2.mp3");
			//Add SWFS
			addAsset("./Images/backButton.swf");
			addAsset("./Images/Background.swf");
			addAsset("./Images/beginButton.swf");
			addAsset("./Images/blueText.swf");
			addAsset("./Images/cannonball.swf");
			addAsset("./Images/compText.swf");
			addAsset("./Images/controllerText.swf");
			addAsset("./Images/explosion.swf");
			addAsset("./Images/greenText.swf");
			addAsset("./Images/ijklText.swf");
			addAsset("./Images/leftArrowButton.swf");
			addAsset("./Images/mainMenuButton.swf");
			addAsset("./Images/moon.swf");
			addAsset("./Images/oneText.swf");
			addAsset("./Images/optionsButton.swf");
			addAsset("./Images/PirateShip.swf");
			addAsset("./Images/play.swf");
			addAsset("./Images/playAgainButton.swf");
			addAsset("./Images/playerText.swf");
			addAsset("./Images/redText.swf");
			addAsset("./Images/rightArrowButton.swf");
			addAsset("./Images/ShipBody.swf");
			addAsset("./Images/ShipPortCannons.swf");
			addAsset("./Images/ShipStarCannons.swf");
			addAsset("./Images/ShipStarThrust.swf");
			addAsset("./Images/shipThrust.swf");
			addAsset("./Images/tealText.swf");
			addAsset("./Images/threeText.swf");
			addAsset("./Images/twoText.swf");
			addAsset("./Images/wasdText.swf");
			addAsset("./Images/yellowText.swf");
		}
		
		private function addAsset(path:String):void
		{
			paths.push(path);	
		}
		
		public function loadBatch(values:Vector.<String>):void
		{
			var req:URLRequest 
			for(var i:int=0;i<values.length;i++)
			{
				type = checkType(values[i]);
				if(type > -1)
				{
					if(type == 0) //LOAD SOUND
					{
						req = new URLRequest(values[i]);
						var sound:Sound = new Sound(req);
						sound.addEventListener(Event.COMPLETE,loadPartComplete);
					}
					
					if(type == 1) //LOAD SWF
					{
						req = new URLRequest(values[i]);
						ldr = new Loader();
						ldr.load(req);
						ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadPartComplete);
					}
				}
				else
				{
					trace("Error Loading Asset");
					loadScreen.changeAsset("Error Loading Asset");
				}
				
			}
		}
		
		protected function loadPartComplete(event:Event):void
		{
			currentCount++;
			loadScreen.adjustFill(currentCount);
			var fullURL:String = String(event.target.url);
			var index:int = fullURL.search("./");
			var asset:String = fullURL.substring(index);
			loadScreen.changeAsset(asset);
			if(currentCount == paths.length)
			{
				dispatchEvent(new UIEvent(UIEvent.LOAD_COMPLETE,null));
			}
		}
		
		
		private function checkType(value:String):int
		{
			var ending:String = value.substring(value.length,value.length-4);	
			if(ending == ".mp3")
			{
				return 0;
			}
			if(ending == ".swf")
			{
				return 1;
			}
			return -1;
		}
	}
}