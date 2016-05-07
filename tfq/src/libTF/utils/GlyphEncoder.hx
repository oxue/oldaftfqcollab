package libTF.utils;
import flash.geom.Point;
import flash.utils.TypedDictionary;
import flash.display.BitmapData;
import flash.Vector;
import tFramework.render.PixMap;

class GlyphEncoder 
{

	private static var glyphs:TypedDictionary<String,Array<PixMap>>;
	
	public static function setup(d1:UInt = 8280678, d2:UInt = 1717206528):Void
	{
		glyphs = new TypedDictionary<String,Array<PixMap>>(false);
		bindGlyph("`", d1, d2);
		glyphs.set("default", glyphs.get("`"));
		glyphs.delete("`");
	}
	
	public static function bindGlyph(char:String, i1:UInt, i2:UInt):Void
	{
		glyphs.set(char.charAt(0), new Array<PixMap>());
		var v:Array<PixMap> = glyphs.get(char.charAt(0));
		v[0x000000] = new PixMap(8, 8, true, 0x00000000);
		var g:PixMap = v[0x000000];
		
		var i:Int = 31;
		while (i1 != 0)
		{
			if (i1 % 2 == 1) { g.setPixel32(i % 8, Std.int(i / 8), 0xFF000000); }
			else { g.setPixel32(i % 8, Std.int(i / 8), 0x00000000); }
			i1 = i1 >> 1;
			i--;
		}
		i = 31;
		while (i2 != 0)
		{
			if (i2 % 2 == 1) { g.setPixel32(i % 8, Std.int(i / 8) + 4, 0xFF000000); }
			else { g.setPixel32(i % 8, Std.int(i / 8) + 4, 0x00000000); }
			i2 = i2 >> 1;
			i--;
		}
	}
	
	inline public static function getBindings(BMD:BitmapData):Array<UInt>
	{
		var v1:UInt = 0;
		var v2:UInt = 0;
		var i:Int = 0;
		while (i < 32)
		{
			if (BMD.getPixel(i % 8, Std.int(i / 8)) == 0x000000) { v1 += (1 << (31 - i)); }
			i++;
		}
		i = 0;
		while (i < 32)
		{
			if (BMD.getPixel(i % 8, Std.int(i / 8) + 4) == 0x000000) { v2 += (1 << (31 - i)); }
			i++;
		}
		
		return [v1, v2];
	}
	
	public static function getChar(char:String, color:UInt = 0x000000):PixMap
	{
		var v:Array<PixMap> = glyphs.get(char.charAt(0));
		if (v == null) { v = glyphs.get("default"); char = "default"; }
		var p:PixMap;
		if (Std.int(color) > v.length || v[color] == null) { p = cacheColor(char, color); }
		else { p = v[color]; }
		return p;
	}
	
	private static function cacheColor(char:String, color:UInt):PixMap
	{
		var v:Array<PixMap> = glyphs.get(char);
		v[color] = new PixMap(8, 8, true, 0x00000000);
		var cv:Vector<UInt> = v[0x000000].getVector(v[0x000000].rect);
		var i:UInt = 0;
		
		while (i < cv.length)
		{
			cv[i] = (cv[i] != 0)?color:0x00000000;
			i++;
		}
		v[color].setVector(v[0x000000].rect, cv);
		
		return v[color];
	}
	
	public static function getString(str:String, color:UInt = 0x000000):PixMap
	{
		var strBM:PixMap = new PixMap(8 * str.length, 8, true, 0x00000000);
		var i:Int = 0;
		var tempBM:PixMap;
		var tempPt:Point = new Point(0, 0);
		while (i < str.length)
		{
			tempBM = getChar(str.charAt(i), color);
			tempPt.x = 8 * i;
			strBM.copyPixels(tempBM, tempBM.rect, tempPt);
			i++;
		}
		
		return strBM;
	}
	
	public static function blitString(str:String, BMD:PixMap, offset:Point, color:UInt):Void
	{
		offset = offset.clone();
		var i:Int = 0;
		var tempBM:PixMap;
		while (i < str.length)
		{
			tempBM = getChar(str.charAt(i), color);
			BMD.copyPixels(tempBM, tempBM.rect, offset);
			offset.x += 8;
			i++;
		}
	}
	
	inline public static function registerAll():Void
	{
		registerLower();
		registerCaps();
		registerNumbers();
		registerPunctuation();
	}
	
