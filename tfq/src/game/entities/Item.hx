package game.entities;
import flash.geom.Point;
import game.entities.Character;
import modules.TilemapModule;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.tile.TileEntity;
import tFramework.tile.Tilemap;

/**
 * ...
 * @author qwerber
 */

class Item extends TileEntity
{
	private var mod:TilemapModule;
	public var holder:Character;
	public var remove:Bool;
	public var collectable:Bool;
	
	public var image:PixMap;
	
	public function new(mod:TilemapModule, width:Int, height:Int, x:Float = 0, y:Float = 0) 
	{
		super(width, height, x, y);
		this.mod = mod;
		this.holder = null;
		collectable = Math.random() > 0.5?true:false;
	}
	
	override public function render(map:PixMap, context:RenderContext):Void 
	{
		super.render(map, context);
		image.render(map, context);
	}
	
	public override function update():Void
	{
		velY += Global.GRAVITY;
		velY *= Global.YFRICTION;
		velX *= 0.95;
		if (holder == null) { solveMap(mod.map); }
		else
		{
			x = holder.x;
			y = holder.y;
		}
	}
	
	public function grab(holder:Character):Void
	{
		if (this.holder == null)
		{
			this.holder = holder;
			holder.item = this;
		}
	}
	
	public function drop():Void
	{
		if (holder != null)
		{
			holder.item = null;
			holder = null;
		}
	}
	
}