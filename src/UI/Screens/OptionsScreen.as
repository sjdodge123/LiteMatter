package UI.Screens
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Events.SelectionEvent;
	import Events.UIEvent;
	
	import UI.Blocks.AnimatedClipLabel;
	import UI.Blocks.StaticClipLabel;
	import UI.Components.AnimatedScrollBox;
	import UI.Blocks.LabelBox;

	public class OptionsScreen extends Sprite
	{
		private var backButton:AnimatedClipLabel;
		private var slow:StaticClipLabel;
		private var pacingMenu:AnimatedScrollBox;
		private var normal:StaticClipLabel;
		private var fast:StaticClipLabel;
		private var xLoc:Number = 650;
		private var yLoc:Number = 550;
		private var optionsInfo:Array;
		private var pacingTitle:LabelBox;
		public function OptionsScreen()
		{
			optionsInfo = new Array();
			
			pacingTitle = new LabelBox("GAME PACE",xLoc - 375,yLoc -27.5,40);
			pacingTitle.changeWidth(300);
			addChild(pacingTitle);
			slow = new StaticClipLabel("./Images/oneText.swf",xLoc+100,yLoc,"SLOW",1);
			normal = new StaticClipLabel("./Images/twoText.swf",xLoc+100,yLoc,"NORMAL",2);
			fast = new StaticClipLabel("./Images/threeText.swf",xLoc+100,yLoc,"FAST",3);
			pacingMenu = new AnimatedScrollBox(xLoc,yLoc,slow);
			pacingMenu.addLabel(normal);
			pacingMenu.addLabel(fast);
			pacingMenu.changeLabel(normal);
			optionsInfo.push(pacingMenu.getCurrentLabel());
			addChild(pacingMenu);
			pacingMenu.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			
			backButton = new AnimatedClipLabel("./Images/backButton.swf",600,700,UIEvent.BACK);
			backButton.addEventListener(UIEvent.BACK,backToMain);
			addChild(backButton);
		}
		
		protected function inputTypeChanged(event:SelectionEvent):void
		{
			if(event.params[0] == pacingMenu)
			{
				optionsInfo[0] = pacingMenu.getCurrentLabel().getColor();
			}
		}
		
		public function collectInfo():Array
		{
			return optionsInfo;
		}
		
		protected function backToMain(event:Event):void
		{
			dispatchEvent(event);
		}		
	}
}