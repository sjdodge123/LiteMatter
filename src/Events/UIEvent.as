package Events 
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		public static const PLAY:String = "playGame";
		public static const OPTIONS:String = "options";
		public static const BACK:String = "back";
		public static const SINGLE_PLAYER:String = "singlePlayer";
		public static const MULTI_PLAYER:String = "multiPlayer";
		public static const STOP:String = "stopGame";
		public static const PAUSE_GAME:String = "pauseGame";
		public static const RESET:String = "resetGame";
		public static const FULL_SCREEN:String = "fullScreen";
		public static const MUTE_GAME:String = "muteGame";
		public static const START_GAME:String = "startGame";
		public static const DROP_CONTROLLER:String = "dropController";
		public static const LOAD_COMPLETE:String = "loadCompleted";
		public var params:Object
		public function UIEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
        {
            return new UIEvent(type, this.params, bubbles, cancelable);
        }
		 public override function toString():String
        {
            return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
        }
		
		
	}

}