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

class ConveyorTile extends Tile16
{
	
	private var anim:SpriteAnim;
	public var right:Bool;
	
	public function new(right:Bool) 
	{
		super(TileRenderType.CUSTOM, 0x000000, true);
		ID = 11;
		
		this.right = right;
		solid = false;
		
		var animFrames:Vector<Point> = new Vector<Point>();
		
		if (right)
		{
			animFrames.push(new Point(6, 11));
			animFrames.push(new Point(7, 11));
			animFrames.push(new Point(8, 11));
		}
		else
		{
			animFrames.push(new Point(8, 12));
			animFrames.push(new Point(7, 12));
			animFrames.push(new Point(6, 12));
		}
		anim = Global.tilesheet.toAnimation(animFrames);
		anim.looping = true;
		anim.tickDelay = 2;
	}
	
	override public function customDraw(BMD:PixMap, x:Int, y:Int):Void 
	{
		super.customDraw(BMD, x, y);
		
		var rContext:RenderContext = new RenderContext(x, y);
		
		anim.render(BMD, rContext);
		anim.tick();
	}
	
	override public function getNew():Tile
	{
		return new OneWayTile(right);
	}
	
}