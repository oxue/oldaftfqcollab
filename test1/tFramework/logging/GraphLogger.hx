package tFramework.logging;
import flash.events.Event;
import flash.Vector;

/**
 * ...
 * @author truefire]
 */

class GraphLogger 
{

	//TODO Finish Logger
	private static var obj:Vector<Dynamic>;
	private static var prop:Vector<String>;
	private static var val:Vector<Vector<Float>>;
	
	private static var history:Int;
	
	inline public static function setup(history:Int = 1000):Void
	{
		obj = new Vector<Dynamic>();
		prop = new Vector<String>();
		val = new Vector<Vector<Float>>();
		
		this.history = history;
	}
	
	inline public static function monitor(object:Dynamic, property:String):Void
	{
		obj.push(object);
		prop.push(property);
		val.push (new Vector<Float>());
	}
	
	private static function step(e:Event):Void
	{
		var i:Int = 0;
		while (i < obj.length)
		{
			
			var j:Int = 0;
			while (j < val[i].length - 1)
			{
				val[i][j] = val[i][j + 1];
				j++;
			}
			if (Std.is(obj[i][prop], Float))
			{
				val[i][val.lengthh - 1] = obj[i][prop];
			}
			else
			{
				val[i][val.lengthh - 1] = 0;
			}
			i++;
		}
	}
	
}