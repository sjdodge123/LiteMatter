package UI.Components
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Events.ButtonEvent;
	import Events.SelectionEvent;
	
	import UI.Blocks.ArrowButton;
	import UI.Blocks.LabelBox;

	/**
	 * ...
	 * @author Jake
	 */
	public class SideScrollBox extends Sprite
	{
		private var textArray:Vector.<LabelBox>;
		private var size:int;
		private var baseX:int;
		private var baseY:int;
		private var currentIndex:int = 0;
		private var leftArrowButton:ArrowButton;
		private var rightArrowButton:ArrowButton;
		
		public function SideScrollBox(baseX:int,baseY:int,firstLabel:LabelBox,size:int=30) 
		{
			this.baseX = baseX;
			this.baseY = baseY;
			this.size = size;
			textArray = new Vector.<LabelBox>;
			addLabel(firstLabel);
			leftArrowButton = new ArrowButton(baseX, baseY,1);
			leftArrowButton.addEventListener(ButtonEvent.PRESSED,previousLabel);
			rightArrowButton = new ArrowButton(baseX + 200, baseY);
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
				currentIndex += 1;
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
		public function addLabel(newLabel:LabelBox):LabelBox
		{
			if(!searchForLabel(newLabel))
			{
				newLabel.width = 200;
				textArray.push(newLabel);
				return newLabel;
			}
			return null;		
		}
		
		public function addColorLabel(title:String,color:uint):LabelBox
		{
			var newColor:LabelBox = new LabelBox(title,baseX+110,baseY-15,200,30,37,color);
			textArray.push(newColor);
			return newColor;
		}
		
		private function searchForLabel(newLabel:LabelBox):Boolean
		{
			if(textArray.indexOf(newLabel) >= 0)
			{
				return true;
			}
			return false;
		}
		public function removeLabel(deadLabel:LabelBox):void
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
		public function changeLabel(label:LabelBox):void
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
		public function getCurrentLabel():LabelBox
		{
			return textArray[currentIndex];
		}
		
		public function checkCurrentLabel(label:LabelBox):Boolean
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
		
		public function disableButtons():void
		{
			leftArrowButton.removeEventListener(ButtonEvent.PRESSED,previousLabel);
			leftArrowButton.disableButton();
			rightArrowButton.removeEventListener(ButtonEvent.PRESSED,previousLabel);
			rightArrowButton.disableButton();
		}
		public function enableButtons():void
		{
			leftArrowButton.addEventListener(ButtonEvent.PRESSED,previousLabel);
			leftArrowButton.enableButton();
			rightArrowButton.addEventListener(ButtonEvent.PRESSED,previousLabel);
			rightArrowButton.enableButton();
		}
		
		private function changeText(value:String,size:int):void 
		{
			removeChild(text);
			var text:LabelBox = new LabelBox(value, 625, 485, 200, 30);
			text.changeHeight(size);
			addChild(text);
		}
		public function getLength():int
		{
			return textArray.length;
		}
	}

}