package UI.Screens
{
	import flash.display.Sprite;
	
	import UI.Blocks.LabelBox;

	public class LoadScreen extends Sprite
	{
		private var fillColor:uint = 0xFFFFFF;
		private var emptyColor:uint = 0x000000;
		private var barWidth:Number = 580;
		private var newWidth:Number = 0;
		private var loadingTitle:LabelBox;
		private var loadBar:Sprite
		private var emptySpace:Sprite
		private var fill:Sprite;
		private var totalAssets:Number;
		private var fillPercent:Number;
		private var assetCount:Number = 0;
		private var assetTitle:LabelBox;
		public function LoadScreen(assetCount:Number)
		{
			totalAssets = assetCount;
			
			loadingTitle = new LabelBox("LOADING ASSETS...",250,150,60);
			loadingTitle.changeWidth(700);
			addChild(loadingTitle);
			
			assetTitle = new LabelBox("",250,300,40);
			assetTitle.changeWidth(700);
			addChild(assetTitle);
			
			loadBar = new Sprite();
			loadBar.graphics.beginFill(fillColor);
			loadBar.graphics.drawRect(300,400,600,100);
			loadBar.graphics.endFill();	
			addChild(loadBar);
			
			emptySpace = new Sprite();
			emptySpace.graphics.beginFill(emptyColor);
			emptySpace.graphics.drawRect(310,410,barWidth,80);
			emptySpace.graphics.endFill();
			addChild(emptySpace);
			
			fill = new Sprite();
			addChild(fill);
		}
		public function changeAsset(value:String):void
		{
			removeChild(assetTitle);
			assetTitle = new LabelBox("("+value+")",250,300,40);
			assetTitle.changeWidth(700);
			addChild(assetTitle);
			trace("newLoad");
		}
		
		public function adjustFill():void
		{
			removeChild(fill);
			assetCount++;
			fillPercent = assetCount/totalAssets;
			newWidth = barWidth*fillPercent;
			fill.graphics.beginFill(fillColor);
			fill.graphics.drawRect(310,410,newWidth,80);
			fill.graphics.endFill();
			addChild(fill);
		}
		
		
		
		public function error():void
		{
			removeChild(loadingTitle);		
			loadingTitle = new LabelBox("ERROR LOADING, TRY REFRESHING",50,250,60);
			loadingTitle.changeWidth(1200);
			addChild(loadingTitle);		
		}
	}
}