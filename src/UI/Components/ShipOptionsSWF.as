package UI.Components
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.GameInputDevice;
	
	import Events.GameBoardEvent;
	import Events.SelectionEvent;
	
	import Interfaces.IInputHandling;
	
	import Models.Input.Player1InputModel;
	import Models.Input.Player2InputModel;
	import Models.Input.XboxControllerModel;
	
	import UI.Blocks.LabelBox;
	import UI.Blocks.MaskBox;
	import UI.Blocks.StartGameObject;
	import UI.Blocks.StaticClipLabel;
	import UI.ScoreBoard.ScorePage;
	import Models.Input.BasicAIModel;

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
		private var shipBox:ShipBox;
		private var gameStage:Stage;
		private var inputModel:IInputHandling;
		public function ShipOptionsSWF(x:int,y:int,page:ScorePage,gameStage)
		{
			this.x = x;
			this.y = y;
			this.page = page;
			this.gameStage = gameStage;
			compList = new Array();
			var border:Sprite = new Sprite();
			border.graphics.beginFill(0x333333,0);
			border.graphics.drawRect(x,y,450,700);
			border.graphics.endFill();
			addChild(border);
			
		
			
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
			
			computerLabel = new StaticClipLabel("./Images/compText.swf",x+225,15,"COMP",new LabelBox("Computer Player"));
			humanLabel = new StaticClipLabel("./Images/playerText.swf",x+225,15,"PLAYER",new LabelBox("Human Player"));
			playerType = new AnimatedScrollBox(x+125,y+5,humanLabel);
			playerType.addLabel(computerLabel);
			addComp(playerType);
			playerType.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			
			
			
			firstPlayer = new StaticClipLabel("./Images/wasdText.swf",x+225,15,"WASD",new LabelBox("Control with WASD. Fire with Q+E"));
			secondPlayer = new StaticClipLabel("./Images/ijklText.swf",x+225,15,"IJKL",new LabelBox("Control with IJKL. Fire with U+O"));
			humanInputs = new AnimatedScrollBox(x+125,y+5,firstPlayer);
			humanInputs.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			humanInputs.addLabel(secondPlayer);
			
			
			AIEasy = new StaticClipLabel("./Images/oneText.swf",x+225,15,"ONE");
			computerInputs =  new AnimatedScrollBox(x+125,y+05,AIEasy);
			
			redColor = new StaticClipLabel("./Images/redText.swf",x+225,15,"RED",null,0xFF0000);
			blueColor = new StaticClipLabel("./Images/blueText.swf",x+225,15,"BLUE",null,0x0000FF);
			
			colorSelection = new AnimatedScrollBox(x+125,y+05,redColor);
			colorSelection.addEventListener(SelectionEvent.INPUT_CHANGE,inputTypeChanged);
			colorSelection.addLabel(blueColor);
			colorSelection.addLabel(new StaticClipLabel("./Images/greenText.swf",x+225,15,"GREEN",null,0x00FF00));
			colorSelection.addLabel(new StaticClipLabel("./Images/yellowText.swf",x+225,15,"YELLOW",null,0xFFFF00));
			colorSelection.addLabel(new StaticClipLabel("./Images/tealText.swf",x+225,15,"TEAL",null,0x00CC99));
			colorSelection.addLabel(new StaticClipLabel("./Images/magentaText.swf",x+225,15,"MAGENTA",null,0xFF00FF));
			
			//If Player 1
			if(page.getPlayerNum()+1 == 1)
			{
				playerColor = redColor.getColor();
				addComp(humanInputs);
				addComp(colorSelection);
				this.inputModel = new Player1InputModel(this.gameStage);
			}
			//If Player 2
			if(page.getPlayerNum()+1 == 2)
			{
				playerColor = blueColor.getColor();
				colorSelection.changeLabel(blueColor);
				playerType.changeLabel(computerLabel);
				addComp(computerInputs);
				addComp(colorSelection);
				this.inputModel = new Player2InputModel(this.gameStage);
			}
			

			this.shipBox = new ShipBox(x,y,page,this.gameStage);
			addChild(shipBox);
			shipBox.addEventListener(GameBoardEvent.ADD,addSelectionObject);
			
			
			
			maskOne = new MaskBox(0,0,0,0,playerColor);
			addChild(maskOne);
			maskTwo = new MaskBox(0,0,0,0,playerColor);
			addChild(maskTwo);
			page.setColor(playerColor);
			addMaskOne(playerTitle);
			addMaskTwo(playerNumber);
		}
		
		protected function addSelectionObject(event:GameBoardEvent):void
		{
			dispatchEvent(event);
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
				
				if(currentLabel.getID() == "WASD"){
					this.inputModel = new Player1InputModel(this.gameStage);
				}
				if(currentLabel.getID() == "IJKL"){
					this.inputModel = new Player2InputModel(this.gameStage);
				}
				if(currentLabel.getID() == "XBOX"){
					this.inputModel = new XboxControllerModel(this.gameStage,this.device);
				}
				shipBox.reDraw(this.inputModel);
			}
			if(event.params[0] == colorSelection)
			{
				var colorChanges:Array = new Array();
				var newColor:StaticClipLabel = colorSelection.getCurrentLabel();
				page.setColor(newColor.getColor());
				playerColor = page.getColor();
				addMaskOne(playerTitle);
				addMaskTwo(playerNumber);
				shipBox.reDraw(this.inputModel);
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
			if(deviceID == 1)
			{
				xbox = new StaticClipLabel("./Images/oneText.swf",x+220,15,"XBOX");
				humanInputs.addLabel(xbox);
			}
			if(deviceID == 2)
			{
				playerType.changeLabel(humanLabel);
				var id:int = removeComp(computerInputs);
				addCompAt(id,humanInputs);
				xbox = new StaticClipLabel("./Images/twoText.swf",x+220,15,"XBOX");
				humanInputs.addLabel(xbox);
			}
			humanInputs.changeLabel(xbox);
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
		
		public function drawShip():void
		{
			shipBox.reDraw(this.inputModel);			
		}
		
		public function removeShip():void
		{
			shipBox.removeShip();
		}
	}
}