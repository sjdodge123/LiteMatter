package UI.Components 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jake
	 */
	public class ArrowButton extends Sprite
	{
		private var color:uint = 0x000000;
		private var xValue:int;
		private var yValue:int;
		public function ArrowButton(x:int,y:int,invert:int=0) 
		{
			xValue = x;
			yValue = y;
			this.buttonMode = true;
			this.useHandCursor = true;
			if (invert == 0) 
			{
				//Draw Facing Right
				addChild(drawBorder(xValue+5, yValue-21.5,-10,10));
				addChild(drawStem(xValue,yValue));
				addChild(drawTopTriangle(xValue+30, yValue+5,-15));
				addChild(drawBottomTriangle(xValue, yValue+5, 15));
				
			}
			else 
			{
				//Draw Facing Left
				addChild(drawBorder(xValue-10, yValue-21.5,-10,10));
				addChild(drawStem(xValue,yValue));
				addChild(drawTopTriangle(xValue-15, yValue+5,+15));
				addChild(drawBottomTriangle(xValue+15, yValue+5, -15));
				
			}
			
		}
		private function drawStem(x:int,y:int):Sprite
		{
			var stem:Sprite = new Sprite();
			stem.graphics.beginFill(color);
			stem.graphics.drawRect(x, y, 15, 10);
			stem.graphics.endFill();
			return stem;
		}
		private function drawBorder(x:int, y:int,sizeX:int,sizeY:int):Sprite
		{
			var box:Sprite = new Sprite();
			box.graphics.beginFill(0xFFFFFF);
			box.graphics.lineStyle(2, 0x000000, 100);
			box.graphics.drawRect(x+sizeX, y+sizeY, 40, 35);
			box.graphics.endFill();
			return box;
		}
		private function drawTopTriangle(x:int,y:int,size:int):Shape 
		{
			var triangle:Shape = new Shape();
			triangle.graphics.beginFill(color);
			triangle.graphics.moveTo(x, y);
			triangle.graphics.lineTo(x + size, y);
			triangle.graphics.lineTo(x + size, y+size);
			triangle.graphics.endFill();
			return triangle;
		}
		private function drawBottomTriangle(x:int, y:int, size:int):Shape 
		{
			var triangle:Shape = new Shape();
			triangle.graphics.beginFill(color);
			triangle.graphics.moveTo(x+size, y);
			triangle.graphics.lineTo(x + size*2, y);
			triangle.graphics.lineTo(x + size, y+size);
			triangle.graphics.endFill();
			return triangle;
		}
		
		
	}

}