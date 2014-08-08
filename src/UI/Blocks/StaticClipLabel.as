package UI.Blocks
{
	import flash.display.MovieClip;
	
	import Loaders.AnimationLoader;
	
	import Models.Animation.PlayAnimationModel;
	
	public class StaticClipLabel extends MovieClip
	{
		private var customEvent:String;
		private var tempClip:MovieClip;
		private var imageLoad:AnimationLoader;
		private var color:uint;
		private var ID:String;
		public function StaticClipLabel(imageLocation:String,x:int,y:int,ID:String,color:uint = 0x000000) 
		{
			this.x = x;
			this.y = y;
			this.color = color;
			this.ID = ID;
			tempClip = new MovieClip();
			imageLoad = new AnimationLoader(imageLocation,0, 0,new PlayAnimationModel());
			tempClip.addChild(imageLoad);
			addChild(tempClip);
		}
		public function getID():String
		{
			return ID;
		}
		public function getColor():uint
		{
			return color;
		}
		
		
	}
}