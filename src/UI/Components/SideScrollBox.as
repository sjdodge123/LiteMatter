package UI.Components 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jake
	 */
	public class SideScrollBox extends Sprite
	{
		private var text:LabelBox = new LabelBox("Single Player", 0, 0, 200, 30);
		public function SideScrollBox(baseX:int,baseY:int,size:int=30) 
		{
			this.text.changeHeight(size);
			text.changeHeight(size+7);
			var leftArrowButton:ArrowButton = new ArrowButton(baseX, baseY,1);
			var rightArrowButton:ArrowButton = new ArrowButton(baseX + 200, baseY);
			text.x += baseX+107.5;
			text.y += baseY-15;
			addChild(rightArrowButton);
			addChild(leftArrowButton);
			addChild(text);
		}
		public function changeText(value:String,size:int):void 
		{
			removeChild(text);
			var text:LabelBox = new LabelBox(value, 625, 485, 200, 30);
			text.changeHeight(size);
			addChild(text);
		}
	}

}