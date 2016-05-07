package game.tiles;
import tFramework.tile.Tile;

/**
 * ...
 * @author TF
 */

class Tile16 extends Tile
{
	
	public function new(renderType:String, color:UInt, solid:Bool) 
	{
		super(renderType, color, 16, solid);
		ID = 6000;
	}
	
}