package Models.Sound 
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import Interfaces.IInputHandling;
	
	public class thrusterModel 
	{
		private var continiousThrust:Sound;
		private var inputModel:IInputHandling;
		private var soundChannel:SoundChannel;
		private var transform:SoundTransform;
		private var continiousThrustTimer:Timer;
		private var isPlaying:Boolean;
		public function thrusterModel() 
		{
			
			soundChannel = new SoundChannel();
		
			
		}
		public function buildModel(continiousThrust:Sound,duration:Number,volume:Number):void 
		{
			this.continiousThrust = continiousThrust;
			continiousThrustTimer = new Timer(duration, 1);
			continiousThrustTimer.addEventListener(TimerEvent.TIMER_COMPLETE, playThrust);
			continiousThrustTimer.reset();
			continiousThrustTimer.start();
			transform = new SoundTransform(volume);
		}
		
		public function playSound():void 
		{
			if (!isPlaying) 
			{
				soundChannel = continiousThrust.play(0,0,transform);
				continiousThrustTimer.reset();
				continiousThrustTimer.start();
				isPlaying = true;
			}
		}
		public function stopSound():void 
		{
			if (isPlaying) 
			{
				soundChannel.stop();
				isPlaying = false;
			}
		}
		private function playThrust(event:TimerEvent):void 
		{
			isPlaying = false;
			
		}
	}

}