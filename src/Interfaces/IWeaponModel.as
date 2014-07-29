package Interfaces
{
	import Classes.PlayerObject;
	
	public interface IWeaponModel
	{
		function buildModel(playerObject:PlayerObject):void
		function getOneReadyToShoot():Boolean
		function getTwoReadyToShoot():Boolean
	}
}