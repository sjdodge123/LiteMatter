package Recording
{

	public class FrameState
	{
		public var deltaT:Number;
		public var moveForward:Boolean;
		public var moveReverse:Boolean;
		public var moveLeft:Boolean;
		public var moveRight:Boolean;
		public var fireOne:Boolean;
		public var fireTwo:Boolean;
		public var shipX:Number;
		public var shipY:Number;
		public var shipZ:Number;
		public var shipHP:int;
		public var shipRespawn:int;
		public var shipImmune:Boolean;
		public var frameCount:int;
		
		public function FrameState()
		{
			
		}
	}
}