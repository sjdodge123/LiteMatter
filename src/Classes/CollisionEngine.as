package Classes
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Interfaces.IObjectMethods;
	
	public class CollisionEngine
	{	
		private var collisionPoint:Point;
		public function CollisionEngine()
		{
			
		}
		
		public function testGeneralCollision(movingObj:GameObject, staticObj:IObjectMethods,boxArray:Array):Boolean
		{
			if(testCollisionCheap(movingObj,staticObj.getHitArea()))
			{
				if(boxArray != null)
				{
					for(var i:int=0; i<boxArray.length;i++)
					{
						if(testCollisionExp(boxArray[i],staticObj.getHitArea()))
						{
						return true;
						}
					}
				}				
				else
				{
					if(testCollisionExp(movingObj,staticObj.getHitArea()))
					{
						return true;
					}
					else
					{
						return false;
					}	
				}
				return false;
			}
			else
			{
				return false;
			}
		}	
		public function testCollisionCheap(movingObj:GameObject, staticObj:GameObject):Boolean
		{
			if(staticObj.hitTestObject(movingObj))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function testCollisionExp(movingObj:GameObject, staticObj:GameObject):Boolean
		{
			var ob1Bounds:Rectangle = movingObj.getBounds(movingObj);
			var topLeftPoint:Point = movingObj.localToGlobal(ob1Bounds.topLeft);
			var bottomRightPoint:Point = movingObj.localToGlobal(ob1Bounds.bottomRight);
			var topRightPoint:Point = new Point(ob1Bounds.right, ob1Bounds.top);
				topRightPoint = movingObj.localToGlobal(topRightPoint);
			var bottomLeftPoint:Point = new Point(ob1Bounds.left, ob1Bounds.bottom);
				bottomLeftPoint = movingObj.localToGlobal(bottomLeftPoint);
			if (staticObj.hitTestPoint(topLeftPoint.x,topLeftPoint.y,true))
			{
				collisionPoint = new Point(topLeftPoint.x,topLeftPoint.y);
				return true;
			}
			else if(staticObj.hitTestPoint(bottomRightPoint.x, bottomRightPoint.y, true))
			{
				collisionPoint = new Point(bottomRightPoint.x,bottomRightPoint.y);
				return true;
			}
			else if(staticObj.hitTestPoint(topRightPoint.x, topRightPoint.y, true))
			{
				collisionPoint = new Point(topRightPoint.x,topRightPoint.y);
				return true;
			}
			else if(staticObj.hitTestPoint(bottomLeftPoint.x, bottomLeftPoint.y, true))
			{
				collisionPoint = new Point(bottomLeftPoint.x,bottomLeftPoint.y);
				return true;
			}
			else
			{
				return false;
			}		
		}
		public function getCollisionPoint():Point
		{
			return collisionPoint;
		}
	}
}