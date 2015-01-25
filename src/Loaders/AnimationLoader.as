package Loaders
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.IAnimationModel;
	import Events.AnimationEvent;
	
	
	public class AnimationLoader extends MovieClip 
	{
		private var url:URLRequest;
		private var ldr:Loader;
		private var gameBoard:GameBoardObjects;
		private var animationModel:IAnimationModel;
		
		public function AnimationLoader(path:String, x:int, y:int,animationModel:IAnimationModel):void
		{
			this.animationModel = animationModel;
			url = new URLRequest(path);
			ldr = new Loader();
			ldr.load(url);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			this.x = x;
			this.y = y
		}
		public function onComplete(event:Event):void 
		{
			animationModel.buildModel(ldr.content);
			addEventListener(Event.ENTER_FRAME,animationModel.update);
			animationModel.addEventListener(Event.COMPLETE,removeController);
			dispatchEvent(new AnimationEvent(AnimationEvent.LOAD_COMPLETE,ldr.content));
			addChild(ldr.content);
		}
		
		protected function removeController(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME,animationModel.update);
			
		}
		
	}
}