package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class MetalTile extends Tile16
{
	
	public function new() 
	{
		super(TileRenderType.AUTOTILE, 0x000000, true);
		ID = 3;
		this.setAutocache(Global.tilesheet, 100);
		autogroup = 3;
	}
	
	override public function getNew():Tile
	{
		return new MetalTile();
	}
	
}