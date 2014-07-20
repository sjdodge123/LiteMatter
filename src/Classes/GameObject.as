package Classes {

	
	import Interfaces.IObjectMethods;
	import flash.display.Sprite;


	public class GameObject extends Sprite implements IObjectMethods
	{
		public function GameObject()
		{

		}
		
		public function getHitArea():GameObject 
		{
			return null; 
		}
	}
}