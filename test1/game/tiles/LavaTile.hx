package game.tiles;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Vector3D;
import flash.Vector;
import flash.geom.Point;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.render.Animation;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class LavaTile extends Tile16
{
	
	private var waves:Animation;
	public var top:Bool;
	
	public function new() 
	{
		super(TileRenderType.CUSTOM, 0x000000, true);
		ID = 17;
		
		top = false;
		solid = false;
		
		var animFrames:Vector<Point> = new Vector<Point>();
		animFrames.push(new Point(0, 9));
		animFrames.push(new Point(1, 9));
		animFrames.push(new Point(2, 9));
		animFrames.push(new Point(3, 9));
		waves = Global.tilesheet.toAnimation(animFrames);
		waves.options.looping = true;
		waves.options.tickDelay = 2;
		
		cache = Global.tilesheet.getTileBMD(4, 9);
	}
	
	override public function customDraw(BMD:PixMap, x:Int, y:Int):Void 
	{
		super.customDraw(BMD, x, y);
		
		var rContext:RenderContext = new RenderContext(x, y);
		
		if (top) { waves.render(BMD, rContext); waves.tick(); }
		else { BMD.copyPixels(cache, cache.rect, new Point(x, y)); }
	}
	
	override public function getNew():Tile
	{
		return new LavaTile();
	}
	
}