package io;
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import game.tiles.AirTile;
import hxjson2.JSON;
import io.EntFactory;
import tFramework.tile.Autotiler;
import tFramework.render.Spritesheet;
import tFramework.tile.Tile;
import tFramework.tile.Tilemap;
import flash.events.ErrorEvent;
/**
 * ...
 * @author qwerber
 */

class MapSe 
{
	private var call:Void -> Void;
	private var uloader:URLLoader;
	public var data:Tilemap;
	private var indexes:StandardTileIndexes;

	public static inline var majorVersion:Int = 0;
	public static inline var minorVersion:Int = 2;
	
	private var jobj:Dynamic;
	
	public function new() 
	{
		uloader = new URLLoader();
		indexes = new StandardTileIndexes();
	}
	
	public function start(_url:String, _call:Void -> Void):Void
	{
		uloader.addEventListener(Event.COMPLETE, done);
		uloader.load(new URLRequest(_url));
		call = _call;
	}
	
	private function done(e:Event):Void 
	{
		uloader.removeEventListener(Event.COMPLETE, done);
		jobj = JSON.decode(cast(uloader.data, String));
		data = new Tilemap(jobj.map_width, jobj.map_height, new AirTile(), jobj.tile_size);
		var i:Int = jobj.map_height;
		var n = 0;
		while (i-->0)
		{		
			var j:Int = jobj.map_width;
			while (j-->0)
			{
				if(jobj.data[i][j] != 0)
				data.set(j, i, indexes.indexes[jobj.data[i][j]].getNew());
			}
		}
		Autotiler.autotile(data);
		call();
	}

	public function parsemap(_level:String, _obj:Dynamic = null):Tilemap
	{
		jobj = JSON.decode(_level);
		data = new Tilemap(jobj.map_width, jobj.map_height, new AirTile(), jobj.tile_size);
		var i:Int = jobj.map_height;
		var n = 0;
		while (i-->0)
		{		
			var j:Int = jobj.map_width;
			while (j-->0)
			{
				if(jobj.data[i][j] != 0)
				data.set(j, i, indexes.indexes[jobj.data[i][j]].getNew());
			}
		}
		_obj.data = jobj;
		
		Autotiler.autotile(data);
		return data;
	}
	
}