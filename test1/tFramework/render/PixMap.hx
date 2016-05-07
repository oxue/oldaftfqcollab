package tFramework.render;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Vector;
import libTF.utils.IntRect;
import libTF.utils.MathUtils;

class PixMap extends BitmapData, implements Renderable
{
	//TODO caching
	//TODO bake animation function
	
	public var fillColor:UInt;
	private var irect:IntRect;
	private var point:Point;
	
	public function new(width:Int, height:Int, transparent:Bool = true, fillColor:UInt = 0x00000000) 
	{
		super(width, height, transparent, fillColor);
		this.fillColor = fillColor;
		irect = new IntRect(0, 0, width, height);
		point = new Point();
	}
	
	public function clonePM():PixMap
	{
		var p:PixMap = new PixMap(width, height, transparent, fillColor);
		point.x = point.y = 0;
		p.copyPixels(this, this.rect, point);
		return p;
	}
	
	inline public function clear():Void
	{
		fillRect(rect, fillColor);
	}
	
	inline public static function fromBMD(b:BitmapData, fillColor:UInt = 0x00000000):PixMap
	{
		var p:PixMap = new PixMap(b.width, b.height, b.transparent, fillColor);
		p.copyPixels(b, b.rect, new Point(0, 0));
		return p;
	}
	
