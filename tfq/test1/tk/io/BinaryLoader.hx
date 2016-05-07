package tk.io;

import flash.events.Event;
import flash.net.FileReference;

class BinaryLoader 
{
	static public var fr:FileReference;
	static public var data:String;
	static public var mcallback:Void -> Void;

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
		data = fr.data.readUTFBytes(fr.data.length);
		if(mcallback != null)
		{
			mcallback();
		}
	}
}