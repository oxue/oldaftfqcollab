package tFramework.core.modules;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.Vector;
import libTF.utils.Point3D;
import libTF.utils.Vector3D;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;
import tFramework.render.Screen;
import tFramework.render.Spritesheet;
import tFramework.core.KeyManager;
import tFramework.core.Manager;
import flash.ui.Keyboard;
import flash.geom.Point;

class Raycaster extends Module
{

	private var map:Vector3D<Int>;
	private var sheet:Spritesheet;
	private var pos:Point3D;
	private var ang:Float;
	private var dimPlane:Point;
	private var FOV:Float;
	
	private var centerPlane:Point;
	private var distPlane:Int;
	private var angStep:Float;
	private var walls:Vector<BitmapData>;
	
	private var velX:Float;
	private var velY:Float;
	private var velR:Float;
	
	public function new(map:Vector3D<Int>, sheet:Spritesheet, pos:Point3D, ang:Float, dimPlane:Point, FOV:Float) 
	{
		super();
		
		this.map = map;
		this.sheet = sheet;
		this.pos = pos;
		this.ang = ang * Math.PI/180;
		this.dimPlane = dimPlane;
		this.FOV = FOV * Math.PI / 180;
		
		this.walls = new Vector<BitmapData>(sheet.height * sheet.width); 
		
		var i:Int = 0;
		while (i < sheet.height * sheet.width)
		{
			this.walls[i] = sheet.getBMDFromInd(i);
			i++;
		}
		
		centerPlane = new Point(dimPlane.x / 2, dimPlane.y / 2);
		distPlane = Std.int(centerPlane.x / (Math.tan(this.FOV / 2)));
		angStep = this.FOV / dimPlane.x;
		
		velX = velY = velR = 0;
		
		//render(Screen.buffer);
		//Screen.flip();
	}
	
	override public function update():Void
	{
		if (KeyManager.isPressedStr("D"))
		{
			velX += MathUtils.cos(ang+Math.PI/2)* 5;
			velY -= MathUtils.sin(ang+Math.PI/2)* 5;
		}
		if (KeyManager.isPressedStr("A"))
		{
			velX  -= MathUtils.cos(ang+Math.PI/2)* 5;
			velY += MathUtils.sin(ang+Math.PI/2)* 5;
		}
		if (KeyManager.isPressedStr("W"))
		{
			velX  += MathUtils.cos(ang)* 5;
			velY -= MathUtils.sin(ang)* 5;
		}
		if (KeyManager.isPressedStr("S"))
		{
			velX  -= MathUtils.cos(ang)* 5;
			velY += MathUtils.sin(ang)* 5;
		}
		if (KeyManager.isPressedStr("Q"))
		{
			velR -= .03;
			velR *= .8;
		}
		else if (KeyManager.isPressedStr("E"))
		{
			velR += .03;
			velR *= .8;
		}
		else
		{
			velR *= .5;
		}
		
		velX *= .6;
		velY *= .6;
		
		pos.x += velX;
		pos.y += velY;
		ang += velR;
		
		
		ang %= Math.PI * 2;
		if (ang < 0) { ang += Math.PI * 2; }
		
		var cx:Int = Std.int(pos.x/64);
		var cy:Int = Std.int(pos.y / 64);
		
		var u:Bool = map.get(cx, cy - 1, 0) != 0;
		var r:Bool = map.get(cx + 1, cy, 0) != 0;
		var l:Bool = map.get(cx - 1, cy, 0) != 0;
		var d:Bool = map.get(cx, cy + 1, 0) != 0;
		var c:Bool = map.get(cx, cy, 0) != 0;
		
		/*var ur:Boolean = map.get(cx + 1, cy - 1, 0) != 0;
		var ul:Boolean = map.get(cx - 1, cy - 1, 0) != 0;
		var dr:Boolean = map.get(cx + 1, cy + 1, 0) != 0;
		var dl:Boolean = map.get(cx - 1, cy + 1, 0) != 0;*/
		
		if (c) { pos.x = ((pos.x % 64 - 32) / 4) + MathUtils.round(pos.x / 64) * 64; pos.y = ((pos.y % 64 - 32) / 4) + MathUtils.round(pos.y / 64) * 64; }
		if (r && velX > 0 && pos.x % 64 > 54) { velX = 0; pos.x = cx * 64 + 54; }
		if (l && velX < 0 && pos.x % 64 < 10) { velX = 0; pos.x = cx * 64 + 10; }
		if (d && velY > 0 && pos.y % 64 > 54) { velY = 0; pos.y = cy * 64 + 54; }
		if (u && velY < 0 && pos.y % 64 < 10) { velY = 0; pos.y = cy * 64 + 10; }
		
	}
	
