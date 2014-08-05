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
		
		public function nextLabel(event:Event):void
		{
			if(currentIndex+1 < textArray.length)
			{
				removeChild(textArray[currentIndex]);
				currentIndex += 1;
				addChild(textArray[currentIndex]);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,textArray[currentIndex],true));
			}
			else
			{
				removeChild(textArray[currentIndex]);
				currentIndex = 0;
				addChild(textArray[currentIndex]);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,textArray[currentIndex],true));
			}
		}
		public function previousLabel(event:Event):void
		{
			if(currentIndex != 0)
			{
				removeChild(textArray[currentIndex]);
				currentIndex -= 1;
				addChild(textArray[currentIndex]);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,textArray[currentIndex],true));
			}
			else
			{
				removeChild(textArray[currentIndex]);
				currentIndex = textArray.length-1;
				addChild(textArray[currentIndex]);
				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,textArray[currentIndex],true));
			}
		}
		public function addLabel(newLabel:LabelBox):LabelBox
		{
			newLabel.changeHeight(size+7);
			newLabel.x += baseX+107.5;
			newLabel.y += baseY-15;
			newLabel.width = 200;
			textArray.push(newLabel);
			return newLabel;
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
					dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,textArray[currentIndex],true));
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
	}

}