	inline public static function registerLower():Void
	{
		bindGlyph("a", 0, 405021722);
		bindGlyph("b", 2105376, 941892664);
		bindGlyph("c", 24, 606086168);
		bindGlyph("d", 263172, 472130588);
		bindGlyph("e", 24, 607920152);
		bindGlyph("f", 1582112, 2015371296);
		bindGlyph("g", 7204, 605815836);
		bindGlyph("h", 2105376, 941892644);
		bindGlyph("i", 2048, 134744072);
		bindGlyph("j", 2048, 134752280);
		bindGlyph("k", 2105380, 607659044);
		bindGlyph("l", 526344, 134744072);
		bindGlyph("m", 0, 1416251978);
		bindGlyph("n", 0, 674505764);
		bindGlyph("o", 0, 405021720);
		bindGlyph("p", 6180, 607658016);
		bindGlyph("q", 6180, 605815812);
		bindGlyph("r", 8248, 606085152);
		bindGlyph("s", 6180, 268968984);
		bindGlyph("t", 2076, 134744072);
		bindGlyph("u", 36, 606348312);
		bindGlyph("v", 34, 571741192);
		bindGlyph("w", 68, 1414812712);
		bindGlyph("x", 34, 336073762);
		bindGlyph("y", 9252, 403181600);
		bindGlyph("z", 15364, 135274556);
	}
	
	inline public static function registerCaps():Void
	{
		bindGlyph("A", 405029442, 2118271554);
		bindGlyph("B", 2084717180, 1111638652);
		bindGlyph("C", 1010975296, 1078084156);
		bindGlyph("D", 2017739330, 1111639160);
		bindGlyph("E", 2118140030, 1077952638);
		bindGlyph("F", 2118140028, 1077952576);
		bindGlyph("G", 1010975296, 1078870588);
		bindGlyph("H", 1111638594, 2118271554);
		bindGlyph("I", 2114455560, 134744190);
		bindGlyph("J", 2114455560, 134760568);
		bindGlyph("K", 1111639112, 1883784258);
		bindGlyph("L", 1077952576, 1077952638);
		bindGlyph("M", 1114004034, 1111638594);
		bindGlyph("N", 1113739858, 1246381634);
		bindGlyph("O", 1010975298, 1111638588);
		bindGlyph("P", 2084717122, 2084585536);
		bindGlyph("Q", 1010975298, 1112163902);
		bindGlyph("R", 2084717122, 2084848194);
		bindGlyph("S", 1010974780, 33702460);
		bindGlyph("T", 2114455560, 134744072);
		bindGlyph("U", 1111638594, 1111638588);
		bindGlyph("V", 1111638594, 1109664792);
		bindGlyph("W", 1111638594, 1113220674);
		bindGlyph("X", 1111630872, 405029442);
		bindGlyph("Y", 1111630872, 134744072);
		bindGlyph("Z", 2114061320, 270549118);
	}
	
	inline public static function registerNumbers():Void
	{
		bindGlyph("1", 135792648, 134744092);
		bindGlyph("2", 943981576, 270549116);
		bindGlyph("3", 1010958850, 469910076);
		bindGlyph("4", 67900452, 2114192388);
		bindGlyph("5", 2084585528, 67388472);
		bindGlyph("6", 471875708, 1111638588);
		bindGlyph("7", 1040319496, 135270416);
		bindGlyph("8", 1010975292, 1111638588);
		bindGlyph("9", 1010975298, 1040319544);
		bindGlyph("0", 943998020, 1145324600);
	}
	
	inline public static function registerPunctuation():Void
	{
		bindGlyph(".", 0, 8);
		bindGlyph(",", 0, 263176);
		bindGlyph(":", 2048, 2048);
		bindGlyph(";", 2048, 2056);
		bindGlyph("!", 526344, 134742024);
		bindGlyph("?", 1843746, 67633160);
		bindGlyph(">", 2101256, 67637280);
		bindGlyph("<", 264208, 537921540);
		bindGlyph("/", 33817608, 270540864);
		bindGlyph("\\", 1075847184, 134480898);
		bindGlyph("|", 134744072, 134744072);
		bindGlyph("\"", 657920, 0);
		bindGlyph("'", 526336, 0);
		bindGlyph("[", 403705872, 269488152);
		bindGlyph("]", 403179528, 134744088);
		bindGlyph("*", 1312788, 0);
		bindGlyph("{", 403705872, 537923608);
		bindGlyph("}", 403179528, 67635224);
		bindGlyph("@", 1010981466, 1516126268);
		bindGlyph("#", 606371364, 612246564);
		bindGlyph("$", 1013606460, 707422780);
		bindGlyph("%", 1650721800, 270542406);
		bindGlyph("^", 135537152, 0);
		bindGlyph("&", 943996960, 810173498);
		bindGlyph("+", 2056, 1040713728);
		bindGlyph("-", 0, 1040187392);
		bindGlyph("_", 0, 126);
		bindGlyph("=", 62, 4063232);
		bindGlyph("~", 50, 1275068416);
		bindGlyph("(", 135270416, 269488136);
		bindGlyph(")", 268961800, 134744080);
		bindGlyph(" ", 0, 0);
	}
}