package Classes.GameBoard 
{
	import flash.net.URLRequest;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Jake
	 */
	public class SoundLoader 
	{
		
		
		
		public function SoundLoader() 
		{
			
		}
		
		public function loadSound(path:String):Sound
		{
			var req:URLRequest = new URLRequest(path); 
			return(new Sound(req)); 
		}
		
		
	}

}