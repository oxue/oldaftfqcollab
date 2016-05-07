package libTF.utils;
import haxe.macro.Expr;
import haxe.macro.Context;

class Hasher 
{

	@:macro public static function macrohash(length : Expr) {
		switch(length.expr)
		{
			case EConst(c):
				switch (c)
				{
					case CInt(n):
						var hash:String = randhash(Std.parseInt(n));
						var pos = Context.currentPos();
						return { expr : EConst(CString(hash)), pos : pos };
					default:
				}
			default:
		}
		return null;
	}
	
	inline public static function randhash(length:Int):String
	{
		var i:Int = 0;
		var hash:String = "";
		while (i < length)
		{
			hash += randchar();
			i++;
		}
		return hash;
	}
	
	inline public static function randchar():String
	{
		return String.fromCharCode((Std.int(Math.random() * 32767) % 2 == 0) ? (Std.int(Math.random() * 32767) % 26 + 65) : ((Std.int(Math.random() * 32767) % 9 + 48)));
	}
	
}