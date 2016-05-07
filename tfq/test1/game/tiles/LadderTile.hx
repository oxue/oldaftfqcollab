package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class LadderTile extends Tile16
{
	
	public function new() 
	{
		super(TileRenderType.BITMAP, 0x000000, true);
		ID = 9;
		this.cache = Global.tilesheet.getTileBMD(0, 12);
		autogroup = 0;
		solid = false;
	}
	
	override public function getNew():Tile
	{
		return new LadderTile();
	}
	
}