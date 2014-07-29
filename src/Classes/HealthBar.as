package Classes 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class HealthBar extends Sprite
	{
		private var HP:int;
		private var totalHP:int;
		private var playerColor:uint;
		private var inverseColor:uint;
		private var emptyFill:uint = 0xFFFFFF;
		private var scaleValue:Number = .40;
		private var difference:int;
		private var bar:Shape;
		private var barFill:Shape;
		
		public function HealthBar(totalHP:int, color:uint) 
		{
			this.totalHP = totalHP * scaleValue;
			HP = this.totalHP;
			this.playerColor = color;
			generateBar();
			x = -30;
			barFill = new Shape();
			addChild(barFill);
			updateFillBar(0);
		}
		
		public function updateHealthBar(newHP:int) :void
		{
			this.HP = newHP * scaleValue;
			removeChild(barFill);
			barFill = new Shape()
			difference = totalHP - this.HP;
			updateFillBar(difference);
			addChild(barFill);
		}
		
		private function generateBar():void 
		{
			bar = new Shape();
			bar.graphics.lineStyle(1.5, 0, 1);
			bar.graphics.drawRect(0, 0, totalHP, 10);
			bar.graphics.lineStyle();
			addChild(bar);
		}
		private function updateFillBar(difference:int):void 
		{
			barFill.graphics.clear();
			barFill.graphics.beginFill(playerColor, 1);
			barFill.graphics.drawRect(0, 0, HP, 10);
			barFill.graphics.endFill();
			barFill.graphics.beginFill(emptyFill, 1);
			barFill.graphics.drawRect(HP, 0, difference,10);
			barFill.graphics.endFill();
		}
	}

}