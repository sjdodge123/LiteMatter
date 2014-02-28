package Classes
{

	public class CollisionBuilder
	{
		public function CollisionBuilder()
		{
		}
		public function createHitBox(ob1:GameObject,storageLocation:String , x:Number,y:Number, dimX:Number, dimY:Number, opacity:Number):void
		{
			ob1[storageLocation] = new GameObject();
			ob1[storageLocation].graphics.beginFill(0x000000, opacity);
			ob1[storageLocation].x = x;
			ob1[storageLocation].y = y;
			ob1[storageLocation].graphics.drawRect(0,0,dimX,dimY);
			ob1[storageLocation].graphics.endFill();
			ob1.addChild(ob1[storageLocation]);
		}
		public function createHitCircle(ob1:GameObject,storageLocation:String , x:Number,y:Number,radius:Number,opacity:Number):void
		{
			ob1[storageLocation] = new GameObject();
			ob1[storageLocation].graphics.beginFill(0x000000, opacity);
			ob1[storageLocation].x = x;
			ob1[storageLocation].y = y;
			ob1[storageLocation].graphics.drawCircle(0,0,radius);
			ob1[storageLocation].graphics.endFill();
			ob1.addChild(ob1[storageLocation]);
		}
	}
}