package tk.io;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;
import flash.net.FileReference;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

class GraphicLoader
{
	static public var fr:FileReference;
	static public var data:BitmapData;
	static public var mcallback:Void -> Void;
	static public var loader:Loader;
	
	static public var bytes:ByteArray;
	
	

	function new()
	{
		
	}

	public static function startLoadSequence(_callback:Void -> Void):Void
	{
		mcallback = _callback;
		fr = new FileReference();
		fr.addEventListener(Event.SELECT, selected);
		fr.browse();
	}

	public static function selected(e:Event):Void
	{
		fr.addEventListener(Event.COMPLETE, complete);
		fr.load();
	}

	public static function complete(e:Event):Void
	{
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, bytesComplete);
		loader.loadBytes(fr.data);
	}

	public static function bytesComplete(e:Event):Void
	{
		data = new BitmapData(Std.int(loader.width), Std.int(loader.height), true, 0x00000000);
		data.copyPixels(cast(loader.content, Bitmap).bitmapData,cast(loader.content, Bitmap).bitmapData.rect,new Point(),null,null,true);
		bytes = fr.data;

		if(mcallback != null)
		{
			mcallback();
		}
	}
}