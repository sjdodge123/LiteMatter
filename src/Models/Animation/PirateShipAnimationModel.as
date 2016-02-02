package Models.Animation
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Events.AnimationEvent;
	
	import UI.Blocks.MaskBox;
	import flash.display.DisplayObject;
	
	public class PirateShipAnimationModel extends MovieClip
	{
		private var shipBody:MovieClip;
		private var ldrContent:MovieClip;
		private var HP:int = 100;
		private var startIndex:int;
		private var endIndex:int;
		private var indicators:MovieClip;
		private var maskOne:MaskBox;
		
		public function PirateShipAnimationModel(shipBody:MovieClip,indicators:MovieClip, ... AnimationLoaders)
		{
			
			maskOne = new MaskBox(0,0,0,0,0x000000);
			addChild(maskOne);
			this.shipBody = shipBody;
			this.indicators = indicators;
			addChild(indicators);
			shipBody.addEventListener(AnimationEvent.LOAD_COMPLETE,getContent);
			for each (var animation:MovieClip in AnimationLoaders)
			{
				addChild(animation);
			}
			
			
		}
		protected function getContent(event:AnimationEvent):void
		{
			shipBody.removeEventListener(AnimationEvent.LOAD_COMPLETE,getContent);
			ldrContent = event.params as MovieClip;
			addChild(shipBody);		
		}
		
		public function updateHP(HP:int):void
		{
			this.HP = HP;
			switch(true)
			{
				//75 % health
				case (HP <= 75 && HP > 50):
				{
					aniLoop(10,44);
					break;
				}
					//50 % health
				case (HP <= 50 && HP > 25):
				{
					aniLoop(45,97);
					break;
				}
					//25 % health
				case (HP <= 25):
				{
					aniLoop(98,150);
					break;
				}
			}
		}
		
		public function reset():void
		{
			ldrContent.gotoAndStop(1);
		}
		
		private function aniLoop(startIndex:int,endIndex:int):void
		{
			
			this.startIndex = startIndex;
			ldrContent.gotoAndPlay(startIndex);
			this.endIndex = endIndex;
			if(!this.hasEventListener(Event.ENTER_FRAME))
			{
				addEventListener(Event.ENTER_FRAME,update);
			}
		}
		
		protected function update(event:Event):void
		{
			if(ldrContent.currentFrame >= endIndex)
			{
				ldrContent.gotoAndPlay(startIndex);
			}
			if(startIndex == 98)
			{
				trace();
			}
		}		
	
		public function setColor(playerColor:uint):void
		{
			setChildIndex(this.indicators,0);
			addMaskOne(this.indicators,playerColor);		
		}
		
		private function addMaskOne(obj:Sprite,color:uint):void
		{
			
			removeChild(maskOne);
			maskOne = new MaskBox(obj.x-200,obj.y-35,500,500,color);
			maskOne.alpha = .3;
			addChild(maskOne);
			maskOne.mask = obj;
		}
	}
}