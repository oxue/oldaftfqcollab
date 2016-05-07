package tFramework.tile;

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
import tFramework.render.PixMap;
	
class Spritesheet 
{
	public var sprite:BitmapData;
	private var border:Int;
	private var edge:Int;
	private var tPoint:Point;
	private var tRect:Rectangle;
	public var tilesW:Int;
	public var tilesH:Int;
	public var areaW:Int;
	public var areaH:Int;
	
	//img is the spritesheed to be used
	//width and height are the width and height of a single tile
	//tBorder is the spacing between tiles (if any) in pixels
	//tEdge is the size of the border around the grid (if any) in pixels
	public function new(img:BitmapData, width:Int, height:Int, tBorder:Int = 0, tEdge:Int = 0) 
	{		
		sprite = img;
		
		tilesW = width;
		tilesH = height;
		
		border = tBorder;
		edge = tEdge;
		areaW = Std.int((sprite.width - 2 * edge + 1) / (tilesW + border));
		areaH = Std.int((sprite.height - 2 * edge + 1) / (tilesH + border));
		
		tPoint = new Point(0, 0);
		tRect = new Rectangle(0, 0, tilesW, tilesH);
	}
	
	//will return a ByteArray corresponding to the tile at (x,y) on the grid
	public function getTileBA(x:Int, y:Int):ByteArray
	{
		tRect.x = edge + (border + tilesW) * x;
		tRect.y = edge + (border + tilesH) * y;
		
		return sprite.getPixels(tRect);
	}
	
	//will return a Vector corresponding to the tile at (x,y) on the grid
	public function getTileVector(x:Int, y:Int):Vector<UInt>
	{
		tRect.x = edge + (border + tilesW) * x;
		tRect.y = edge + (border + tilesH) * y;
		
		return sprite.getVector(tRect);
	}
	
	//will return a BitmapData corresponding to the tile at (x,y) on the grid
	public function getTileBMD(x:Int, y:Int):PixMap
	{
		var BMD:PixMap = new PixMap(tilesW, tilesH);
		
		tPoint.x = 0;
		tPoint.y = 0;
		BMD.copyPixels(sprite, getTileRect(x, y), tPoint);
		
		return BMD;
	}
	
	public function getBMDFromInd(i:Int):PixMap
	{
		return getTileBMD(i % areaW, Std.int(i / areaW));
	}
	
	//gives the rectangle of a tile on the spritesheet in pixel-coordinates
	public function getTileRect(x:Int, y:Int):Rectangle
	{
		tRect.x = edge + (border + tilesW) * x;
		tRect.y = edge + (border + tilesH) * y;
		
		return tRect.clone();
	}
	
	//draws the tile at x,y on the grid to the BitmapData BMD
	//the upper left corner of the drawn tile will be at (x2,y2) on the BMD
	public function drawToBMD(x:Int, y:Int, x2:Int, y2:Int, BMD:BitmapData):Void
	{
		tPoint.x = x2;
		tPoint.y = y2;
		BMD.copyPixels(sprite, getTileRect(x, y), tPoint);
	}
	
	public function toAnimation(frames:Vector<Point>):SpriteAnim
	{
		return new SpriteAnim(sprite, tilesW, tilesH, frames, border, edge);
	}
}