package Interfaces
{
	import Classes.PlayerObject;
	import Classes.DynamicObject;

	public interface IWeaponModel
	{
		function buildModel(playerObject:PlayerObject):void
		function fireWeapon(weaponNum:int):DynamicObject
		function getOneReadyToShoot():Boolean
		function getTwoReadyToShoot():Boolean
	}
}