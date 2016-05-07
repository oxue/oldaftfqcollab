package ;

import editor.CellMap;
import editor.EditorCore;
import editor.Float2;
import flash.display.StageScaleMode;
import flash.geom.Rectangle;
import flash.Vector;
import tFramework.core.Manager;
import tk.Button;
import tk.Panel;
import tk.SimpleOut;
import flash.ui.Mouse;
import flash.ui.MouseCursorData;
import tk.ToolkitEngine;
import flash.display.BitmapData;
import flash.ui.MouseCursor;

class Main
{

	static function main()
	{
		trace(Mouse.supportsNativeCursor);
		var md = new MouseCursorData();
		md.data = new Vector<BitmapData>();
		var b = new BitmapData(16,16,true,0xff000000);
		b.fillRect(new Rectangle(4,4,12,12),0);
		md.data.push(b);
		Mouse.registerCursor('arrow',md);
		b=new BitmapData(16,16,true,0xff000000);
		b.fillRect(new Rectangle(2,2,14,14),0);
		b.fillRect(new Rectangle(6,6,10,10),0xff000000);
		md = new MouseCursorData();
		md.data = new Vector<BitmapData>();
		md.data.push(b);
		Mouse.registerCursor('rect',md);
		Mouse.cursor = 'arrow';
		ToolkitEngine.loadDescriptorFile("dscrpt.txt",done);
		flash.Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	}

	public static function done():Void
	{
		EditorCore.init(flash.Lib.current);
	}
}