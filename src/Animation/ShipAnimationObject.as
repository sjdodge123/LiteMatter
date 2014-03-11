package Animation
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.IInputHandling;
	
	
	public class ShipAnimationObject extends MovieClip 
	{
		private var url:URLRequest;
		private var ldr:Loader;
		private var gameBoard:GameBoardObjects;
		private var inputModel:IInputHandling;
		
		public function ShipAnimationObject(path:String, x:int, y:int, inputModel:IInputHandling):void
		{
			this.inputModel = inputModel;
			url = new URLRequest(path);
			ldr = new Loader();
			ldr.load(url);	
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			this.x = x;
			this.y = y
		}
		public function onComplete(event:Event):void
		{
			MovieClip(ldr.content).gotoAndStop(1);
			this.addEventListener(Event.ENTER_FRAME,update);
			addChild(ldr.content);
		}
		public function update(event:Event):void
		{
			var startThrust:int = 2;
			var thrustAccelEnd:int = 25;
			var thrustLoopEnd:int = 48;
			
			var currentFrame:int = MovieClip(ldr.content).currentFrame;
			var endFrame:int = MovieClip(ldr.content).totalFrames;
			
			
			if (inputModel.getMoveForward() == true)
			{	
				if (currentFrame == 1)
				{
					MovieClip(ldr.content).gotoAndPlay(2);
				}
				if(currentFrame == thrustAccelEnd)
				{
					MovieClip(ldr.content).gotoAndPlay(26);
				}
				if(currentFrame == thrustLoopEnd)
				{
					MovieClip(ldr.content).gotoAndPlay(26);
				}
			}
			if (inputModel.getMoveForward() == false)
			{
				if (currentFrame == 1)
				{
				}
				if (currentFrame < 49 && currentFrame > 1)
				{
					MovieClip(ldr.content).gotoAndPlay(49);
				}
				if (currentFrame == endFrame)
				{
					MovieClip(ldr.content).gotoAndStop(1);
				}
			}
		}	
		
	}
}