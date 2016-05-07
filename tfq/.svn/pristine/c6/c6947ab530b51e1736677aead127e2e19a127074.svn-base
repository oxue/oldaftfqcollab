package io;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

/**
 * ...
 * @author worldedit
 */

class BinaryLoad 
{
	public static var data:String;
	public static var _callback:Void->Void;
	public static var binLoader:URLLoader;
	
	public static function load(_path:String, __callback:Void->Void):Void
	{
		_callback = __callback;
		binLoader = new URLLoader();
		binLoader.addEventListener(Event.COMPLETE, done);
		binLoader.load(new URLRequest(_path));
	}
	
	static private function done(e:Event):Void 
	{
		data = binLoader.data;
		_callback();
	}
	
}