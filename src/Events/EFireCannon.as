package Events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Jake
	 */
	public class EFireCannon extends Event
	{
		public static const FIRE_ONE:String = "fireWeaponOne";
		public static const FIRE_TWO:String = "fireWeaponTwo";
		public var params:Object
		public function EFireCannon(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
        {
            return new EFireCannon(type, this.params, bubbles, cancelable);
        }
		 public override function toString():String
        {
            return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
        }
		
	}

}