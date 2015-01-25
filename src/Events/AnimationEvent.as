package Events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Jake
	 */
	public class AnimationEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		public var params:Object
		public function AnimationEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new AnimationEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
	
}