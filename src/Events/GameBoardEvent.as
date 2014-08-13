package Events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Jake
	 */
	public class GameBoardEvent extends Event
	{
		public static const ADD:String = "addToStage";
		public static const REMOVE:String = "removeFromStage";
		public static const EXPLODE:String = "explode";
		public static const ADD_TO_POINT:String = "addToPoint";
		public var params:Object;
		public function GameBoardEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new GameBoardEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
	
}