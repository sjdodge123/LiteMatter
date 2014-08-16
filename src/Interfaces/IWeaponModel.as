package Interfaces
{
	import flash.events.IEventDispatcher;
	import Classes.BasicObject;
	
	public interface IWeaponModel extends IEventDispatcher
	{
		function fireWeaponOne(travelInfo:Vector.<Number>):void ;
		function fireWeaponTwo(travelInfo:Vector.<Number>):void;
		function getOneReadyToShoot():Boolean;
		function getTwoReadyToShoot():Boolean;
		function injectBullets(bulletOne:BasicObject,bulletTwo:BasicObject):void;
	}
}