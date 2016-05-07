package io;
import flash.Vector;
import game.tiles.AirTile;
import game.tiles.DirtTile1;
import game.tiles.DirtTile2;
import game.tiles.DirtTile3;
import game.tiles.LadderTile;
import game.tiles.LavaTile;
import game.tiles.MetalTile;
import game.tiles.WaterTile;
import tFramework.tile.Tile;

/**
 * ...
 * @author qwerber
 */

class StandardTileIndexes 
{
	public var indexes:Vector<Tile>;
	
	public function new() 
	{
		indexes = new Vector();
		indexes.push(new AirTile());
		indexes.push(new DirtTile1());
		indexes.push(new DirtTile2());
		indexes.push(new DirtTile3());
		indexes.push(new MetalTile());
		
		indexes.push(new WaterTile());
		indexes.push(new LavaTile());
		indexes.push(new LadderTile());
	}
	
}