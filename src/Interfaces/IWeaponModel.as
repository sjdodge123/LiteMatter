package Interfaces
{
	import Classes.PlayerObject;
	import Classes.DynamicObject;

	public interface IWeaponModel
	{
		function buildModel(playerObject:PlayerObject):void
		function getOneReadyToShoot():Boolean
		function getTwoReadyToShoot():Boolean
	}
}