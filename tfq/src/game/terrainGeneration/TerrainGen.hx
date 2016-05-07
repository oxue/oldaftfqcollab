package game.terrainGeneration;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.Lib;
import flash.Vector;
import game.tiles.DirtTile1;
import game.tiles.DirtTile2;
import tFramework.tile.Autotiler;
import tFramework.tile.Tilemap;

/**
 * ...
 * @author TF
 */

class TerrainGen 
{

	public function new()
	{
		
	}
	
	public static function generateNewTerrainBlock(_settings:TerrainGenSettings):Tilemap
	{
		var ret:Tilemap = new Tilemap(_settings.mapWidth, _settings.mapHeight, _settings.airTile, _settings.tileSize);
		
		var noise:BitmapData = new BitmapData(ret.width, 1);
		noise.perlinNoise(ret.width, 5, cast ret.width / 60, 8, true, true, 7);
		
		var t:DirtTile1 = new DirtTile1();
		
		var heightData:Vector<Int> = new Vector<Int>(ret.width, true);
		
		var j:Int = 0;
		var i:Int = 0;
		var k:Int = 0;
		
		j = ret.width;
		while (j-->0)
		{
			heightData[j] = Std.int((noise.getPixel(j, 0) / 0xffffff) * (_settings.maxFluc - _settings.minFluc)) + _settings.minFluc;
		}
		
		j = ret.width;
		while (j-->0)
		{
			i = heightData[j];
			k = ret.height;
			while (i-->0)
			{
				k--;
				ret.set(j, k, t.getNew());
			}
		}
		
		Autotiler.autotile(ret);
		
		return ret;
	}
	
}