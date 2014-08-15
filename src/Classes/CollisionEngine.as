package Classes
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CollisionEngine
	{	
		private var collisionPoint:Point;
		private var hit:Boolean = false;
		public function CollisionEngine()
		{
			
		}
		
		public function testGeneralCollision(movingObj:GameObject, staticObj:GameObject,boxArray:Array):Boolean
		{
			
			hit = testCollisionCheap(movingObj,staticObj);
			if(hit && (boxArray != null))
			{
				for(var i:int=0; i<boxArray.length;i++)
				{
					hit = testCollisionExp(boxArray[i],staticObj)
					if(hit)
					{
						break;
					}
				}
			}
			return hit;
		}
		private function testCollisionCheap(movingObj:GameObject, staticObj:GameObject):Boolean
		{
			return staticObj.hitTestObject(movingObj)
		}
		
		private function testCollisionExp(movingObj:GameObject, staticObj:GameObject):Boolean
		{
			var ob1Bounds:Rectangle = movingObj.getBounds(movingObj);
			var topLeftPoint:Point = movingObj.localToGlobal(ob1Bounds.topLeft);	
			if (staticObj.hitTestPoint(topLeftPoint.x,topLeftPoint.y,true))
			{
				collisionPoint = new Point(topLeftPoint.x,topLeftPoint.y);
				return true;
			}
			var bottomRightPoint:Point = movingObj.localToGlobal(ob1Bounds.bottomRight);
			if(staticObj.hitTestPoint(bottomRightPoint.x, bottomRightPoint.y, true))
			{
				collisionPoint = new Point(bottomRightPoint.x,bottomRightPoint.y);
				return true;
			}
			var topRightPoint:Point = new Point(ob1Bounds.right, ob1Bounds.top);
			topRightPoint = movingObj.localToGlobal(topRightPoint);
			if(staticObj.hitTestPoint(topRightPoint.x, topRightPoint.y, true))
			{
				collisionPoint = new Point(topRightPoint.x,topRightPoint.y);
				return true;
			}
			var bottomLeftPoint:Point = new Point(ob1Bounds.left, ob1Bounds.bottom);
			bottomLeftPoint = movingObj.localToGlobal(bottomLeftPoint);
			if(staticObj.hitTestPoint(bottomLeftPoint.x, bottomLeftPoint.y, true))
			{
				collisionPoint = new Point(bottomLeftPoint.x,bottomLeftPoint.y);
				return true;
			}
			return false;		
		}
		public function getCollisionPoint():Point
		{
			return collisionPoint;
		}
	}
}