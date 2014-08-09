package Interfaces
{
	import Classes.PlayerObject;
	
	import Events.EFireCannon;
	
	public interface IWeaponModel
	{
		function buildModel(playerObject:PlayerObject):void
		function fireWeaponOne(event:EFireCannon):void 
		function fireWeaponTwo(event:EFireCannon):void 
		function getOneReadyToShoot():Boolean
		function getTwoReadyToShoot():Boolean
	}
}