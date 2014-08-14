package UI.Blocks
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import Events.ButtonEvent;
	import Events.UIEvent;
	
	import Loaders.AnimationLoader;
	
	import Models.Animation.PlayAnimationModel;
	
	public class AnimatedClipLabel extends MovieClip
	{
		private var customEvent:String;
		private var tempClip:MovieClip;
		private var imageLoad:AnimationLoader;
		private var color:uint;
		private var toolTip:LabelBox;
		private var toolTipBox:ToolTipBox;
		public function AnimatedClipLabel(imageLocation:String,x:int,y:int,event:String,toolTip:LabelBox = null,color:uint = 0x000000) 
		{
			this.x = x;
			this.y = y;
			this.toolTip = toolTip;
			this.color = color;
			if(toolTip != null)
			{
				toolTipBox = new ToolTipBox(toolTip);
			}
			customEvent = event;
			tempClip = new MovieClip();
			imageLoad = new AnimationLoader(imageLocation,0, 0,new PlayAnimationModel());
			imageLoad.addEventListener(MouseEvent.CLICK,buttonPressed);
			imageLoad.addEventListener(MouseEvent.MOUSE_OVER,buttonHoverOn);
			imageLoad.addEventListener(MouseEvent.MOUSE_OUT,buttonHoverOff);
			tempClip.addChild(imageLoad);
			addChild(tempClip);
		}
		
		protected function buttonPressed(event:MouseEvent):void
		{
			dispatchEvent(new UIEvent(customEvent,null));
		}
		protected function buttonHoverOn(event:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.ON_HOVER,toolTipBox,true));
		}
		protected function buttonHoverOff(event:MouseEvent):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.OFF_HOVER,toolTipBox,true));
		}
		public function getColor():uint
		{
			return color;
		}
		public function getToolTip():LabelBox
		{
			return toolTip;
		}
		
		
	}
}