package Loaders
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.IAnimationPart;
	
	
	public class AnimationPartLoader extends MovieClip 
	{
		private var url:URLRequest;
		private var ldr:Loader;
		private var gameBoard:GameBoardObjects;
		private var animationPart:IAnimationPart
		
		public function AnimationPartLoader(path:String, x:int, y:int,animationPart:IAnimationPart):void
		{
			this.animationPart = animationPart;
			url = new URLRequest(path);
			ldr = new Loader();
			ldr.load(url);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			this.x = x;
			this.y = y
		}
		public function onComplete(event:Event):void 
		{
			animationPart.buildModel(ldr.content);
			addChild(ldr.content);
		}
		
	}
}