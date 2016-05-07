package editor;

import editor.ByteImage;
import editor.EditBuffer;
import editor.EditorCore;
import editor.Entities;
import editor.Tilemap;
import editor.TilePallet;
import editor.ToolBox;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.Vector;
import tk.Button;
import tk.Input;
import tk.io.BinaryLoader;
import tk.Panel;

class OpenBuffer extends Panel
{
	public var mapInput:Input;
	public var browseMap:Button;
	public var acceptButton:Button;
	public var loadDone:Bool;
	public var sheetd:BitmapData;
	public var loader:Loader;
	public var mapObj:Dynamic;

	public function new()
	{
		super("Open",300,400);
		mapInput = new Input("map",200);
		browseMap = new Button("...",30,20,startLoad);
		stackSubPanel(mapInput);
		stackSubPanel(browseMap);
		acceptButton = new Button("accept",100,100,accept);
		stackSubPanel(acceptButton);
		loader = new Loader();
		loader.load(new URLRequest("tiles.png"));
	}

	public function startLoad():Void
	{
		BinaryLoader.startLoadSequence(complete); 
	}

	public function complete():Void
	{
		
		mapInput.value = BinaryLoader.fr.name;	
		loader = new Loader();
		mapObj = flash.utils.JSON.parse(BinaryLoader.data);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, doneSheet);
		trace(mapObj.sheet_name);
		loader.load(new URLRequest(mapObj.sheet_name));
	}
	
	private function doneSheet(e:Event):Void 
	{
		sheetd = cast(loader.content, Bitmap).bitmapData;
		sheetd = new BitmapData(sheetd.width, sheetd.height, false);
		sheetd.copyPixels(cast(loader.content, Bitmap).bitmapData,cast(loader.content, Bitmap).bitmapData.rect,new Point());
		loadDone = true;
	}

	public function accept():Void
	{
		if(!loadDone)
		{
			return;
		}
		var tm:Tilemap = new Tilemap(sheetd,mapObj.map_width, mapObj.map_height, mapObj.tile_size);
		var i:Int = mapObj.map_height;
		var vd:Vector<Vector<Int>> = new Vector<Vector<Int>>(mapObj.map_height,true); 
		while(i-->0)
		{
			vd[i] = new Vector<Int>(mapObj.map_width);
			var j:Int = mapObj.map_width;
			while(j-->0)
			{
				vd[i][j] = mapObj.data[i][j];
				tm.data[i][j] = mapObj.data[i][j];
			}
		}
		var eb:EditBuffer = new EditBuffer(mapObj.map_name,tm);
		EditorCore.currBuffer = eb;
		EditorCore.addPanel(eb);
		eb.data = vd;
		eb.tilesheetName = mapObj.sheet_name;

		var tb:ToolBox = new ToolBox();
		EditorCore.addPanel(tb);
		tb.x = 800;
		eb.onTopOfMe.push(tb);
		EditorCore.currBuffer.binds.push(tb);

		var cfgStr:String = flash.utils.JSON.stringify(mapObj.cfg);
		var plt:TilePallet = new TilePallet(sheetd,mapObj.tile_size,cfgStr);
		EditorCore.addPanel(plt);
		plt.x = 800;
		plt.y = tb.y + tb.height;
		eb.onTopOfMe.push(plt);
		EditorCore.currBuffer.binds.push(plt);

		i = mapObj.map_height;
		
		while(i-->0)
		{
			var j:Int = mapObj.map_width;
			while(j-->0)
			{
				eb.autotile(j,i);
			}
		}
		
		var en:Entities = new Entities(cfgStr);
		EditorCore.currBuffer.binds.push(en);
		EditorCore.addPanel(en);
		en.x = 800;
		en.y = plt.y + plt.height;
		eb.onTopOfMe.push(en);
		closeWindow();
		eb.updateScreen();

		var i:Int = mapObj.entities.length;
		while(i-->0)
		{
			eb.displayTilemap.addEntity(
				new Entity(mapObj.entities[i].name,
					mapObj.entities[i].x,
					mapObj.entities[i].y,
					mapObj.entities[i].bounds)
			);
		}
		
		eb.autotileAll();
	}
}