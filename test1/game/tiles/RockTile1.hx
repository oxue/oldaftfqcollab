package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class RockTile1 extends Tile16
{
	
	public function new() 
	{
		super(TileRenderType.AUTOTILE, 0x000000, true);
		ID = 5;
		this.setAutocache(Global.tilesheet, 60);
		autogroup = 2;
	}
	
	override public function getNew():Tile
	{
		return new RockTile1();
	}
	
}