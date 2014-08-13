package Interfaces
{
	import flash.events.IEventDispatcher;
	
	public interface IWeaponModel extends IEventDispatcher
	{
		function fireWeaponOne(travelInfo:Vector.<Number>):void ;
		function fireWeaponTwo(travelInfo:Vector.<Number>):void;
		function getOneReadyToShoot():Boolean;
		function getTwoReadyToShoot():Boolean;
	}
}