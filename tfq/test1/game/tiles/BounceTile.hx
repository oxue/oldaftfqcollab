package game.tiles;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Vector3D;
import flash.Vector;
import flash.geom.Point;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.tile.CollisionData;
import tFramework.render.Animation;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class BounceTile extends Tile16
{
	private var bounced:PixMap;
	private var cooldown:Int;
	private var timer:Int;
	
	public function new() 
	{
		super(TileRenderType.CUSTOM, 0x000000, true);
		ID = 8;
		solid = true;
		
		timer = 0;
		cooldown = 10;
		
		cache = Global.tilesheet.getTileBMD(0, 11);
		bounced = Global.tilesheet.getTileBMD(1, 11);
	}
	
	override public function update():Void 
	{
		super.update();
		
		timer--;
	}
	
	override public function customDraw(BMD:PixMap, x:Int, y:Int):Void 
	{
		super.customDraw(BMD, x, y);
		
		var rContext:RenderContext = new RenderContext(x, y);
		
		if (timer <= 0) { BMD.copyPixels(cache, cache.rect, new Point(x, y)); }
		else { BMD.copyPixels(bounced, bounced.rect, new Point(x, y)); }
	}
	
	override public function collide(CD:CollisionData):Void 
	{
		super.collide(CD);
		
		if (CD.side == CollisionData.VERTICAL && CD.entity.y + CD.entity.height <= CD.y * size)
		{
			CD.entity.originalVel.y = - 15;
			CD.entity.resting = false;
			timer = cooldown;
		}
	}
	
	override public function getNew():Tile
	{
		return new BounceTile();
	}
	
}