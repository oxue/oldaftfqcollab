package game.tiles;
import tFramework.tile.Tile;
import tFramework.tile.TileRenderType;

/**
 * ...
 * @author TF
 */

class SignTile extends Tile16
{
	private var ind:Int;
	
	public function new(type:Int) 
	{
		super(TileRenderType.BITMAP, 0x000000, true);
		ID = 8;
		this.ind = type;
		this.cache = Global.tilesheet.getBMDFromInd(ind);
		autogroup = 0;
		solid = false;
	}
	
	override public function getNew():Tile
	{
		return new SignTile(ind);
	}
	
}