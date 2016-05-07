package tFramework.tile;
import flash.display.BitmapData;
import flash.Vector;
import game.tiles.DirtTile1;
import tFramework.render.PixMap;
import flash.geom.Point;
import flash.geom.Rectangle;
import tFramework.core.units.Unit;
import tFramework.render.RenderContext;
import tFramework.render.Animation;
import tFramework.render.Spritesheet;

/**
 * ...
 * @author truefire]
 */

class Tile
{
	//TODO revise tile class
	public var ID:Int;
	public var renderType:String;
	private var color:UInt;
	private var size:Int;
	private var cache:PixMap;
	public var autocache:Vector<BitmapData>;
	public var autoIndex:Int;
	public var autogroup:Int;
	private var anim:Animation;
	private var point:Point;
	public var solid:Bool;
	
	private static var cachedSheets:Vector<Spritesheet>;
	private static var cachedStarts:Vector<Int>;
	private static var cachedAutos:Vector<Vector<BitmapData>>;
	
	public static function init():Void
	{
		cachedSheets = new Vector<Spritesheet>();
		cachedStarts = new Vector<Int>();
		cachedAutos = new Vector<Vector<BitmapData>>();
	}
	
	private function new(renderType:String, color:UInt, size:Int, solid:Bool)
	{
		this.renderType = renderType;
		this.color = color;
		this.solid = solid;
		this.size = size;
		this.cache = new PixMap(size, size, true, 0x000000);
		this.autocache = new Vector<BitmapData>();
		var i:Int = 16;
		while (i-- != 0)
		{
			autocache.push(cache);
		}
		this.autogroup = 0;
		this.point = new Point(0, 0);
	}
	
	public function draw(BMD:PixMap, x:Int, y:Int):Void
	{
		//trace( color );
		switch renderType
		{
			case TileRenderType.NONE:
			case TileRenderType.SOLID:
				BMD.fillRect(new Rectangle(x, y, size, size), color);
			case TileRenderType.BITMAP:
				point.x = x;
				point.y = y;
				BMD.copyPixels(cache, cache.rect, point);
			case TileRenderType.AUTOTILE:
				point.x = x;
				point.y = y;
				BMD.copyPixels(autocache[autoIndex], cache.rect, point);
			case TileRenderType.ANIM:
				anim.render(BMD, new RenderContext(x,y));
			case TileRenderType.CUSTOM:
				customDraw(BMD, x, y);
			default:
		}
	}
	
	public function setAutocache(sheet:Spritesheet, start:Int):Void
	{
		var i:UInt = 0;
		while (i < cachedSheets.length)
		{
			if (sheet == cachedSheets[i] && start == cachedStarts[i]) { autocache = cachedAutos[i]; return; }
			i++;
		}
		
		i = 0;
		while (i < 16)
		{
			autocache[i] = sheet.getBMDFromInd(start + i);
			i++;
		}
		
		cachedSheets.push(sheet);
		cachedStarts.push(start);
		cachedAutos.push(autocache);
	}
	
	public function update():Void { if (anim != null) {anim.tick();} }
	
	public function collide(CD:CollisionData):Void { }
	
	public function customDraw(BMD:PixMap, x:Int, y:Int):Void { }
	
	public function getNew():Tile { return new Tile(TileRenderType.NONE,0x000000,16, true); }
	
}