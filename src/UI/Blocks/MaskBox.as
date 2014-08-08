package UI.Blocks
{
	import flash.display.Sprite;

	public class MaskBox extends Sprite
	{
		public function MaskBox(x:int,y:int,width:int,height:int,color:uint)
		{
			graphics.beginFill(color);
			graphics.drawRect(x,y,width,height);
			graphics.endFill();
		}
	}
}