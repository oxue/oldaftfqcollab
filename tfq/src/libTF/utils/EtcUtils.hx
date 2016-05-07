package libTF.utils;
import flash.Vector;
import haxe.rtti.Generic;

/**
 * ...
 * @author 
 */

class EtcUtils<T> implements haxe.rtti.Generic
{

	private function new() 
	{
		
	}
	
	public static function ArrToVec2D<T>(arr:Array<Array<T>>):Vector<Vector<T>>
	{
		var v:Vector<Vector<T>> = new Vector<Vector<T>>();
		var i:Int = 0;
		while (i < arr.length)
		{
			v[i] = Vector.ofArray(arr[i]);
			i++;
		}
		return(v);
	}
	
}