package UI.Components
{
	import flash.display.Sprite;
	
	import UI.ScoreBoard.ScorePage;

	public class ShipBox extends Sprite
	{
		private var page:ScorePage;
		private var shipBox:Sprite = new Sprite();
		public function ShipBox(x,y,page) 
		{
			this.x = x;
			this.y = y;
			this.page = page;
		}
		
		public function reDraw():void
		{
			if(this.contains(shipBox)) {
				removeChild(shipBox);
				shipBox = null;
			}
			shipBox = new Sprite();
			shipBox.graphics.beginFill(this.page.getColor(),1);
			shipBox.graphics.drawRect(0,0,450,250);
			shipBox.graphics.endFill();
			this.addChild(shipBox);
		}
	}
}