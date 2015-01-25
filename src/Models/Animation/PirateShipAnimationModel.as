package Models.Animation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Events.AnimationEvent;
	
	public class PirateShipAnimationModel extends MovieClip
	{
		private var shipBody:MovieClip;
		private var ldrContent:MovieClip;
		private var HP:int = 100;
		private var startIndex:int;
		private var endIndex:int;
		
		public function PirateShipAnimationModel(shipBody:MovieClip , ... AnimationLoaders)
		{
			this.shipBody = shipBody;
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
				case (HP <= 75 && HP > 50):
				{
					aniLoop(10,45);
					break;
				}
				case (HP <= 50 && HP > 25):
				{
					aniLoop(1,2);
					break;
				}
				case (HP <= 25):
				{
					aniLoop(1,2);
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
			ldrContent.gotoAndPlay(startIndex);
			this.startIndex = startIndex;
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
		}		
	
	}
}