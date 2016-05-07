package tFramework.tile;

//Most of these imports are unnecessary. I just haven't trimmed my imports down.
//Don't worry about them
import flash.display.JointStyle;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Vector;
import libTF.utils.Float2D;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.core.Manager;
import game.tiles.Tile16;
import modules.TilemapModule;
import tFramework.core.MouseManager;
import tFramework.core.KeyManager;
import flash.ui.Keyboard;
import libTF.utils.MathUtils;

/**
 * ...
 * @author WorldEdit & Truefire
 */

class TileEntity implements Unit
{
	
	//temp var
	public var originalVel:Point;
	
	//position
	public var x:Float;
	public var y:Float;
	
	public function reposition(x:Float, y:Float):Void
	{
		this.x = lastBB.x = currentBB.x = x;
		this.y = lastBB.y = currentBB.y = y;
		this.resting = false;
	}
	
	//size
	public var width:Int;
	public var height:Int;
	
	//velocity
	public var velX:Float;
	public var velY:Float;
	
	//is it on the ground
	public var resting:Bool;
	
	//bounding boxes
	//MAYBE swap to IntRect
	private var lastBB:Rectangle;
	private var currentBB:Rectangle;
	
	//self-explanatory
	public function new(width:Int, height:Int, x:Float = 0, y:Float = 0) 
	{
		this.width = width;
		this.height = height;
		
		this.x = x;
		this.y = y;
		
		resting = false;
		velX = velY = 0;
		
		lastBB = new Rectangle(x, y, width, height);
		currentBB = new Rectangle(x, y, width, height);
	}
	
	public function update():Void{}
	
	public function render(map:PixMap, context:RenderContext):Void{}
	
	//move and update BBs based on velocity
	private function move():Void
	{
		lastBB.x = x;
		lastBB.y = y;
		x += velX;
		y += velY;
		currentBB.x = x;
		currentBB.y = y;
	}
	
