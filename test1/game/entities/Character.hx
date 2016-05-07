package game.entities;
import flash.geom.Point;
import flash.Vector;
import modules.TilemapModule;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.render.Spritesheet;
import tFramework.render.Animation;
import tFramework.tile.TileEntity;
import tFramework.tile.Tilemap;
import tFramework.render.Pixie;
import tFramework.render.Sprodel;

/**
 * ...
 * @author TF
 */

class Character extends TileEntity
{
	//TODO possibly a "quick getter" for animation options
	public var model:Sprodel;
	//TODO rebuild item system somehow
	public var item:Item;
	public var dead:Bool;
	private var mod:TilemapModule;
	public var state(getState, setState):String;
	
	public var flippedh:Bool;
	public var flippedv:Bool;
	
	
	inline public function getState():String
	{
		return model.stateName;
	}
	
	inline public function setState(state:String):String
	{
		model.setState(state);
		return state;
	}
	
	public function new(model:Sprodel, mod:TilemapModule, width:Int, height:Int) 
	{
		super(width, height);
		this.model = model;
		this.mod = mod;
		
		flippedh = flippedv = false;
	}
	
	override public function update():Void
	{
		model.tick();
	}
	
	override public function render(map:PixMap, context:RenderContext):Void
	{
		if (context == null) { context = new RenderContext(); }
		else { context = context.clone(); }
		
		context.x += x;
		context.y += y;
		
		context.fliph = (context.fliph != flippedh);
		context.flipv = (context.flipv != flippedv);
		
		model.render(map, context);
	}
	
}