package game.terrainGeneration;
import tFramework.tile.Tile;

/**
 * ...
 * @author qwerber
 */

class TerrainGenSettings 
{
	
	public var tileSize:Int;
	public var mapWidth:Int;
	public var mapHeight:Int;
	public var seaLevel:Int;
	public var maxFluc:Int;
	public var minFluc:Int;	
	public var roughness:Int;
	public var water:Bool;
	public var slope:Float;
	
	public var airTile:Tile;
	public var waterTile:Tile;
	public var stoneTile:Tile;
	
	public function new():Void
	{
		
	}
	
}