package Models.Weapons
{
	import Classes.DynamicObject;
	import Classes.PlayerObject;
	import Classes.GameBoard.GameBoardObjects;
	
	import Interfaces.IWeaponModel;
	
	import Models.Collision.AsteriodCollisionModel;

	public class CannonModel implements IWeaponModel
	{
		private var gameBoard:Object;
		public function CannonModel(gameBoard:GameBoardObjects)
		{
			this.gameBoard = gameBoard;
		}
		
		public function fireWeapon(weaponNum:int,playerObject:PlayerObject):void
		{
			
			if(weaponNum == 1)
			{
				var projectileOne:DynamicObject = gameBoard.addDynamic("../Images/asteroid.png",-10,-10,playerObject.getX(),playerObject.getY()-35, playerObject.getStaticArray(),new AsteriodCollisionModel());
				projectileOne.velX = (350*playerObject.getDirY())+playerObject.getVelX();
				projectileOne.velY = (-350*playerObject.getDirX())+playerObject.getVelY();
				projectileOne.rotRate =-100;	
			}
			else if(weaponNum == 2)
			{
				var projectileTwo:DynamicObject = gameBoard.addDynamic("../Images/asteroid.png",-10,-10,playerObject.getX(),playerObject.getY()+35, playerObject.getStaticArray(),new AsteriodCollisionModel());
				projectileTwo.velX = (-350*playerObject.getDirY())+playerObject.getVelX();
				projectileTwo.velY = (350*playerObject.getDirX())+playerObject.getVelY();
				projectileTwo.rotRate =100;		
			}
			
		}
	}
}