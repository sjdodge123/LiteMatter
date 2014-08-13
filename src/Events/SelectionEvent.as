package Events
{
	import flash.events.Event;

	public class SelectionEvent extends Event
	{
		public static const INPUT_CHANGE:String = "inputChanged";
		public var params:Object
		public function SelectionEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new SelectionEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}