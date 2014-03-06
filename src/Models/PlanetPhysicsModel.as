package Models
{
	import Interfaces.IStaticPhysicsModel;

	public class PlanetPhysicsModel implements IStaticPhysicsModel
	{
		private const gravConst:Number = 26000000;
		public function PlanetPhysicsModel()
		{
		}
		
		public function getGravityConst():Number
		{
		 return gravConst;
		}
	}
}