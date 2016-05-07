package tFramework.core.modules;
import flash.net.drm.DRMVoucherDownloadContext;
import flash.utils.TypedDictionary;
import flash.Vector;
import tFramework.core.controllers.Controller;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.Renderable;
import tFramework.render.RenderContext;

class Module implements Unit
{
	public var x:Float;
	public var y:Float;
	
	private var context:RenderContext;
	
	private var units:Vector<Unit>;
	
	public function new() 
	{
		x = 0;
		y = 0;
		
		context = new RenderContext(x, y);
		
		units = new Vector<Unit>();
	}
	
	public function addUnit(unit:Unit):Void
	{
		units.push(unit);
	}
	
	public function removeUnit(unit:Unit):Void
	{
		units.splice(units.indexOf(unit), 1);
	}
	
	public function update():Void
	{
		var i:Int = 0;
		while (i < Std.int(units.length))
		{
			units[i].update();
			i++;
		}
	}
	
	public function render(map:PixMap, context:RenderContext):Void
	{
		if (context == null) { context = new RenderContext(); }
		
		var i:Int = 0;
		
		context.x = context.x + x;
		context.y = context.y + y;
		
		while (i < Std.int(units.length))
		{
			units[i].render(map, context);
			i++;
		}
	}
	
}