	//TODO fix wierdness with transparency
	//TODO inline
	public function render(map:PixMap, ctx:RenderContext):Void
	{
		
		//clone and 'init'
		//TODO should we do this?
		if (ctx == null) { ctx = new RenderContext(); }
		else { ctx = ctx.clone(); }
		
		//DANGER: Some rects not cloned (faster). Beware modifying rects.
		ctx.rotation %= Math.PI * 2;
		if (ctx.rotation < 0) { ctx.rotation += Math.PI * 2; }
		if (ctx.border == null) { ctx.border = map.irect; } //this
		else {ctx.border = ctx.border.intersection(map.irect); }
		if (ctx.clipping == null) { ctx.clipping = irect; } //this
		else { ctx.clipping = ctx.clipping.intersection(irect); }
		
		//no transform
		if (ctx.rotation == 0 && ctx.scaleX == 1 && ctx.scaleY == 1 && !ctx.fliph && !ctx.flipv)
		{
			point.x = ctx.x - ctx.originX; 
			point.y = ctx.y - ctx.originY;
			map.copyPixels(this, ctx.clipping.toRect(), point);
		}
		//hflip
		else if (ctx.rotation == 0 && ctx.scaleX == 1 && ctx.scaleY == 1 && !ctx.flipv)
		{
			var fRect:IntRect = ctx.clipping.intersection(irect);
			var i:Int = fRect.x;
			var r:Rectangle = new Rectangle(0, fRect.y, 1, fRect.height);
			point.x = ctx.x - ctx.originX + fRect.width;
			point.y = ctx.y - ctx.originY;
			while (i < fRect.width + fRect.x)
			{
				r.x = i;
				point.x--;
				map.copyPixels(this, r, point);
				i++;
			}
		}
		//vflip
		else if (ctx.rotation == 0 && ctx.scaleX == 1 && ctx.scaleY == 1 && !ctx.fliph)
		{
			var fRect:IntRect = ctx.clipping.intersection(irect);
			var i:Int = fRect.y;
			var r:Rectangle = new Rectangle(fRect.x, 0, fRect.width, 1);
			point.x = ctx.x - ctx.originX;
			point.y = ctx.y - ctx.originY + fRect.height;
			while (i < fRect.height + fRect.y)
			{
				r.y = i;
				point.y--;
				map.copyPixels(this, r, point);
				i++;
			}
		}
		//both flip
		else if (ctx.rotation == 0 && ctx.scaleX == 1 && ctx.scaleY == 1)
		{
			var fRect:IntRect = ctx.clipping.intersection(irect);
			var q:Vector<UInt> = getVector(fRect.toRect());
			q.reverse();
			map.setVector(new Rectangle(ctx.x - ctx.originX, ctx.y - ctx.originY, fRect.width, fRect.height), q);
		}
		//90 rot
		else if (ctx.rotation == Math.PI/2 && ctx.scaleX == 1 && ctx.scaleY == 1 && !ctx.fliph && !ctx.flipv)
		{
			//TODO optimize by itterating through ys and removing reverse()
			var fRect:IntRect = ctx.clipping.intersection(irect);
			var i:Int = fRect.x;
			var r1:Rectangle = new Rectangle(0, fRect.y, 1, fRect.height);
			var r2:Rectangle = new Rectangle(ctx.x - ctx.originY, ctx.y + ctx.originX, fRect.height, 1);
			while (i < fRect.width + fRect.x)
			{
				r1.x = i;
				r2.y--;
				map.setVector(r2, getVector(r1));
				i++;
			}
		}
		//180 rot
		else if (ctx.rotation == Math.PI && ctx.scaleX == 1 && ctx.scaleY == 1 && !ctx.fliph && !ctx.flipv)
		{
			var fRect:IntRect = ctx.clipping.intersection(irect);
			var q:Vector<UInt> = getVector(fRect.toRect());
			q.reverse();
			map.setVector(new Rectangle(ctx.x - fRect.width + ctx.originX, ctx.y - fRect.height + ctx.originY, fRect.width, fRect.height), q);
		}
		//270 rot
		else if (ctx.rotation == Math.PI*3/2 && ctx.scaleX == 1 && ctx.scaleY == 1 && !ctx.fliph && !ctx.flipv)
		{
			var fRect:IntRect = ctx.clipping.intersection(irect);
			var i:Int = fRect.x;
			var r1:Rectangle = new Rectangle(0, fRect.y, 1, fRect.height);
			var r2:Rectangle = new Rectangle(ctx.x + ctx.originY - fRect.height, ctx.y - ctx.originX, fRect.height, 1);
			var q:Vector<UInt>;
			while (i < fRect.width + fRect.x)
			{
				r1.x = i;
				q = getVector(r1);
				q.reverse();
				map.setVector(r2, q);
				r2.y++;
				i++;
			}
		}
		//general case
		else
		{
			//MAYBE this feels like a hack
			if (ctx.fliph) { ctx.clipping.x = width - ctx.clipping.x - ctx.clipping.width; }
			if (ctx.flipv) { ctx.clipping.y = height - ctx.clipping.y - ctx.clipping.height; }
			
			var i:Int;
			var j:Int;
			
			var jcap:Int;
			
			var dy2:Float;
			var dx2:Float;
			var dst:Float;
			var an:Float;
			var px:Float;
			var py:Float;
			var c:UInt;
			
			var scos:Float = MathUtils.cos(ctx.rotation);
			var ssin:Float = MathUtils.sin(ctx.rotation);
			var stan:Float = ssin / scos;
			var scot:Float = scos / ssin;
			
			var dx:Float = -(ctx.clipping.width / 2 - ctx.originX) * ctx.scaleX;
			var dy:Float = -(ctx.clipping.height / 2 - ctx.originY) * ctx.scaleY;
			
			var dist:Float = Math.sqrt(dx * dx + dy * dy);
			var ang:Float = Math.atan2(dy, dx) - ctx.rotation;
			
			var cx:Float = ctx.originX - dist * MathUtils.cos(ang);
			var cy:Float = ctx.originY - dist * MathUtils.sin(ang);
			
			var ex:Float = (ctx.clipping.width * ctx.scaleX * MathUtils.abs(scos) + ctx.clipping.height * ctx.scaleY * MathUtils.abs(ssin)) / 2;
			var ey:Float = (ctx.clipping.height * ctx.scaleY * MathUtils.abs(scos) + ctx.clipping.width * ctx.scaleX * MathUtils.abs(ssin)) / 2;
			
			var left:Int = Std.int(cx - ex);
			var right:Int = Std.int(cx + ex);
			var top:Int = Std.int(cy - ey);
			var bottom:Int = MathUtils.imin (Std.int(cy + ey), ctx.border.y + ctx.border.height - Std.int(ctx.y - ctx.originY));
			
			var sector:Bool = (ctx.rotation % Math.PI < Math.PI / 2);
			var cots1:Float = MathUtils.abs(sector?scot:stan);
			var cots2:Float = MathUtils.abs(sector?stan:scot);
			
			var lterm:Float = sector?(ctx.clipping.width * ctx.scaleX * MathUtils.abs(ssin) + top):(ctx.clipping.height * ctx.scaleY * MathUtils.abs(scos) + top);
			var rterm:Float = sector?(ctx.clipping.height * ctx.scaleY * MathUtils.abs(scos) + top):(ctx.clipping.width * ctx.scaleX * MathUtils.abs(ssin) + top);
			
			var bleft:Int = ctx.border.x - Std.int(ctx.x - ctx.originX);
			var bright:Int = ctx.border.x + ctx.border.width - Std.int(ctx.x - ctx.originX);
			
			var mcos:Float = scos / ctx.scaleX;
			var msin:Float = ssin / ctx.scaleY;
			
			var ix:Int = Std.int(ctx.x - ctx.originX);
			var iy:Int = Std.int(ctx.y - ctx.originY);
			
			i = MathUtils.imax(top, ctx.border.y - iy);
			
			while (i < bottom)
			{
				if (i < lterm) { j = Std.int(left + ((lterm - i) * cots1)); }
				else { j = Std.int(left + ((i - lterm) * cots2)); }
				
				j = MathUtils.imax(j, bleft);
				
				if (i < rterm) { jcap = Std.int(right - ((rterm - i) * cots2)); }
				else { jcap = Std.int(right - ((i - rterm) * cots1)); }
				
				jcap = MathUtils.imin(jcap, bright);
				
				dy2 = -ctx.originY + i;
				dx2 = -ctx.originX + j;
				dst = Math.sqrt(dx2 * dx2 + dy2 * dy2);
				an = Math.atan2(dy2, dx2) + ctx.rotation;
				
				px = ctx.originX + dst * MathUtils.cos(an) / ctx.scaleX;
				py = ctx.originY + dst * MathUtils.sin(an) / ctx.scaleY;
				c = 0;
				while (j < jcap)
				{
					px += mcos;
					py += msin;
					
					c = getPixel32(Std.int(ctx.fliph?(width - px - ctx.clipping.x):(px+ctx.clipping.x)), Std.int(ctx.flipv?(height - py - ctx.clipping.x):(py+ctx.clipping.y)));
					
					//sloooow
					/*if (!rect.contains(px,py))
					{
						c = 0xFF0000;
					}*/
					
					map.setPixel32(j + ix, i + iy, c);
					
					j++;
				}
				i++;
			}
		}
	}
	
}