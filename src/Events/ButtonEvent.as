package Events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Jake
	 */
	public class ButtonEvent extends Event
	{
		public static const PRESSED:String = "pressed";
		public static const ON_HOVER:String = "hover";
		public var params:Object
		public function ButtonEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new ButtonEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
	
}