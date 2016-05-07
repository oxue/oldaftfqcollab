package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class GrassTile extends Tile16
{
	
	public function new() 
	{
		super(TileRenderType.BITMAP, 0x000000, true);
		ID = 8;
		this.cache = Global.tilesheet.getTileBMD(1, 12);
		autogroup = 1;
		solid = false;
	}
	
	override public function getNew():Tile
	{
		return new GrassTile();
	}
	
}