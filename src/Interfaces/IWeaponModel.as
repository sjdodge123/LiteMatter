package Interfaces
{
	import Classes.PlayerObject;

	public interface IWeaponModel
	{
		function fireWeapon(weaponNum:int,playerObject:PlayerObject):void
	}
}