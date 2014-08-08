package UI.Components
{
	import flash.display.Sprite;
	import flash.ui.GameInputDevice;
	
	import Events.SelectionEvent;
	
	import UI.Blocks.LabelBox;
	import UI.Blocks.MaskBox;
	import UI.Blocks.StartGameObject;
	import UI.Blocks.StaticClipLabel;
	import UI.ScoreBoard.ScorePage;

	public class ShipOptionsSWF extends Sprite
	{
		private var compList:Array;
		private var playerTitle:StaticClipLabel;
		private var playerType:AnimatedScrollBox;
		private var humanLabel:StaticClipLabel;
		private var xbox:StaticClipLabel;
		private var computerLabel:StaticClipLabel;
		private var AIEasy:StaticClipLabel;
		private var secondPlayer:StaticClipLabel;
		private var firstPlayer:StaticClipLabel;
		private var page:ScorePage;
		private var inputSignal:int;
		private var humanInputs:AnimatedScrollBox;
		private var computerInputs:AnimatedScrollBox;
		private var playerColor:uint;
		private var device:GameInputDevice = null;
		private var deviceID:int;
		private var colorSelection:AnimatedScrollBox;
		private var unlockedColor:StaticClipLabel;
		private var redColor:StaticClipLabel;
		private var blueColor:StaticClipLabel;
		private var playerNumber:StaticClipLabel;
		private var maskOne:MaskBox;
		private var maskTwo:MaskBox;
		private var controllerNum:StaticClipLabel;
		public function ShipOptionsSWF(x:int,y:int,page:ScorePage)
		{
			this.x = x;
			this.y = y;
			this.page = page;
			compList = new Array();
			var border:Sprite = new Sprite();
			border.graphics.beginFill(0x333333,0);
			border.graphics.drawRect(x,y,450,700);
			border.graphics.endFill();
			addChild(border);
			
			var shipBox:Sprite = new Sprite();
			shipBox.graphics.beginFill(0x333333,1);
			shipBox.graphics.drawRect(x,y,450,250);
			shipBox.graphics.endFill();
			addChild(shipBox);
			
			
			var inputBox:Sprite = new Sprite();
			inputBox.graphics.beginFill(0x333333,1);
			inputBox.graphics.drawRect(x,y+250,450,150);
			inputBox.graphics.endFill();
			addChild(inputBox);
			controllerNum = new StaticClipLabel("./Images/oneText.swf",x+310,610,"ONE");
			
			playerTitle = new StaticClipLabel("./Images/playerText.swf",x+175,15,"TITLE");
			addComp(playerTitle);
			if(page.getPlayerNum()+1 == 1)
			{
				playerNumber= new StaticClipLabel("./Images/oneText.swf",x+310,450,"NUMBER");
				
			}
			if(page.getPlayerNum()+1 == 2)
			{
				playerNumber= new StaticClipLabel("./Images/twoText.swf",x+310,450,"NUMBER");
				
			}
			addChild(playerNumber);
			
			computerLabel = new StaticClipLabel("./Images/compText.swf",x+225,15,"COMP");
			humanLabel = new StaticClipLabel("./Images/playerText.swf",x+225,15,"PLAYER");
			playerType = new AnimatedScrollBox(x+125,y+5,humanLabel);
			playerType.addLabel(computerLabel);
			addComp(playerType);
			playerType.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			
			
			
			firstPlayer = new StaticClipLabel("./Images/wasdText.swf",x+225,15,"WASD");
			secondPlayer = new StaticClipLabel("./Images/ijklText.swf",x+225,15,"IJKL");
			humanInputs = new AnimatedScrollBox(x+125,y+5,firstPlayer);
			humanInputs.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			humanInputs.addLabel(secondPlayer);
			
			
			AIEasy = new StaticClipLabel("./Images/oneText.swf",x+225,15,"ONE");
			computerInputs =  new AnimatedScrollBox(x+125,y+05,AIEasy);
			
			redColor = new StaticClipLabel("./Images/redText.swf",x+225,15,"RED",0xFF0000);
			blueColor = new StaticClipLabel("./Images/blueText.swf",x+225,15,"BLUE",0x0000FF);
			
			colorSelection = new AnimatedScrollBox(x+125,y+05,redColor);
			colorSelection.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			colorSelection.addLabel(blueColor);
			colorSelection.addLabel(new StaticClipLabel("./Images/greenText.swf",x+225,15,"GREEN",0x00FF00));
			colorSelection.addLabel(new StaticClipLabel("./Images/tealText.swf",x+225,15,"TEAL",0x3EB489));
			colorSelection.addLabel(new StaticClipLabel("./Images/magentaText.swf",x+225,15,"MAGENTA",0xFF00FF));
			
			//If Player 1
			if(page.getPlayerNum()+1 == 1)
			{
				playerColor = redColor.getColor();
				addComp(humanInputs);
				addComp(colorSelection);
			}
			//If Player 2
			if(page.getPlayerNum()+1 == 2)
			{
				playerColor = blueColor.getColor();
				colorSelection.changeLabel(blueColor);
				playerType.changeLabel(computerLabel);
				addComp(computerInputs);
				addComp(colorSelection);
			}
			
			maskOne = new MaskBox(0,0,0,0,playerColor);
			addChild(maskOne);
			maskTwo = new MaskBox(0,0,0,0,playerColor);
			addChild(maskTwo);
			page.setColor(playerColor);
			addMaskOne(playerTitle);
			addMaskTwo(playerNumber);
		}
		public function resetPage(page:ScorePage,color:uint):void
		{
			this.page = page;
			page.setColor(color);
		}
		
		protected function inputTypeChanged(event:SelectionEvent):void
		{
			var id:int;
			var currentLabel:StaticClipLabel;
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
			if(event.params[0] == humanInputs)
			{
				currentLabel = humanInputs.getCurrentLabel();
				if(currentLabel == xbox)
				{
					addChild(controllerNum);
					if(page.getPlayerNum()+1 == 1)
					{
						//Does not display correct value && sometimes they are set for both players
						if(xbox.getColor() == 1)
						{
							removeChild(controllerNum);
							controllerNum = new StaticClipLabel("./Images/oneText.swf",x+310,610,"ONE");
							addChild(controllerNum);
						}
						if(xbox.getColor() == 2)
						{
							removeChild(controllerNum);
							controllerNum = new StaticClipLabel("./Images/twoText.swf",x+310,610,"TWO");
							addChild(controllerNum);
						}
						
					}
					if(page.getPlayerNum()+1 == 2)
					{
						if(xbox.getColor() == 1)
						{
							removeChild(controllerNum);
							controllerNum = new StaticClipLabel("./Images/oneText.swf",x+310,610,"ONE");
							addChild(controllerNum);
						}
						if(xbox.getColor() == 2)
						{
							removeChild(controllerNum);
							controllerNum = new StaticClipLabel("./Images/twoText.swf",x+310,610,"TWO");
							addChild(controllerNum);
						}
					}	
				}
				else
				{
					if(contains(controllerNum))
					{
						removeChild(controllerNum);	
					}
					
				}
			}
			if(event.params[0] == colorSelection)
			{
				var colorChanges:Array = new Array();
				var newColor:StaticClipLabel = colorSelection.getCurrentLabel();
				page.setColor(newColor.getColor());
				playerColor = page.getColor();;
				addMaskOne(playerTitle);
				addMaskTwo(playerNumber);
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
				obj.y = 450 + i*72.5;
			}
		}
		private function addMaskOne(obj:Sprite):void
		{
			removeChild(maskOne)
			maskOne = new MaskBox(obj.x-125,obj.y-35,250,72.5,playerColor);
			addChild(maskOne);
			maskOne.mask = obj;
		}
		private function addMaskTwo(obj:Sprite):void
		{
			removeChild(maskTwo)
			maskTwo = new MaskBox(obj.x-125,obj.y-35,250,72.5,playerColor);
			addChild(maskTwo);
			maskTwo.mask = obj;
		}
		
		
		
		public function deviceAdded(deviceID:int,device:GameInputDevice):void
		{
			xbox = new StaticClipLabel("./Images/controllerText.swf",x+170,15,"XBOX",deviceID);
			humanInputs.addLabel(xbox);
			if(page.getPlayerNum()+1 == deviceID)
			{
				if(deviceID == 1)
				{
					controllerNum = new StaticClipLabel("./Images/oneText.swf",x+310,610,"ONE");
					addChild(controllerNum);
				}
				if(deviceID == 2)
				{
					playerType.changeLabel(humanLabel);
					var id:int = removeComp(computerInputs);
					addCompAt(id,humanInputs);
					controllerNum = new StaticClipLabel("./Images/twoText.swf",x+310,610,"TWO");
					addChild(controllerNum);
				}
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
			var input:StaticClipLabel;
			if(contains(humanInputs))
			{
				input = humanInputs.getCurrentLabel();
			}
			else
			{
				input = computerInputs.getCurrentLabel();
			}
			
			if(input.getID() == "WASD")
			{
				inputSignal = 1;
			}
			if(input.getID() == "IJKL")
			{
				inputSignal = 2;
			}
			if(input.getID()== "XBOX")
			{
				inputSignal = 3;
			}
			if(input.getID() == "ONE")
			{
				inputSignal = 4;
			}
			return new StartGameObject(inputSignal,page,device);
			
		}
		
		
		public function addColor(unlockedColor:LabelBox,lockedColor:LabelBox):void
		{
//			colorSelection.addColorLabel(unlockedColor.text.text,unlockedColor.getColor());
//			colorSelection.removeLabel(lockedColor);
			
		}
	}
}