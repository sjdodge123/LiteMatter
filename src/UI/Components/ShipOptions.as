package UI.Components
{
	import flash.display.Sprite;
	import flash.ui.GameInputDevice;
	import Events.SelectionEvent;
	import UI.Components.SideScrollBox;
	import UI.Blocks.LabelBox;
	import UI.Blocks.StartGameObject;
	import UI.ScoreBoard.ScorePage;

	public class ShipOptions extends Sprite
	{
		private var compList:Array;
		private var playerTitle:LabelBox;
		private var playerType:SideScrollBox;
		private var humanLabel:LabelBox;
		private var xbox:LabelBox;
		private var computerLabel:LabelBox;
		private var AIEasy:LabelBox;
		private var secondPlayer:LabelBox;
		private var firstPlayer:LabelBox;
		private var page:ScorePage;
		private var inputSignal:int;
		private var humanInputs:SideScrollBox;
		private var computerInputs:SideScrollBox;
		private var playerColor:uint;
		private var device:GameInputDevice = null;
		private var deviceID:int;
		private var colorSelection:SideScrollBox;
		private var unlockedColor:LabelBox;
		private var lockedColor:LabelBox;
		
		public function ShipOptions(x:int,y:int,page:ScorePage)
		{
			this.x = x;
			this.y = y;
			this.page = page;
			compList = new Array();
			var border:Sprite = new Sprite();
			border.graphics.beginFill(0xFFFFFF,0);
			border.graphics.drawRect(x,y,450,700);
			border.graphics.endFill();
			addChild(border);
			
			
			playerTitle = new LabelBox(page.getPlayerName(),x+225,y+400,250,30);
			addChild(playerTitle);
			
			var shipBox:Sprite = new Sprite();
			shipBox.graphics.beginFill(0xFFFFFF,0);
			shipBox.graphics.drawRect(x,y,450,250);
			shipBox.graphics.endFill();
			addChild(shipBox);
			
			
			var inputBox:Sprite = new Sprite();
			inputBox.graphics.beginFill(0xFFFFFF,0);
			inputBox.graphics.drawRect(x,y+250,450,150);
			inputBox.graphics.endFill();
			addChild(inputBox);
			
			
			
			
			computerLabel = new LabelBox("Computer",x+135,-5,30,37);
			humanLabel = new LabelBox("Human",x+135,-5,30,37);
			playerType = new SideScrollBox(x+75,y+5,computerLabel);
			playerType.addLabel(humanLabel);
			addComp(playerType);
			playerType.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			
			
			
			firstPlayer = new LabelBox("WASD",365+x,-5,30,37);
			secondPlayer = new LabelBox("IJKL",365+x,-5,30,37);
			
			humanInputs = new SideScrollBox(x+125,y+5,firstPlayer);
			humanInputs.addLabel(secondPlayer);
			
			
			AIEasy = new LabelBox("AI: Easy",365+x,-5,30,37);
			computerInputs =  new SideScrollBox(x+125,y+5,AIEasy);
			
			lockedColor = new LabelBox("Red",365+x,-5,30,37,0xFF0000);
			colorSelection = new SideScrollBox(x+125,y+5,new LabelBox("Blue",365+x,-5,30,37,0x0000FF));
			colorSelection.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			colorSelection.addLabel(lockedColor);
			colorSelection.addLabel(new LabelBox("Green",365+x,-5,30,37,0x00FF00));
			colorSelection.addLabel(new LabelBox("Purple",365+x,-5,30,37,0x9A32CD));
			
			//If Player 1
			if(page.getPlayerNum()+1 == 1)
			{
				playerType.changeLabel(humanLabel);
				playerType.enableButtons();
				colorSelection.changeLabel(lockedColor);
				playerColor = 0xFF0000;
				addComp(humanInputs);
				addComp(colorSelection);
			}
			//If Player 2
			if(page.getPlayerNum()+1 == 2)
			{
				playerColor = 0x0000FF;
				addComp(computerInputs);
				addComp(colorSelection);
			}
			
			page.setColor(playerColor);
			playerTitle.text.textColor = page.getColor();
		}
		public function resetPage(page:ScorePage,color:uint):void
		{
			this.page = page;
			page.setColor(color);
		}
		
		protected function inputTypeChanged(event:SelectionEvent):void
		{
			var id:int;
			var currentLabel:LabelBox;
			if(event.params[0] == playerType)
			{
				currentLabel = playerType.getCurrentLabel();
				if(currentLabel == computerLabel)
				{
					id = removeComp(humanInputs);
					addCompAt(id,computerInputs);
				}
				
				if(currentLabel == humanLabel)
				{
					id = removeComp(computerInputs);
					addCompAt(id,humanInputs);
				}
			}
			if(event.params[0] == colorSelection)
			{
				var colorChanges:Array = new Array();
				var newColor:LabelBox = colorSelection.getCurrentLabel();
				page.setColor(newColor.getColor());
				removeChild(playerTitle);
				playerTitle.text.textColor = page.getColor();
				addChild(playerTitle);
//				unlockedColor = lockedColor;
//				lockedColor = newColor;
//				colorChanges.push(unlockedColor,lockedColor);
//				dispatchEvent(new SelectionEvent(SelectionEvent.INPUT_CHANGE,colorChanges));
			}
		}
		
		private function addComp(obj:Sprite):void
		{
			compList.push(obj);
			setOrder(obj);
			addChild(obj);
		}
		private function addCompAt(id:int, obj:Sprite):void
		{
			compList[id] = obj;
			setOrder(obj);
			addChild(obj)
		}
		
		private function removeComp(obj:Sprite):int
		{
			var index:int;
			if(contains(obj))
			{
				removeChild(obj);
				index = compList.indexOf(obj);
				compList.splice(index,1);
				return index;
			}
			return -1;	
		}
		private function setOrder(obj:Sprite):void
		{
			for(var i:int=0; i<compList.length;i++)
			{
				obj.y = 450 + i*obj.height;
			}
		}
		
		
		
		public function deviceAdded(deviceID:int,device:GameInputDevice):void
		{
			xbox = new LabelBox("Controller " + deviceID,225+x,-5,200,30,37);
			humanInputs.addLabel(xbox);
			if(page.getPlayerNum()+1 == 1)
			{
				humanInputs.changeLabel(xbox);
			}
			this.device = device;
			this.deviceID = deviceID;
			
		}
		public function deviceRemoved(deviceID:int):void
		{
			if(deviceID == 1)
			{
				humanInputs.removeLabel(xbox);
				humanInputs.changeLabel(firstPlayer);
			}
			if(deviceID == 2)
			{
				humanInputs.removeLabel(xbox);
				humanInputs.changeLabel(secondPlayer);
			}
			this.device = device;
			this.deviceID = deviceID;
		}
		
		public function collectInfo():StartGameObject
		{
			var input:LabelBox;
			if(contains(humanInputs))
			{
				input = humanInputs.getCurrentLabel();
			}
			else
			{
				input = computerInputs.getCurrentLabel();
			}
			
			if(input.text.text == "WASD")
			{
				inputSignal = 1;
			}
			if(input.text.text == "IJKL")
			{
				inputSignal = 2;
			}
			if(input.text.text == "Controller " +deviceID)
			{
				inputSignal = 3;
			}
			if(input.text.text == "AI: Easy")
			{
				inputSignal = 4;
			}
			return new StartGameObject(inputSignal,page,device);
			
		}
		
		
		public function addColor(unlockedColor:LabelBox,lockedColor:LabelBox):void
		{
			colorSelection.addColorLabel(unlockedColor.text.text,unlockedColor.getColor());
			colorSelection.removeLabel(lockedColor);
			
		}
	}
}