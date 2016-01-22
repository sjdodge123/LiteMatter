package UI.Components
{
	import flash.display.Sprite;
	
	import UI.ScoreBoard.ScorePage;

	public class ShipBox extends Sprite
	{
		private var page:ScorePage;
		private var shipBox:Sprite;
		public function ShipBox(x,y,page) 
		{
			this.page = page;
		}
		
		public function draw():void
		{
			shipBox = new Sprite();
			shipBox.graphics.beginFill(this.page.getColor(),1);
			shipBox.graphics.drawRect(x,y,450,250);
			shipBox.graphics.endFill();
			this.addChild(shipBox);
		}
	}
}