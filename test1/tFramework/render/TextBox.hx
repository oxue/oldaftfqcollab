package tFramework.render;
import flash.display.BitmapData;
import flash.geom.Point;
import libTF.utils.GlyphEncoder;
import libTF.utils.MathUtils;

class TextBox implements Renderable
{

	public var x:Float;
	public var y:Float;
	
	public var width(default, setWidth):Int;
	public var height(default, setHeight):Int;
	public var text(default, setText):String;
	
	public var trimWhitespace:Bool;
	public var trimIndents:Bool;
	public var wholeWords:Bool;
	
	public var color:UInt;
	
	inline public function setWidth(v:Int):Int
	{
		if (v != width) { clean = false; return width = (v > 0)?v:0; }
		else { return width; }
	}
	
	inline public function setHeight(v:Int):Int
	{
		if (v != height) { clean = false; return height = (v > 0)?v:0; }
		else { return height; }
	}
	
	inline public function setText(v:String):String
	{
		if (v != text) { clean = false; return text = v; }
		else { return text; }
	}
	
	private var cache:PixMap;
	private var clean:Bool;
	
	private var point:Point;
	
	public function new(width:Int = 0, height:Int = 0, trimWhitespace:Bool = true, trimIndents:Bool = true, wholeWords:Bool = true) 
	{
		x = y = 0;
		this.width = width;
		this.height = height;
		this.text = "";
		this.clean = false;
		this.trimWhitespace = trimWhitespace;
		this.trimIndents = trimIndents;
		this.wholeWords = wholeWords;
		this.color = 0xFF000000;
		
		this.point = new Point(0, 0);
	}
	
	public function render(map:PixMap, context:RenderContext):Void
	{
		if (context == null) { context = new RenderContext(); }
		
		if (clean)
		{
			point.x = context.x + x;
			point.y = context.y + y;
			map.copyPixels(cache, cache.rect, point);
		}
		else
		{			
			var i:Int = 0;
			var dist:Int = 0;
			var lines:Int = 1;
			var prev:String = "";
			var post:String = "";
			var wholeFlag:Bool = false;
			while (i < text.length && lines < height)
			{
				if (text.charAt(i) == " " && wholeWords)
				{
					var j:Int = i+1;
					var tempdist:Int = dist+1;
					while (text.charAt(j) != " " && text.charAt(j) != "\n" && text.charAt(j) != "\r" && text.charAt(j) != "\t" && j < text.length)
					{
						tempdist++;
						j++;
					}
					if (tempdist >= width && width != 0)
					{
						wholeFlag = true;
						dist = width;
					}
				}
				if (text.charAt(i) == "\t") 
				{
					if (MathUtils.ceil(dist / 5) * 5 == width) { dist = width; }
					else
					{
						prev = text.substr(0, i);  
						post = text.substr(i + 1, text.length - i);
						if (dist % 5 == 0)
						{
							prev += " ";
							i++;
							dist++;
						}
						while (dist % 5 != 0)
						{
							prev += " ";
							i++;
							dist++;
						}
						i--;
						dist--;
						text = prev + post;
					}
				}
				if (text.charAt(i) == "\n" || text.charAt(i) == "\r") 
				{ 
					prev = text.substr(0, i+1);  
					post = text.substr(i+1, text.length - i);
					post = trim(post,  trimWhitespace, trimIndents);
					text = prev + post;
					dist = 0; 
					lines++; 
				}
				else if (dist == width && width != 0) 
				{ 
					prev = text.substr(0, i);  
					post = text.substr(wholeFlag?(i+1):i, text.length - i);
					post = trim(post, trimWhitespace, trimIndents);
					text = prev + "\n" + post;
					dist = 0;
					lines++;
				}
				dist++;
				i++;
			}
			
			var lines:Array<String> = ~/[\r\n]/g.split(text);
			
			var tWidth:Int = 0;
			if (width == 0)
			{
				i = 0;
				while (i < lines.length)
				{
					if (lines[i].length > tWidth) { tWidth = lines[i].length; }
					i++;
				}
			}
			else { tWidth = width; }
			
			var tHeight:Int = (height == 0)?lines.length:height;
			
			cache = new PixMap(tWidth * 8, tHeight * 9);
			
			i = 0;
			point.x = 0;
			while (i < lines.length && i < tHeight)
			{
				point.y = 9 * i;
				GlyphEncoder.blitString(lines[i], cache, point, color);
				i++;
			}
			
			point.x = context.x + x;
			point.y = context.y + y;
			map.copyPixels(cache, cache.rect, point);
			clean = true;
		}
	}
	
	inline private static function trim(str:String, spaces:Bool = true, tabs:Bool = false):String
	{
		if (!spaces && !tabs) { return str; }
		else
		{
			var i:Int = 0;
			while (i < str.length)
			{
				if ((!spaces || str.charAt(i) != " ") && (!tabs || str.charAt(i) != "\t")) { break; }
				i++;
			}
			return str.substr(i, str.length - i);
		}
	}
	
}