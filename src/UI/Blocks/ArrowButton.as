package UI.Blocks 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Events.ButtonEvent;

	/**
	 * ...
	 * @author Jake
	 */
	public class ArrowButton extends Sprite
	{
		private var color:uint = 0xFFFFFF;
		private var xValue:int;
		private var yValue:int;
		private var invert:int = 0;
		public function ArrowButton(x:int,y:int,invert:int=0) 
		{
			xValue = x;
			yValue = y;
			addEventListener(MouseEvent.CLICK, buttonClickHandler);
			buttonMode = true;
			useHandCursor = true;
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
			this.invert = invert;
		}
		public function enableButton():void
		{
			addEventListener(MouseEvent.CLICK, buttonClickHandler);
			buttonMode = true;
			useHandCursor = true;
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
		
		public function disableButton():void
		{
			removeEventListener(MouseEvent.CLICK, buttonClickHandler);
			buttonMode = false;
			useHandCursor = false;
			removeChildren();
		}
		private function buttonClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.PRESSED,null));
		}
		private function drawStem(x:int,y:int,fill:int=1):Sprite
		{
			var stem:Sprite = new Sprite();
			stem.graphics.beginFill(color,fill);
			stem.graphics.drawRect(x, y, 15, 10);
			stem.graphics.endFill();
			return stem;
		}
		private function drawBorder(x:int, y:int,sizeX:int,sizeY:int,fill:int=1):Sprite
		{
			var box:Sprite = new Sprite();
			box.graphics.beginFill(0x000000,fill);
			box.graphics.lineStyle(2, 0x000000,fill, 100);
			box.graphics.drawRect(x+sizeX, y+sizeY, 40, 35);
			box.graphics.endFill();
			return box;
		}
		private function drawTopTriangle(x:int,y:int,size:int,fill:int=1):Shape 
		{
			var triangle:Shape = new Shape();
			triangle.graphics.beginFill(color,fill);
			triangle.graphics.moveTo(x, y);
			triangle.graphics.lineTo(x + size, y);
			triangle.graphics.lineTo(x + size, y+size);
			triangle.graphics.endFill();
			return triangle;
		}
		private function drawBottomTriangle(x:int, y:int, size:int,fill:int=1):Shape 
		{
			var triangle:Shape = new Shape();
			triangle.graphics.beginFill(color,fill);
			triangle.graphics.moveTo(x+size, y);
			triangle.graphics.lineTo(x + size*2, y);
			triangle.graphics.lineTo(x + size, y+size);
			triangle.graphics.endFill();
			return triangle;
		}
		
		
	}

}