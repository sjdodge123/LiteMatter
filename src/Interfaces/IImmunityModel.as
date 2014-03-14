package Interfaces
{
	import Classes.PlayerObject;

	public interface IImmunityModel
	{
		function buildModel(playerObject:PlayerObject):void;
		function resetShotTimer():void;
		function resetImmuneTimer():void;
		function getImmuneStatus():Boolean;
	}
}