	//collides with a tilemap
	public function solveMap(tm:Tilemap):Void
	{	
		//first, we move the entity
		move();
		
		//save velocity, so temporary changes can be reset
		originalVel = new Point(velX, velY);
		
		//union of the current bounding box and previous bounding box
		var limits:Rectangle = currentBB.union(lastBB);
		
		//this is a vector to store the times of collision and find the least
		var times:Vector<CollisionData> = new Vector<CollisionData>();
		
		//declarations for use in loop
		var f:CollisionData;
		var i:Int;
		var j:Int;
		
		//itteration variables (0 = start, 1 = end, i = itteration direction)
		//itterating in a given dierction ensures we get the right collision if two occur at the same time, saving us checks later on
		var i0:Int = (velX < 0) ? (Std.int(limits.x / tm.tileSize) - 1) : (MathUtils.ceil((limits.x + limits.width) / tm.tileSize));
		var i1:Int = (velX >= 0) ? (Std.int(limits.x / tm.tileSize) - 1) : (MathUtils.ceil((limits.x + limits.width) / tm.tileSize));
		var ii:Int = (velX < 0) ? 1 : -1;
		var j0:Int = (velY < 0) ? (Std.int(limits.y / tm.tileSize) - 1) : (MathUtils.ceil((limits.y + limits.height) / tm.tileSize));
		var j1:Int = (velY >= 0) ? (Std.int(limits.y / tm.tileSize) - 1) : (MathUtils.ceil((limits.y + limits.height) / tm.tileSize));
		var ji:Int = (velY < 0) ? 1 : -1;
		
		var t:Tile;
			
		//avoid out-of-bounds errors
		if (i0 < 0) { i0 = 0; }
		if (i1 < 0) { i1 = 0; }
		if (j0 < 0) { j0 = 0; }
		if (j1 < 0) { j1 = 0; }
		if (i0 >= tm.tileRect.width) { i0 = Std.int(tm.tileRect.width) - 1; }
		if (i1 >= tm.tileRect.width) { i1 = Std.int(tm.tileRect.width) - 1; }
		if (j0 >= tm.tileRect.height) { j0 = Std.int(tm.tileRect.height) - 1; }
		if (j1 >= tm.tileRect.height) { j1 = Std.int(tm.tileRect.height) - 1; }
		
		//loop through the tilemap
		i = i0;
		while (i != i1)
		{
			j = j0;
			while (j != j1)
			{
				//if the tile is solid, check for collision
				t = tm.get(i, j);
				if (t.solid)
				{
					f = solveTile(i * tm.tileSize, j * tm.tileSize, tm.tileSize, tm.tileSize, limits);
					
					//time == -1 implies there was no collision
					//if there was, push the collision object returned by solveTile
					if (f.hit) { f.tile = t; times.push(f); }
				}
				j += ji;
			}
			i += ii;
		}
		
		//if there are no collisions, we can return.
		if (times.length == 0)
		{
			//cannot be resting if no collisions
			resting = false;
			velX = originalVel.x;
			velY = originalVel.y;
			return;
		}
		
		//determines whether we hit on the bottom site, which would mean we are at rest
		var bHit:Bool = false;
		
		//loop through the collision datas to find the first collision
		//collision datas have time on [0,1], where 0 is colliding at the full end of your velocity, and 1 is colliding right away
		var maxf:CollisionData = times[times.length - 1];
		i = times.length;
		while (i-- != 0)
		{
			if (times[i].time > maxf.time)
			maxf = times[i];
		}
		
		//move the entity to the point of collision
		x -= velX * maxf.time;
		y -= velY * maxf.time;
		roundPosition();
		
		//we still need to finish our movement in the direction that we did not colide. Set vel accordingly
		if (maxf.side == CollisionData.HORIZONTAL)
		{
			velX = originalVel.x = 0;
			velY *= (maxf.time);
		}
		else
		{
			//if we collide vertically, and are moving downwards, we are now at rest.
			if (velY > 0) { bHit = true; }
			velY = originalVel.y = 0;
			velX *= maxf.time;
		}
		
		maxf.tile.collide(maxf);
		collide(maxf);
		
		//move the character again using the remaining velocity
		move();
		
		//we then follow the same process as we did for the first collosion using our adjusted velocity
		limits = currentBB.union(lastBB);
		
		times = new Vector<CollisionData>();
		
		i0 = (velX < 0) ? (Std.int(limits.x / tm.tileSize) - 1) : (MathUtils.ceil((limits.x + limits.width) / tm.tileSize));
		i1 = (velX >= 0) ? (Std.int(limits.x / tm.tileSize) - 1) : (MathUtils.ceil((limits.x + limits.width) / tm.tileSize));
		ii = (velX < 0) ? 1 : -1;
		j0 = (velY < 0) ? (Std.int(limits.y / tm.tileSize) - 1) : (MathUtils.ceil((limits.y + limits.height) / tm.tileSize));
		j1 = (velY >= 0) ? (Std.int(limits.y / tm.tileSize) - 1) : (MathUtils.ceil((limits.y + limits.height) / tm.tileSize));
		ji = (velY < 0) ? 1 : -1;
			
		if (i0 < 0) { i0 = 0; }
		if (i1 < 0) { i1 = 0; }
		if (j0 < 0) { j0 = 0; }
		if (j1 < 0) { j1 = 0; }
		if (i0 >= tm.tileRect.width) { i0 = Std.int(tm.tileRect.width) - 1; }
		if (i1 >= tm.tileRect.width) { i1 = Std.int(tm.tileRect.width) - 1; }
		if (j0 >= tm.tileRect.height) { j0 = Std.int(tm.tileRect.height) - 1; }
		if (j1 >= tm.tileRect.height) { j1 = Std.int(tm.tileRect.height) - 1; }
		
		i = i0;
		while (i != i1)
		{
			j = j0;
			while (j != j1)
			{
				t = tm.get(i, j);
				if (t.solid)
				{
					f = solveTile(i * tm.tileSize, j * tm.tileSize, tm.tileSize, tm.tileSize, limits);
					if (f.hit) { f.tile = t; times.push(f); }
				}
				j += ji;
			}
			i += ii;
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
		while (i-- != 0)
		{
			if (times[i].time > maxf.time)
			maxf = times[i];
		}
		
		x -= velX * maxf.time;
		y -= velY * maxf.time;
		roundPosition();
		
		if (maxf.side == CollisionData.HORIZONTAL)
		{
			velX = originalVel.x = 0;
		}
		else
		{
			if (velY > 0) { bHit = true; }
			velY = originalVel.y = 0;
		}
		
		maxf.tile.collide(maxf);
		collide(maxf);
		
		resting = bHit;
		
		//reset velocities, fixing all temporary changes made durring this function's execution
		velX = originalVel.x;
		velY = originalVel.y;
		
		return;
	}
	
	private function roundPosition():Void
	{
		x = MathUtils.round(x * 100000) / 100000;
		y = MathUtils.round(y * 100000) / 100000;
	}
	
	public function solveTile(tx:Int, ty:Int, tileW:Int, tileH:Int, limits:Rectangle):CollisionData
	{
		//if we're not moving, we're not colliding
		if (velX == 0 && velY == 0) { return new CollisionData(this, null); }
		
		//bounds-collisions in both directions
		var colx:Bool = false;
		var coly:Bool = false;
		
		//evaluate colx, and the x distance traveled to collision
		var minx:Float;
		var maxx:Float;
		minx = limits.x;
		maxx = limits.x+limits.width;
		var disX:Float = MathUtils.max(MathUtils.abs(tx - maxx), MathUtils.abs(tx + tileW - minx));
		if (disX < maxx - minx + tileW) { colx = true; }
		
		//evaluate coly, and the y distance traveled to collision
		var miny:Float;
		var maxy:Float;
		miny = limits.y;
		maxy = limits.y+limits.height;
		var disY:Float = MathUtils.max(MathUtils.abs(ty - maxy), MathUtils.abs(ty + tileH - miny));
		if (disY < maxy - miny + tileH) { coly = true; }
		
		//rectangles intersect if and only if their bounds intersect in both component directions
		if (colx && coly)
		{
			//the portion of our x velocity used for an x-axis collision
			var depthx:Float = maxx - tx;
			if (velX < 0) { depthx = -minx + tx + tileW; }
			
			//the portion of our y velocity used for a y-axis collision
			var depthy:Float = maxy - ty;
			if (velY < 0) { depthy = -miny + ty + tileH; }
			
			//distance traveled for each collision relative to total velocity (on a [0,1] scale)
			var xtime:Float = MathUtils.abs(depthx / velX);
			var ytime:Float = MathUtils.abs(depthy / velY);
			if (xtime > 1 && ytime > 1) 
			{
				if (xtime > ytime) ytime = 1;
				if (ytime > xtime) xtime = 1;
			}
			
			//the collision time is whichever collision occurs first
			var coltime:Float = MathUtils.min(xtime, ytime);
			
			//return a collision data with the collision time and side
			return new CollisionData(this, null, Std.int(tx/tileW), Std.int(ty/tileH), coltime, (xtime <= ytime)?0:1);
		}
		
		//if no collision, return a collision data with time = -1
		return new CollisionData(this, null);
	}
	
	public function checkCollisionID(ID:Int ,map:Tilemap):CollisionData
	{
		var x1:Int = Std.int(x / map.tileSize);
		var y1:Int = Std.int(y / map.tileSize);
		var x2:Int = MathUtils.ceil((x + width) / map.tileSize) - 1;
		var y2:Int = MathUtils.ceil((y + height) / map.tileSize) - 1;
		
		var i:Int = x1;
		var j:Int;
		while (i <= x2)
		{
			j = y1;
			while (j <= y2)
			{
				if (map.get(i, j).ID == ID) { return new CollisionData(this, map.get(i, j),i*map.tileSize, j*map.tileSize,0); }
				j++;
			}
			i++;
		}
		
		return null;
	}
	
	public function collide(col:CollisionData):Void { }
	
	public function hitTile(tx:Int, ty:Int, tileSize:Int):Bool
	{
		return currentBB.intersects( new Rectangle(tx * tileSize, ty * tileSize, width, height));
	}
	
	public function hitEntity(e:TileEntity):Bool
	{
		return currentBB.intersects(e.currentBB) && currentBB.intersects(e.lastBB);
	}
}