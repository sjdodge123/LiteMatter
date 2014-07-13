package Events 
{
	import flash.events.Event;
	
	public class GameState extends Event
	{
		public static const SINGLE_PLAYER:String = "singlePlayer";
		public static const MULTI_PLAYER:String = "multiPlayer";
		public static const STOP:String = "stopGame";
		public static const PAUSE_GAME:String = "pauseGame";
		public static const RESET:String = "resetGame";
		public static const FULL_SCREEN:String = "fullScreen";
		public var params:Object
		public function GameState(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
        {
            return new GameState(type, this.params, bubbles, cancelable);
        }
		 public override function toString():String
        {
            return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
        }
		
		
	}

}