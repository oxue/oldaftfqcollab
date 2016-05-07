package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class AirTile extends Tile16
{

	private static var singleton:AirTile;
	
	public function new() 
	{
		super(TileRenderType.NONE, 0x000000, false);
		ID = 0;
		autogroup = 0;
	}
	
	override public function getNew():Tile
	{
		if (singleton == null) { return (singleton = new AirTile()); }
		else { return singleton; }
	}
	
}