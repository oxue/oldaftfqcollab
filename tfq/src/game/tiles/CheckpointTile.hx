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

class CheckpointTile extends Tile16
{
	public var on:Bool;
	
	public function new() 
	{
		super(TileRenderType.ANIM, 0x000000, true);
		ID = 51;
		solid = false;
		
		on = false;
		
		var v:Vector<Point> = new Vector<Point>();
		v.push(new Point(13, 9));
		v.push(new Point(14, 9));
		v.push(new Point(15, 9));
		v.push(new Point(16, 9));
		v.push(new Point(17, 9));
		
		anim = Global.tilesheet.toAnimation(v);
		anim.options.paused = true;
	}
	
	override public function update():Void 
	{
		anim.tick();
		if (on && anim.currentFrame != 4) { anim.options.frameskip = 1; anim.options.paused = false; }
		else if (!on && anim.currentFrame != 0) { anim.options.frameskip = -1; anim.options.paused = false; }
		else { anim.options.paused = true; }
	}
	
	override public function getNew():Tile
	{
		return new CheckpointTile();
	}
	
}