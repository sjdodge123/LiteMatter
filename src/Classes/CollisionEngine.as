package Classes
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Interfaces.ICollisionObject;
	
	public class CollisionEngine implements ICollisionObject
	{
		public function CollisionEngine()
		{
		}
		
		public function testGeneralCollision(movingObj:DynamicObject,movingObjHitBoxName:String, staticObj:StaticObject, staticObjHitBoxName:String):Boolean
		{
			if(testCollisionCheap(movingObj,staticObj))
			{
				if(testCollisionExp(movingObj,movingObjHitBoxName,staticObj,staticObjHitBoxName))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}	
		public function testCollisionCheap(movingObj:DynamicObject, staticObj:StaticObject):Boolean
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
		
		public function testCollisionExp(movingObj:DynamicObject,movingObjHitBoxName:String, staticObj:StaticObject, staticObjHitBoxName:String):Boolean
		{
			var ob1Bounds:Rectangle = movingObj[movingObjHitBoxName].getBounds(movingObj[movingObjHitBoxName]);
			var topLeftPoint:Point = movingObj[movingObjHitBoxName].localToGlobal(ob1Bounds.topLeft);
			var bottomRightPoint:Point = movingObj[movingObjHitBoxName].localToGlobal(ob1Bounds.bottomRight);
			var topRightPoint:Point = new Point(ob1Bounds.right, ob1Bounds.top);
				topRightPoint = movingObj[movingObjHitBoxName].localToGlobal(topRightPoint);
			var bottomLeftPoint:Point = new Point(ob1Bounds.left, ob1Bounds.bottom);
				bottomLeftPoint = movingObj[movingObjHitBoxName].localToGlobal(bottomLeftPoint);
			if (staticObj[staticObjHitBoxName].hitTestPoint(topLeftPoint.x,topLeftPoint.y,true)||
				staticObj[staticObjHitBoxName].hitTestPoint(bottomRightPoint.x, bottomRightPoint.y, true)||
				staticObj[staticObjHitBoxName].hitTestPoint(topRightPoint.x, topRightPoint.y, true)||
				staticObj[staticObjHitBoxName].hitTestPoint(bottomLeftPoint.x, bottomLeftPoint.y, true))
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