	override public function render(map:PixMap, context:RenderContext):Void
	{
		var dVec:Vector<Float> = new Vector<Float>(Std.int(dimPlane.x), true);
		var oVec:Vector<Int> = new Vector<Int>(Std.int(dimPlane.x), true);
		var wVec:Vector<Int> = new Vector<Int>(Std.int(dimPlane.x), true);
		
		var dx:Float;
		var dy:Float;
		
		var cPt1:Point = new Point(0, 0);
		var cPt2:Point = new Point(0, 0);
		
		var cPos:Point = new Point(pos.x, pos.y);
		
		var l1:Float;
		var l2:Float;
		
		var l:Int = 0;
		
		var a:Int;
		var b:Int;
		
		var cAng:Float = (ang - FOV/2) % (Math.PI * 2);
		if (cAng < 0) { ang += Math.PI * 2; }
		var i:Int = 0;
		
		while (i < dimPlane.x)
		{
			
			if (cAng <= Math.PI)
			{     
				cPt1.y = Std.int(pos.y / 64) * (64) -.1;
				dy = -64;
			}
			else
			{
				cPt1.y = Std.int(pos.y / 64) * 64 + 64;
				dy = 64;
			}
			
			dx = -dy / Math.tan(cAng);
			
			cPt1.x = pos.x + (pos.y - cPt1.y) / Math.tan(cAng);
			
			a = this.map.get(Std.int(cPt1.x / 64), Std.int(cPt1.y / 64), 0);
			
			while (a == 0)
			{
				cPt1.x += dx;
				cPt1.y += dy;
				a = this.map.get(Std.int(cPt1.x / 64), Std.int(cPt1.y / 64), 0);
			}
			
			if (cAng >= Math.PI/2 && cAng <= Math.PI*3/2)
			{     
				cPt2.x = Std.int(pos.x / 64) * (64) - .1;
				dx = -64;
			}
			else
			{
				cPt2.x = Std.int(pos.x / 64) * 64 + 64;
				dx = 64;
			}
			
			dy = -dx * Math.tan(cAng);
			
			cPt2.y = pos.y + (pos.x - cPt2.x) * Math.tan(cAng);
			
			b = this.map.get(Std.int(cPt2.x / 64), Std.int(cPt2.y / 64), 0);
			
			while (b == 0)
			{
				cPt2.x += dx;
				cPt2.y += dy;
				b = this.map.get(Std.int(cPt2.x / 64), Std.int(cPt2.y / 64), 0);
			}
			
			l1 = cPt1.subtract(cPos).length;
			l2 = cPt2.subtract(cPos).length;
			
			if (a == -1 && b == -1)
			{
				dVec[i] = -1;
				oVec[i] = Std.int(cPt2.y % 64);
				wVec[i] = -1;
			}
			else if (l1 > l2)
			{
				dVec[i] = l2 * MathUtils.cos(cAng - ang);
				oVec[i] = Std.int(cPt2.y % 64);
				wVec[i] = b;
			}
			else 
			{
				dVec[i] = l1 * MathUtils.cos(cAng - ang);
				oVec[i] = Std.int(cPt1.x % 64);
				wVec[i] = a;
			}
			
			cAng += angStep;
			cAng %= (Math.PI * 2);
			if (cAng < 0) { cAng += Math.PI * 2; }
			i++;
		}
		
		var bSize:Float;
		var off:Int;
		i = 0;
		while (i < Std.int(dVec.length))
		{
			if (dVec[i] == -1) { i++; continue; }
			
			bSize = (64 / dVec[i] * distPlane);
			
			off = Std.int((dimPlane.y - bSize) / 2);
			
			drawRow(i, map, bSize / 64, oVec[i], off, wVec[i]);
			i++;
		}
		
	}
	
	inline public function drawRow(slice:Int, target:BitmapData, scale:Float, row:Int, offset:Int, texID:Int):Void
	{
		offset += Std.int(scale * (pos.z - 32));
		
		var wall:BitmapData = walls[texID];
		
		scale = 1 / scale;
		var i:Int = 0;
		var i2:Float = 0;
		if (scale > 1)
		{
			if (offset < 0)
			{
				i += offset;
				i2 += offset * scale;
			}
			while (i2 < wall.height && i+offset<target.height && i+offset < dimPlane.y)
			{
				target.setPixel(slice,i+offset, wall.getPixel(row, Std.int(i2)));
				i++;
				i2 += scale;
			}
		}
		else
		{
			var sk:Float = 1 / scale;
			i2 += offset;
			var r:Rectangle = new Rectangle(slice, i2, 1, sk);
			while (i < wall.height && i2 < dimPlane.y)
			{
				target.fillRect(r, wall.getPixel(row, i));
				i2 += sk;
				i++;
				r.y = i2;
				if (i2 + sk > dimPlane.y) { r.height = dimPlane.y - i2; }
			}
		}
	}
	
}
