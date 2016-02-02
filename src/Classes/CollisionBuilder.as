package Classes
{

	public class CollisionBuilder
	{
		public function CollisionBuilder()
		{
		}
		public function createHitBox(ob1:GameObject,x:Number,y:Number, dimX:Number, dimY:Number, opacity:Number):GameObject
		{
			var hitBox:GameObject = new GameObject();
			hitBox.graphics.beginFill(0x000000, opacity);
			hitBox.x = x;
			hitBox.y = y;
			hitBox.graphics.drawRect(0,0,dimX,dimY);
			hitBox.graphics.endFill();
			ob1.addChild(hitBox);
			return hitBox
		}
		public function createHitCircle(ob1:GameObject, x:Number,y:Number,radius:Number,opacity:Number):GameObject
		{
			var hitCircle:GameObject = new GameObject();
			hitCircle.x = x;
			hitCircle.y = y;
			hitCircle.graphics.beginFill(0xFFFFFF, opacity);
			hitCircle.graphics.drawCircle(0,0,radius);
			hitCircle.graphics.endFill();
			ob1.addChild(hitCircle);
			return hitCircle;
		}
	}
}