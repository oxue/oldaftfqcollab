package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class DirtTile2 extends Tile16
{

	public function new() 
	{
		super(TileRenderType.AUTOTILE, 0x000000, true);
		ID = 2;
		this.setAutocache(Global.tilesheet, 00);
		autogroup = 1;
	}
	
	override public function getNew():Tile
	{
		return new DirtTile2();
	}
	
}