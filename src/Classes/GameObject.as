package Classes
{

	
	import Interfaces.IObjectMethods;
	import flash.display.Sprite;


	public class GameObject extends Sprite implements IObjectMethods
	{
		public var objHitBox:GameObject;
		public var bodyHitBox:GameObject;
		public var leftWingHitBox:GameObject;
		public var rightWingHitBox:GameObject;
		
		public function GameObject()
		{

		}
		
	}
}