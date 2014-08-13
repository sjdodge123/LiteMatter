package Classes {

	
	import Interfaces.IGameObject;
	import flash.display.Sprite;


	public class GameObject extends Sprite implements IGameObject
	{
		public function GameObject()
		{
			
		}
		
		public function update(deltaT:Number,staticObjects:Vector.<StaticObject>,gameObjects:Vector.<GameObject>):void
		{
			
		}
		
		public function getHitArea():GameObject
		{
			return null; 
		}
		public function getScale():Number
		{
			return 0;
		}
	}
}