package game.entities;
import flash.geom.Point;
import flash.Vector;
import modules.TilemapModule;
import tFramework.render.Pixie;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.render.Spritesheet;
import tFramework.render.Animation;
import tFramework.tile.TileEntity;
import tFramework.tile.Tilemap;

/**
 * ...
 * @author TF
 */

class Projectile extends TileEntity
{
	//TODO Pixies
	//TODO revise class
	private var anim:Animation;
	private var mod:TilemapModule;
	
	public var flippedh:Bool;
	public var flippedv:Bool;
	
	public function new(anim:Animation, mod:TilemapModule, width:Int, height:Int) 
	{
		var p:Pixie = cast(anim.frames[0], Pixie);
		super(p.clipping.width, p.clipping.height);
		this.anim = anim;
		this.mod = mod;
		
		flippedh = false;
		flippedv = false;
	}
	
	override public function update():Void
	{
		solveMap(mod.map);
		anim.tick();
	}
	
	override public function render(map:PixMap, context:RenderContext):Void
	{
		if (context == null) { context = new RenderContext(); }
		else { context = context.clone(); }
		
		context.x += x;
		context.y += y;
		context.fliph = (context.fliph != flippedh);
		context.flipv = (context.flipv != flippedv);
		
		anim.render(map, context);
	}
	
}