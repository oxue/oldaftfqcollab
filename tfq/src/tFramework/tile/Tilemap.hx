package tFramework.tile;
import flash.Vector;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import libTF.dataStructures.Vector2D;
import libTF.utils.IntRect;
import tFramework.render.PixMap;

class Tilemap extends Vector2D<Tile>
{
	
	//TODO caching
	
	/*public var bitmap:PixMap;*/
	public var tileSize:Int;
	public var tileRect:IntRect;
	
	public function new(width:Int, height:Int, defaultVal:Tile, tileSize:Int) 
	{
		super(width, height, defaultVal, false);
		this.tileSize = tileSize;
		/*bitmap = new PixMap(width * tileSize, height * tileSize, false);*/
		tileRect = new IntRect(0, 0, width, height);
		var i:Int = 0;
		while (i < Std.int(data.length))
		{
			data[i] = defaultVal.getNew();
			i++;
		}
	}
	
	inline public function update(rect:IntRect = null):Void
	{
		if (rect == null) { rect = new IntRect(0, 0, width, height); }
		else { rect = rect.intersection(tileRect); }
		
		var i:Int;
		var j:Int;
		var ind:Int;
		
		i = Std.int(rect.x);
		while (i < rect.width + rect.x)
		{
			j = Std.int(rect.y);
			while (j < rect.height + rect.y)
			{
				get(i, j).update();
				j++;
			}
			i++;
		}
	}
	
	inline public function pToTilespace(p:Point):Point
	{
		return new Point(Std.int(p.x / tileSize), Std.int(p.y / tileSize));
	}
	
	inline public function rToTilespace(r:IntRect):IntRect
	{
		return new IntRect(Std.int(r.x / tileSize), Std.int(r.y / tileSize), Std.int(r.height / tileSize) + 1, Std.int(r.width / tileSize) + 1);
	}
	
	inline public function blitDirect(BMD:PixMap, destX:Int = 0, destY:Int = 0, rect:IntRect = null):Void
	{
		if (rect == null) { rect = new IntRect(0, 0, width, height); }
		else { rect = rect.intersection(tileRect); }
		
		var i:Int;
		var j:Int;
		var ind:Int;
		
		BMD.lock();
		i = Std.int(rect.x);
		while (i < rect.width + rect.x)
		{
			j = Std.int(rect.y);
			while (j < rect.height + rect.y)
			{
				get(i, j).draw(BMD, Std.int(i-rect.x) * tileSize + destX, Std.int(j-rect.y) * tileSize + destY);
				j++;
			}
			i++;
		}
		BMD.unlock();
	}
	
}