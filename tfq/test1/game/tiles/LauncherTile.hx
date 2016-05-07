package game.tiles;
import tFramework.render.RenderContext;
import tFramework.tile.Tile;
import tFramework.tile.TileEntity;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class LauncherTile extends Tile16
{
	
	public var dir:Int; //RDLU = 0123
	public var dom:Bool;
	public var cap:Bool;
	public var force:Float;
	
	public function new(dir:Int, force:Float = 20, dom:Bool = false, cap:Bool = true ) 
	{
		super(TileRenderType.BITMAP, 0x000000, true);
		ID = 11;
		this.cache = Global.tilesheet.getTileBMD(5, 14);
		this.dir = dir;
		this.force = force;
		this.dom = dom;
		this.cap = cap;
		switch (this.dir)
		{
			case 1: cache.clonePM().render(cache, new RenderContext(8,8,Math.PI*3/2,8,8));
			case 2: cache.clonePM().render(cache, new RenderContext(8, 8, Math.PI, 8, 8));
			case 3: cache.clonePM().render(cache, new RenderContext(8,8,Math.PI/2,8,8));
		}
		
		autogroup = 0;
		solid = false;
	}
	
	public function launch(e:TileEntity):Void
	{
		switch(dir)
		{
			case 0:
				if (dom) { e.velX = force; e.velY = 0; }
				else
				{
					if (cap) { e.velX = (e.velX > force)?e.velX:force; }
					else { e.velX += force; }
				}
			case 1:
				if (dom) { e.velY = force; e.velX = 0; }
				else
				{
					if (cap) { e.velY = (e.velY > force)?e.velY:force; }
					else { e.velY += force; }
				}
			case 2:
				if (dom) { e.velX = -force; e.velY = 0; }
				else
				{
					if (cap) { e.velX = (e.velX < -force)?e.velX:-force; }
					else { e.velX -= force; }
				}
			case 3:
				if (dom) { e.velY = -force; e.velX = 0; }
				else
				{
					if (cap) { e.velY = (e.velY < -force)?e.velY:-force; }
					else { e.velY -= force; }
				}
		}
	}
	
	override public function getNew():Tile
	{
		return new LauncherTile(dir, force, dom, cap);
	}
	
}