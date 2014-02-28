package Classes.GameBoard
{
	import flash.utils.getTimer;

	public class StopWatch
	{
		private var dt:Number;
		private var previousTime:Number;
		private var newTime:Number;
		
		public function StopWatch()
		{
			previousTime = getTimer();
		}
		public  function calcTime():Number
		{
			newTime=getTimer();
			dt = (newTime-previousTime)/1000;
			previousTime=newTime;
			return dt;
		}
	}
}