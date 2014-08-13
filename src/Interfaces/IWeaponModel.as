package Interfaces
{
	import Classes.PlayerObject;
	import flash.events.IEventDispatcher
	
	public interface IWeaponModel extends IEventDispatcher
	{
		function buildModel(playerObject:PlayerObject):void;
		function fireWeaponOne():void ;
		function fireWeaponTwo():void;
		function getOneReadyToShoot():Boolean;
		function getTwoReadyToShoot():Boolean;
	}
}