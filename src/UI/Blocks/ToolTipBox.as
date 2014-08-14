package UI.Blocks
{
	import flash.display.Sprite;

	public class ToolTipBox extends Sprite
	{
		private var toolTip:LabelBox;
		private var xValue:int = 500;
		private var yValue:int = 730;
		private var paddingH:int = 30;
		private var paddingW:int = 25;
		public function ToolTipBox(toolTip:LabelBox)
		{
			this.toolTip = toolTip;
			toolTip.x = xValue+ paddingW;
			toolTip.y = yValue+ paddingH;
			toolTip.text.wordWrap = true;
			graphics.lineStyle(1,0xFFFFFF);
			graphics.drawRect(xValue,yValue,200,150);
			addChild(toolTip);
		}
	}
}