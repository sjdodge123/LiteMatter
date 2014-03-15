package Models.Animation
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Interfaces.IAnimationModel;
	import Interfaces.IInputHandling;
	
	public class StarThrustAnimationModel implements IAnimationModel
	{
		private var ldrCont:DisplayObject;
		private var inputModel:Object;
		
		public function StarThrustAnimationModel(inputModel:IInputHandling)
		{
			this.inputModel = inputModel;
		}
		
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
			MovieClip(ldrCont).gotoAndStop(1);
		}
		
		public function update(event:Event):void
		{
			var currentFrame:int = MovieClip(ldrCont).currentFrame;
			
			if (inputModel.getMoveForward() == true && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == false) //straight forward
			{	
				if (currentFrame == 1)
				{
					MovieClip(ldrCont).gotoAndPlay(1);
				}
				if(currentFrame == 108)
				{
					MovieClip(ldrCont).gotoAndPlay(28);
				}
			}
			
			if (inputModel.getMoveForward() == false && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == false) //stop
			{
				MovieClip(ldrCont).gotoAndStop(1);
			}
			
			if (inputModel.getMoveForward() == true && inputModel.getMoveLeft() == true && inputModel.getMoveRight() == false) //forward and port
			{	
				if (currentFrame == 1)
				{
					MovieClip(ldrCont).gotoAndPlay(1);
				}
				if(currentFrame == 108)
				{
					MovieClip(ldrCont).gotoAndPlay(28);
				}
			}
			
			if (inputModel.getMoveForward() == true && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == true) //forward and star
			{	
				if (currentFrame == 1)
				{
					MovieClip(ldrCont).gotoAndPlay(109); //turninitializethrust
				}
				if (1 < currentFrame < 108)
				{
					MovieClip(ldrCont).gotoAndPlay(108+currentFrame);
				}
				if (currentFrame == 216)
				{
					MovieClip(ldrCont).gotoAndPlay(136);  //turnthrustloop
				}
			}
			
			if (inputModel.getMoveForward() == false && inputModel.getMoveLeft() == true && inputModel.getMoveRight() == false) //port
			{	
			}
			
			if (inputModel.getMoveForward() == false && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == true) //star
			{	
				if (currentFrame == 1)
				{
					MovieClip(ldrCont).gotoAndPlay(109); //turninitializethrust
				}
				if (1 < currentFrame < 108)
				{
					MovieClip(ldrCont).gotoAndPlay(108+currentFrame);
				}
				if (currentFrame == 216)
				{
					MovieClip(ldrCont).gotoAndPlay(136);  //turnthrustloop
				}
			}
			
		}
	}
}