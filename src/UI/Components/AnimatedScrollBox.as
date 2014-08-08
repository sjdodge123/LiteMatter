package UI.Components
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Events.ButtonEvent;
	import Events.SelectionEvent;
	
	import UI.Blocks.StaticClipLabel;
	import UI.Blocks.AnimatedArrow;
	import UI.Blocks.StaticClipLabel;

	/**
	 * ...
	 * @author Jake
	 */
	public class AnimatedScrollBox extends Sprite
	{
		private var textArray:Vector.<StaticClipLabel>;
		private var size:int;
		private var baseX:int;
		private var baseY:int;
		private var currentIndex:int = 0;
		private var leftArrowButton:AnimatedArrow;
		private var rightArrowButton:AnimatedArrow;
		
		public function AnimatedScrollBox(baseX:int,baseY:int,firstLabel:StaticClipLabel,size:int=30) 
		{
			this.baseX = baseX;
			this.baseY = baseY;
			this.size = size;
			textArray = new Vector.<StaticClipLabel>;
			addLabel(firstLabel);
			leftArrowButton = new AnimatedArrow("./Images/leftArrowButton.swf",baseX-50, baseY);
			leftArrowButton.addEventListener(ButtonEvent.PRESSED,previousLabel);
			rightArrowButton = new AnimatedArrow("./Images/rightArrowButton.swf",baseX + 250, baseY);
			rightArrowButton.addEventListener(ButtonEvent.PRESSED,nextLabel);
			addChild(rightArrowButton);
			addChild(leftArrowButton);
			addChild(textArray[currentIndex]);
		}
		
		public function nextLabel(event:Event):Boolean
		{
			var changeArray:Array;
			if(currentIndex+1 < textArray.length)
			{
				removeChildren();
				currentIndex++;
				addChild(textArray[currentIndex]);
				addChild(rightArrowButton);
				addChild(leftArrowButton);
				changeArray = new Array();
				changeArray.push(this);	
				changeArray.push(true);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,changeArray));
				return true;
			}
			else
			{
				removeChildren();
				currentIndex = 0;
				addChild(textArray[currentIndex]);
				addChild(rightArrowButton);
				addChild(leftArrowButton);
				changeArray = new Array();
				changeArray.push(this);	
				changeArray.push(true);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,changeArray));
				return false;
			}
		}
		public function previousLabel(event:Event):Boolean
		{
			var changeArray:Array;
			if(currentIndex != 0)
			{
				removeChildren();
				currentIndex -= 1;
				addChild(textArray[currentIndex]);
				addChild(rightArrowButton);
				addChild(leftArrowButton);
				changeArray = new Array();
				changeArray.push(this);	
				changeArray.push(false);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,changeArray));
				return true;
			}
			else
			{
				removeChildren();
				currentIndex = textArray.length-1;
				addChild(textArray[currentIndex]);
				addChild(rightArrowButton);
				addChild(leftArrowButton);
				changeArray = new Array();
				changeArray.push(this);	
				changeArray.push(false);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,changeArray));
				return false;
			}
		}
		public function addLabel(newLabel:StaticClipLabel):StaticClipLabel
		{
			if(!searchForLabel(newLabel))
			{
				textArray.push(newLabel);
				return newLabel;
			}
			return null;		
		}
		
		private function searchForLabel(newLabel:StaticClipLabel):Boolean
		{
			if(textArray.indexOf(newLabel) >= 0)
			{
				return true;
			}
			return false;
		}
		public function removeLabel(deadLabel:StaticClipLabel):void
		{
			var removeColor:uint = deadLabel.getColor();
			var loc:int = textArray.indexOf(deadLabel);
			var index:int = indexOfColor(removeColor);
			textArray.splice(loc,1);
			if(loc < 0)
			{
				textArray.splice(index,1);
			}
			
			if(checkCurrentLabel(deadLabel) || index < 0)
			{
				trace("Label is not a member of this");
			}
		}
		public function changeLabel(label:StaticClipLabel):void
		{
			for(var i:int=0; i<textArray.length;i++)
			{
				if(textArray[i] == label)
				{
					removeChild(textArray[currentIndex]);
					currentIndex = i;
					addChild(textArray[currentIndex]);
				}
			}
		}
		public function getCurrentLabel():StaticClipLabel
		{
			return textArray[currentIndex];
		}
		
		public function checkCurrentLabel(label:StaticClipLabel):Boolean
		{
			if(currentIndex == textArray.indexOf(label))
			{
				return true;
			}
			return false;
		}
		public function indexOfColor(color:uint):int
		{
			for(var i:int=0;i<textArray.length;i++)
			{
				if(textArray[i].getColor() ==  color)
				{
					return i;
				}
			}
			return -1;
		}
			
		public function getLength():int
		{
			return textArray.length;
		}
	}

}