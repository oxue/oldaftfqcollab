package tk;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.TypedDictionary;

class ToolkitEngine
{
	public static var urlLoader:URLLoader;
	public static var ddata:String;
	public static var settings:TypedDictionary<String,String>;
	public static var mcallback:Void -> Void;

	public static function loadDescriptorFile(_path:String, _callback):Void
	{
		urlLoader = new URLLoader();
		urlLoader.addEventListener(Event.COMPLETE, complete);
		urlLoader.load(new URLRequest(_path));
		mcallback = _callback;
	}

	public static function complete(e:Event):Void
	{
		settings = new TypedDictionary();
		ddata = cast(urlLoader.data,String);
		var i:Int = -1;
		var key:String = '';
		var term:String = '';
		var mode:Int = 0;
		while(i++<ddata.length - 1)
		{
			if(ddata.charAt(i) == "[")
			{
				key = '';
				term = '';
				mode = 0;
			}else if(ddata.charAt(i) == "]")
			{
				settings.set(key,term);
			}else if(ddata.charAt(i) == ":")
			{
				mode = 1;
			}else if(ddata.charAt(i) == " ")
			{
				null;
			}else
			{
				if(mode == 0)
				{
					key += ddata.charAt(i);
				}else if(mode == 1)
				{
					term += ddata.charAt(i);
				}
			}
		}
		mcallback();
	}
}