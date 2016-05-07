package game.entities;
import flash.geom.Point;
import flash.geom.Rectangle;
import modules.TilemapModule;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;

/**
 * ...
 * @author worldedit
 */

class Warp implements Unit
{
	
	public var x:Int;
	public var y:Int;
	public var graphic:PixMap;
	public var mod:TilemapModule;
	public var level:Int;
	
	public function new() 
	{
		graphic = Global.warpimage;
		x = y = 244;
		level = 2;
	}
	
	public function update():Void
	{
		var tx:Int = cast (mod.player.x - this.x);
		var ty:Int = cast(mod.player.y  -this.y);
		if (tx * tx + ty * ty < 250)
		{
			mod.level(this.level);
		}
	}
	
	public function render(map:PixMap, context:RenderContext):Void
	{
		var p:Point = new Point(x + context.x, y + context.y);
		map.copyPixels(graphic, graphic.rect, p, null, null, true);
	}
	
}