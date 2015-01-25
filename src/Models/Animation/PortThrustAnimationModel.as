package Models.Animation
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Interfaces.IAnimationModel;
	import Interfaces.IInputHandling;
	import flash.events.EventDispatcher;
	
	public class PortThrustAnimationModel extends EventDispatcher  implements IAnimationModel
	{
		private var ldrCont:DisplayObject;
		private var inputModel:Object;
		
		public function PortThrustAnimationModel(inputModel:IInputHandling)
		{
			this.inputModel = inputModel;
		}
		
		public function buildModel(ldrCont:DisplayObject):void
		{
			this.ldrCont = ldrCont;
			MovieClip(ldrCont).gotoAndStop(203);
		}
		
		public function update(event:Event):void
		{
			var currentFrame:int = MovieClip(ldrCont).currentFrame;
			
			if (inputModel.getMoveForward() == true && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == false) //straight forward
			{	
				if (currentFrame >= 203 && currentFrame <= 251)
				{
					MovieClip(ldrCont).gotoAndPlay(1);
				}
				if(currentFrame == 101)
				{
					MovieClip(ldrCont).gotoAndPlay(21);
				}
				if (102 <= currentFrame && currentFrame <= 203)
				{
					MovieClip(ldrCont).gotoAndPlay(currentFrame-101);
				}
			}
			
			if (inputModel.getMoveForward() == false && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == false) //stop
			{
				
				MovieClip(ldrCont).gotoAndPlay(203);
				if (currentFrame == 251)
				{
					MovieClip(ldrCont).gotoAndPlay(203);
				}
			}
			
			if (inputModel.getMoveForward() == true && inputModel.getMoveLeft() == true && inputModel.getMoveRight() == false) //forward and port
			{	
				if (currentFrame >= 203 && currentFrame <= 251)
				{
					MovieClip(ldrCont).gotoAndPlay(102); //turninitializethrust
				}
				if (1 <= currentFrame && currentFrame <= 101)
				{
					MovieClip(ldrCont).gotoAndPlay(101+currentFrame);
				}
				if (currentFrame == 202)
				{
					MovieClip(ldrCont).gotoAndPlay(122);  //turnthrustloop
				}
			}
			
			if (inputModel.getMoveForward() == true && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == true) //forward and star
			{	
				if (currentFrame >= 203 && currentFrame <= 251)
				{
					MovieClip(ldrCont).gotoAndPlay(1);
				}
				if(currentFrame == 101)
				{
					MovieClip(ldrCont).gotoAndPlay(21);
				}
				if (102 <= currentFrame && currentFrame <= 202)
				{
					MovieClip(ldrCont).gotoAndPlay(currentFrame-101);
				}
			}
			
			if (inputModel.getMoveForward() == false && inputModel.getMoveLeft() == true && inputModel.getMoveRight() == false) //port
			{	
				if (currentFrame >= 203 && currentFrame <= 251)
				{
					MovieClip(ldrCont).gotoAndPlay(102); //turninitializethrust
				}
				if (1 <= currentFrame && currentFrame <= 101)
				{
					MovieClip(ldrCont).gotoAndPlay(101+currentFrame);
				}
				if (currentFrame == 202)
				{
					MovieClip(ldrCont).gotoAndPlay(122);  //turnthrustloop
				}
			}
			
			if (inputModel.getMoveForward() == false && inputModel.getMoveLeft() == false && inputModel.getMoveRight() == true) //star
			{	
				MovieClip(ldrCont).gotoAndPlay(203);
				if (currentFrame == 251)
				{
					MovieClip(ldrCont).gotoAndPlay(203);
				}
			}
			
		}
	}
}