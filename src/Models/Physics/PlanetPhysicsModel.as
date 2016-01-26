package Models.Physics
{
	import Interfaces.IStaticPhysicsModel;

	public class PlanetPhysicsModel implements IStaticPhysicsModel
	{
//		private const gravConst:Number = 26000000;   // Normal
		//private const gravConst:Number = 26000000/2; // Low Gravity
		private const gravConst:Number = 0;          // No Gravity
		public function PlanetPhysicsModel()
		{
		}
		
		public function getGravityConst():Number
		{
		 return gravConst;
		}
	}
}