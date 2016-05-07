package tFramework.logging;
import flash.utils.ByteArray;
import flash.net.FileReference;

class TextLogger 
{

	private static var logTxt:String;
	
	private static var bytes:ByteArray
	
	inline public static function setup():Void
	{
		bytes = new ByteArray();
	}
	
	inline public static function write(s:String):Void
	{
		logTxt += s;
		bytes.writeUTFBytes(s);
	}
	
	inline public static function clear():Void
	{
		logTxt = "";
		bytes = new ByteArray();
	}
	
	inline public static function save():Void
	{
		var file:FileReference = new FileReference();
		file.save(bytes, "log.txt");
	}
}