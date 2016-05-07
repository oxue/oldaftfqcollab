package tFramework.render;

/**
 * ...
 * @author TF
 */

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.Vector;
import flash.Vector;
import flash.Vector;
import flash.Vector;
import libTF.utils.IntRect;
import tFramework.render.Pixie;
import tFramework.render.PixMap;
import libTF.utils.BitmapUtils;
	
class Spritesheet 
{
	//TODO change to IntPoints
	public var sprite:PixMap;
	private var border:Int;
	private var edge:Int;
	private var tPoint:Point;
	private var tRect:Rectangle;
	public var tileWidth:Int;
	public var tileHeight:Int;
	public var width:Int;
	public var height:Int;
	
	//img is the spritesheed to be used
	//width and height are the width and height of a single tile
	//tBorder is the spacing between tiles (if any) in pixels
	//tEdge is the size of the border around the grid (if any) in pixels
	public function new(img:PixMap, width:Int, height:Int, tBorder:Int = 0, tEdge:Int = 0) 
	{		
		sprite = img;
		
		tileWidth = width;
		tileHeight = height;
		
		border = tBorder;
		edge = tEdge;
		this.width = Std.int((sprite.width - 2 * edge + 1) / (tileWidth + border));
		this.height = Std.int((sprite.height - 2 * edge + 1) / (tileHeight + border));
		
		tPoint = new Point(0, 0);
		tRect = new Rectangle(0, 0, tileWidth, tileHeight);
	}
	
	//will return a ByteArray corresponding to the tile at (x,y) on the grid
	public function getTileBA(x:Int, y:Int):ByteArray
	{
		tRect.x = edge + (border + tileWidth) * x;
		tRect.y = edge + (border + tileHeight) * y;
		
		return sprite.getPixels(tRect);
	}
	
	//will return a Vector corresponding to the tile at (x,y) on the grid
	public function getTileVector(x:Int, y:Int):Vector<UInt>
	{
		tRect.x = edge + (border + tileWidth) * x;
		tRect.y = edge + (border + tileHeight) * y;
		
		return sprite.getVector(tRect);
	}
	
	//will return a BitmapData corresponding to the tile at (x,y) on the grid
	public function getTileBMD(x:Int, y:Int):PixMap
	{
		var BMD:PixMap = new PixMap(tileWidth, tileHeight);
		
		tPoint.x = 0;
		tPoint.y = 0;
		BMD.copyPixels(sprite, getTileRect(x, y), tPoint);
		
		return BMD;
	}
	
	public function getPixie(x:Int, y:Int, trimming:Bool = true):Pixie
	{
		if (trimming) { return BitmapUtils.trimBitmap(sprite, new IntRect(edge + (border + tileWidth) * x, edge + (border + tileHeight) * y, tileWidth, tileHeight)); }
		else { return new Pixie(sprite, new IntRect(edge + (border + tileWidth) * x, edge + (border + tileHeight) * y, tileWidth, tileHeight)); }
	}
	
	public function getBMDFromInd(i:Int):PixMap
	{
		return getTileBMD(i % width, Std.int(i / width));
	}
	
	//gives the rectangle of a tile on the spritesheet in pixel-coordinates
	public function getTileRect(x:Int, y:Int):Rectangle
	{
		return new Rectangle(edge + (border + tileWidth) * x, edge + (border + tileHeight) * y, tileWidth, tileHeight);
	}
	
	public function getTileIRect(x:Int, y:Int):IntRect
	{
		return new IntRect(edge + (border + tileWidth) * x, edge + (border + tileHeight) * y, tileWidth, tileHeight);
	}
	
	//draws the tile at x,y on the grid to the BitmapData BMD
	//the upper left corner of the drawn tile will be at (x2,y2) on the BMD
	public function drawToBMD(x:Int, y:Int, x2:Int, y2:Int, BMD:BitmapData):Void
	{
		tPoint.x = x2;
		tPoint.y = y2;
		BMD.copyPixels(sprite, getTileRect(x, y), tPoint);
	}
	
	public function toAnimation(frames:Vector<Point>, trimming:Bool = true, options:AnimationOptions = null):Animation
	{
		var i:UInt = 0;
		var v:Vector<Renderable> = new Vector<Renderable>(frames.length);
		while (i < frames.length)
		{
			v[i] = getPixie(Std.int(frames[i].x), Std.int(frames[i].y), trimming);
			i++;
		}
		
		return new Animation(v, options);
	}
	
	public function toSprodel(states:Vector<Vector<Point>>, names:Vector<String>, trimming:Bool = true, options:Vector<AnimationOptions> = null):Sprodel
	{
		var i:UInt = 0;
		var s:Sprodel = new Sprodel();
		while (i < states.length && i < names.length)
		{
			if (options != null && i < options.length)
			{
				s.addState(toAnimation(states[i], trimming, options[i]), names[i]);
			}
			else
			{
				s.addState(toAnimation(states[i], trimming), names[i]);
			}
			i++;
		}
		
		return s;
	}
}