package ;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.Lib;
import tFramework.core.Manager;
import tFramework.tile.TileEntity;


class Main 
{
	private static var s:Sprite;
	private static var t:TileEntity;
	private static var s2:Sprite;
	
	static function main() 
	{
		Manager.main();
		t = new TileEntity(30, 30);
		s = new Sprite();
		s.graphics.beginFill(0xff0000);
		s.graphics.drawRect(0, 0, 30, 30);
		
		s2 = new Sprite();
		s2.graphics.beginFill(0x00ff00);
		s2.graphics.drawRect(0, 0, 30, 30);
		s2.x = s2.y = 100;
		Lib.current.addChild(s);
		Lib.current.addChild(s2);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, md);
		
		trace(0);
	}
	
	static private function md(e:MouseEvent):Void 
	{
		var r1:Rectangle = new Rectangle(t.x, t.y, t.width, t.height);
		t.velX = Lib.current.mouseX - t.x;
		t.velY = Lib.current.mouseY - t.y;
		t.x += t.velX;
		t.y += t.velY;
		var r2:Rectangle = new Rectangle(t.x, t.y, t.width, t.height);
		var f = t.solveTile(100, 100, 30, 30, r2.union(r1));
		if (f.hit)
		{
			t.x -= t.velX * f.time;
			t.y -= t.velY * f.time;
		}
		s.x = t.x;
		s.y = t.y;
	}
	
}