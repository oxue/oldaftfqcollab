package sfbl 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TileEntity extends GfxSprite implements IUpdated
	{
		public var velX:Number;
		public var velY:Number;
		
		public var resting:Boolean;
		
		private var lastBB:Rectangle;
		private var currentBB:Rectangle;
		
		public var left:Number;
		public var right:Number;
		public var up:Number;
		public var down:Number;
		
		private var times:Vector.<CollisionData>;
		
		public function TileEntity(_x:int=0, _y:int=0, _graphics:BitmapData=null) 
		{
			super(_x, _y, _graphics);
			left = -originX;
			right = left + width;
			up = - originY;
			down = up + height;
			
			resting = false;
			
			velX = velY = 0;
			lastBB = new Rectangle(x, y, width, height);
			currentBB = new Rectangle(x, y, width, height);
		}
		
		override public function setAsAnimated(_width:int, _height:int, _frameTime:int):void 
		{
			super.setAsAnimated(_width, _height, _frameTime);
			left = -originX;
			right = left + width;
			up = - originY;
			down = up + height;
		}
		
		public function update():void
		{
			lastBB.x = x+left;
			lastBB.y = y+up;
			x += velX;
			y += velY;
			currentBB.x = x+left;
			currentBB.y = y+up;
		}
		
		public function solveMap(_tm:Tilemap):void
		{	
			
			var originalVel:Point = new Point(velX, velY);
			
			//union of the current bounding box and previous bounding box
			var limits:Rectangle = currentBB.union(lastBB);
			
			//this is a vector to store the times of collision and find the least
			times = new Vector.<CollisionData>();
			
			//declare vars for use in loop
			var f:CollisionData;
			var i:int;
			var j:int;
			
			//init var bounds/itterator
			var i0:int = (velX < 0) ? (int(limits.x / _tm.tileW) - 1) : (Math.ceil((limits.x + limits.width) / _tm.tileW));
			var i1:int = (velX >= 0) ? (int(limits.x / _tm.tileW) - 1) : (Math.ceil((limits.x + limits.width) / _tm.tileW));
			var ii:int = (velX < 0) ? 1 : -1;
			var j0:int = (velY < 0) ? (int(limits.y / _tm.tileH) - 1) : (Math.ceil((limits.y + limits.height) / _tm.tileH));
			var j1:int = (velY >= 0) ? (int(limits.y / _tm.tileH) - 1) : (Math.ceil((limits.y + limits.height) / _tm.tileH));
			var ji:int = (velY < 0) ? 1 : -1;
			
			//avoid out-of-bounds errors
			if (i0 < 0) { i0 = 0; }
			if (i1 < 0) { i1 = 0; }
			if (j0 < 0) { j0 = 0; }
			if (j1 < 0) { j1 = 0; }
			if (i0 >= _tm.mapW) { i0 = _tm.mapW - 1; }
			if (i1 >= _tm.mapW) { i1 = _tm.mapW - 1; }
			if (j0 >= _tm.mapH) { j0 = _tm.mapH - 1; }
			if (j1 >= _tm.mapH) { j1 = _tm.mapH - 1; }
			
			for (i = i0; i != i1; i+=ii)
			{
				for (j = j0; j != j1; j+=ji)
				{
					if (_tm.data[j][i] >= _tm.colIndex)
					{
						f = solveTile(i * _tm.tileW, j * _tm.tileH, _tm.tileW, _tm.tileH, limits);
						if (f.time != -1)
						times.push(f);
					}
				}
			}
			
			if (times.length == 0)
			{
				resting = false;
				velX = originalVel.x;
				velY = originalVel.y;
				return;
			}
			
			var bHit:Boolean = false;
			
			var maxf:CollisionData = times[times.length - 1];
			i = times.length;
			while (i--)
			{
				if (times[i].time > maxf.time)
				maxf = times[i];
			}
			
			x -= velX * maxf.time;
			y -= velY * maxf.time;
			
			if (maxf.side == 0)
			{
				velX = originalVel.x = 0;
				velY *= (maxf.time);
				
				trace("after", velY)
			}
			else
			{
				if (velY > 0) { bHit = true; }
				velY = originalVel.y = 0;
				velX *= maxf.time;
			}
			
			update();
			
			limits = currentBB.union(lastBB);
			
			//this is a vector to store the times of collision and find the least
			times = new Vector.<CollisionData>();
			
			i0 = (velX < 0) ? int(limits.x / _tm.tileW) : (Math.ceil((limits.x + limits.width) / _tm.tileW));
			i1 = (velX >= 0) ? int(limits.x / _tm.tileW) : (Math.ceil((limits.x + limits.width) / _tm.tileW));
			ii = (velX < 0) ? 1 : -1;
			j0 = (velY < 0) ? int(limits.y / _tm.tileH) : (Math.ceil((limits.y + limits.height) / _tm.tileH));
			j1 = (velY >= 0) ? int(limits.y / _tm.tileH) : (Math.ceil((limits.y + limits.height) / _tm.tileH));
			ji = (velY < 0) ? 1 : -1;
			
			//avoid out-of-bounds errors
			if (i0 < 0) { i0 = 0; }
			if (i1 < 0) { i1 = 0; }
			if (j0 < 0) { j0 = 0; }
			if (j1 < 0) { j1 = 0; }
			if (i0 >= _tm.mapW) { i0 = _tm.mapW - 1; }
			if (i1 >= _tm.mapW) { i1 = _tm.mapW - 1; }
			if (j0 >= _tm.mapH) { j0 = _tm.mapH - 1; }
			if (j1 >= _tm.mapH) { j1 = _tm.mapH - 1; }
			
			for (i = i0; i != i1; i+=ii)
			{
				for (j = j0; j != j1; j+=ji)
				{
					
					if (_tm.data[j][i] >= _tm.colIndex)
					{
						f = solveTile(i * _tm.tileW, j * _tm.tileH, _tm.tileW, _tm.tileH, limits);
						if (f.time != -1)
						times.push(f);
					}
				}
			}
			
			if (times.length == 0)
			{
				resting = bHit;
				velX = originalVel.x;
				velY = originalVel.y;
				return;
			}
			
			maxf = times[times.length - 1];
			i = times.length;
			while (i--)
			{
				if (times[i].time > maxf.time)
				maxf = times[i];
			}
			
			x -= velX * maxf.time;
			y -= velY * maxf.time;
			
			if (maxf.side == 0)
			{
				velX = originalVel.x = 0;
			}
			else
			{
				if (velY > 0) { bHit = true; }
				velY = originalVel.y = 0;
			}
			
			resting = bHit;
			velX = originalVel.x;
			velY = originalVel.y;
			
			return;
		}
		
		public function solveTile(tx:int, ty:int, tileW:int, tileH:int,limits:Rectangle):CollisionData
		{
			if (!velX && !velY)
			return new CollisionData(-1);
			
			var colx:Boolean, coly:Boolean;
			var minx:Number,maxx:Number;
			minx = limits.x;
			maxx = limits.x+limits.width;
			var disX:Number = Math.max(Math.abs(tx - maxx), Math.abs(tx + tileW - minx));
			if (disX < maxx - minx + tileW)
			colx = true;
			var miny:Number, maxy:Number;
			miny = limits.y;
			maxy = limits.y+limits.height;
			var disY:Number = Math.max(Math.abs(ty - maxy), Math.abs(ty + tileH - miny));
			if (disY < maxy - miny + tileH)
			coly = true;
			
			if (colx && coly)
			{
				var depthx:Number = maxx - tx;
				if (velX < 0)
				depthx = minx - tx - tileW;
				var depthy:Number = maxy - ty;
				if (velY < 0)
				depthy = miny - ty - tileH;;
				
				var xtime:Number = Math.abs(depthx / velX);
				var ytime:Number = Math.abs(depthy / velY);
				
				var coltime:Number = Math.min(xtime, ytime);
				
				return new CollisionData(coltime,xtime<=ytime?0:1);
			}
			return new CollisionData(-1);
		}
	
		public function hitTile(tx:int, ty:int, tileSize:int):Boolean
		{
			return currentBB.intersects( new Rectangle(tx * tileSize, ty * tileSize, width, height))
		}
		
	}

}