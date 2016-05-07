package editor;

import editor.EditorCore;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flash.geom.Rectangle;
import tk.Panel;
import tk.SimpleOut;

class TilePallet extends Panel
{
	public var graphic:BitmapData;
	public var bitmap:Bitmap;
	public var tilesize:Int;
	public var hilite:Sprite;
	public var bitmapContainer:Sprite;
	public var tileAmount:Int;


	public function new(_graphic:BitmapData, _tilesize:Int, _cfgData:String)
	{
		tilesize = _tilesize;

		SimpleOut.writeLn(_cfgData);
		
		var cfg:Dynamic = flash.utils.JSON.parse(_cfgData);
		EditorCore.currBuffer.cfg = cfg;

		var r:Rectangle = new Rectangle(0,0,_tilesize,_tilesize);
		var p:Point = new Point();
		graphic = new BitmapData(Std.int(180/_tilesize)*_tilesize,Std.int(cfg.tiles.length/Math.min(Std.int(180/_tilesize),cfg.tiles.length)*_tilesize));

		var i:Int = -1;
		while(i++<cfg.tiles.length-1)
		{
			r.x = cfg.tiles[i].main%((_graphic.width+1)/(_tilesize+1)) * (_tilesize + 1);
			r.y = Std.int(cfg.tiles[i].main/((_graphic.width+1)/(_tilesize+1))) * (_tilesize + 1);
			p.x = i % Std.int(180/_tilesize) * _tilesize;
			p.y = Std.int(i/Std.int(180/_tilesize)) * _tilesize;
			graphic.copyPixels(_graphic,r,p);
		}

		tileAmount = cfg.tiles.length;

		bitmap = new Bitmap(graphic);
		super("Tile Pallet",200, graphic.height + 40);
		bitmapContainer = new Sprite();
		addChild(bitmapContainer);
		bitmapContainer.x = 10;
		bitmapContainer.y = 30;
		bitmapContainer.addChild(bitmap);

		hilite = new Sprite();
		hilite.graphics.lineStyle(3,0x000000);
		hilite.graphics.drawRect(0,0,tilesize,tilesize);
		hilite.graphics.lineStyle(1,0xffffff);
		hilite.graphics.drawRect(0,0,tilesize,tilesize);
		bitmapContainer.addChild(hilite);

		bitmapContainer.addEventListener(MouseEvent.MOUSE_DOWN, palletClick);
	}

	public function palletClick(e:MouseEvent):Void
	{
		var gx:Int = Std.int(bitmap.mouseX / (tilesize));
		var gy:Int = Std.int(bitmap.mouseY / (tilesize));

		var index:Int = gy * Std.int((graphic.width)/(tilesize)) + gx;

		if(index > tileAmount)
		{
			SimpleOut.writeLn("no tile specified in config that correspnds to that location");
			return;
		}

		hilite.x = gx * (tilesize);
		hilite.y = gy * (tilesize);
		
		EditorCore.selectedTile = index;
		SimpleOut.writeLn("you have selected tile number " + cast index);
	}

	public override function closeWindow():Void
	{
		super.closeWindow();
		bitmapContainer.removeEventListener(MouseEvent.MOUSE_DOWN, palletClick);
	}
}












