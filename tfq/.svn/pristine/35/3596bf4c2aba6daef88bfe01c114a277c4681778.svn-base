package game.entities;

import libTF.utils.IntPoint;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.tile.Tilemap;

class Portal implements Unit
{
	public var graphics:PixMap;
	public static inline var colors = [0xff0000ff,0xffff0000];
	public var x:Int;
	public var y:Int;
	public var target:Tilemap;
	public var targetPortal:Portal;

	public function new(_tmap:Tilemap, _hit:IntPoint, _facing:Int = 0, _type = 0)
	{
		if(_facing%2!=1)
		{
			graphics = new PixMap(2,32);
		}else
		{
			graphics = new PixMap(32,2);
		}
		target = _tmap;
		graphics.fillRect(graphics.rect,colors[_type]);
		if(_facing == 0)
		{
			x = _hit.x * 16;
			y = _hit.y * 16 - 16;
			var t = target.get(_hit.x - 1, _hit.y - 1);
			t.solid = false;
			target.set(_hit.x - 1, _hit.y - 1, t);
			t = target.get(_hit.x - 1, _hit.y);
			t.solid = false;
			target.set(_hit.x - 1, _hit.y,t);
		}else if(_facing == 1)
		{
			x = _hit.x * 16 - 16;
			y = _hit.y * 16;
		}else if(_facing == 2)
		{
			x = _hit.x * 16 - 2;
			y = _hit.y * 16 - 16;
		}else if(_facing == 3)
		{
			x = _hit.x * 16 - 16;
			y = _hit.y * 16 - 2;
		}
	}

	public function update():Void
	{

	}

	public function render(map:PixMap, context:RenderContext):Void
	{
		context.x += x;
		context.y += y;
		graphics.render(map,context);
	}
}