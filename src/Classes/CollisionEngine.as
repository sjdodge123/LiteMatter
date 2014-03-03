package Classes
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CollisionEngine
	{		
		public function CollisionEngine()
		{
			
		}
		
		public function testGeneralCollision(movingObj:GameObject, staticObj:GameObject,boxArray:Array):Boolean
		{
			if(testCollisionCheap(movingObj,staticObj))
			{
				if(boxArray != null)
				{
					for(var i:int=0; i<boxArray.length;i++)
					{
						if(testCollisionExp(boxArray[i],staticObj))
						{
						return true;
						break;
						}
						else
						{
						return false;
						}
					}
				}				
				else
				{
					if(testCollisionExp(movingObj,staticObj))
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
			if (staticObj.hitTestPoint(topLeftPoint.x,topLeftPoint.y,true)||
				staticObj.hitTestPoint(bottomRightPoint.x, bottomRightPoint.y, true)||
				staticObj.hitTestPoint(topRightPoint.x, topRightPoint.y, true)||
				staticObj.hitTestPoint(bottomLeftPoint.x, bottomLeftPoint.y, true))
			{
				return true;
			}
			else
			{
				return false;
			}		
		}	
	}
}