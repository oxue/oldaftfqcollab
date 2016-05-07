package editor;

import editor.EditBuffer;
import editor.EnginePanel;
import editor.Entity;
import editor.Menu;
import editor.NewBufferWizard; 				
import editor.OpenBuffer;
import editor.TestMapPanel;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.events.Event;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import tFramework.core.Manager;
import tFramework.render.Screen;
import tk.Panel;
import tk.SimpleOut;

class EditorCore
{
	public static var displayTarget:DisplayObjectContainer;

	public static var selectedTile:Int;
	public static var selectedTool:Int;
	public static var selectedEnt:Int;

	public static var mainPanel:Panel;

	public static var currBuffer:EditBuffer;

	public static var entIcon:BitmapData;
	public static var loader:Loader;

	public static var selectedEntity:Entity;

	public static var mapName:String;

	public static var engp:EnginePanel;
	public static var tmp:TestMapPanel;

	public static function init(_displayTarget:DisplayObjectContainer):Void
	{
		displayTarget = _displayTarget;

		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, finish);
		loader.load(new URLRequest("entIcon.png"));
	}

	public static function finish(e:Event):Void
	{

		entIcon = new BitmapData(16,16);
		entIcon.draw(loader);
		entIcon.floodFill(0,0,0);
		entIcon.floodFill(0,15,0);
		entIcon.floodFill(15,0,0);
		entIcon.floodFill(15,15,0);
		entIcon = new ByteImage(entIcon).decode();
		mainPanel = new Panel('',0,0,false,false,false);
		displayTarget.addChild(mainPanel);

		var m:Menu = new Menu();
		addPanel(m);
		m.x = 1000;

		SimpleOut.init();
		addPanel(SimpleOut.instance);
		
		engp = new EnginePanel();
		addPanel(engp);
		engp.x = 800;
		engp.y = 600 - engp.height;

		SimpleOut.instance.y = 450;
		SimpleOut.writeLn("hi, I'm the editor, any error output, loading notices etc will come out here. Remember, if no error or debug information comes out and nothing is happening, I'm probably still working, be patient");
		
		Manager.main();
		Manager.clearModules();
		tmp = new TestMapPanel();
		mainPanel.addChild(tmp);
		Screen.setup(EditorCore.tmp.container, 2, 0x555555);
	}

	public static function openBuffer():Void
	{
		var ow:OpenBuffer = new OpenBuffer();
		addPanel(ow);
		ow.x = 500 - ow.width * 0.5;
		ow.y = 300 - ow.height * 0.5;
	}

	public static function newBuffer():Void
	{
		var nbw:NewBufferWizard = new NewBufferWizard();
		addPanel(nbw);
		nbw.x = 500 - nbw.width * 0.5;
		nbw.y = 300 - nbw.height * 0.5;
	}

	public static function addPanel(_panel:Panel):Panel
	{
		mainPanel.stackSubPanel(_panel);
		_panel.x = _panel.y = 0;
		return _panel;
	}

	public static function encode():String
	{
		if(currBuffer == null)
		{
			SimpleOut.writeLn("cannot save for the following reason(s):");
			SimpleOut.writeLn("    no edit buffer open");
			return null;
		}

		var obj:Dynamic = {};

		if(obj==null)
		{
			trace("!!");
		}

		var obj:Dynamic ={};

		obj.map_name = currBuffer.title.text;
		obj.tile_size = currBuffer.displayTilemap.tilesize;
		obj.map_width = currBuffer.displayTilemap.mapWidth;
		obj.map_height = currBuffer.displayTilemap.mapHeight;
		obj.data = currBuffer.data;

		var es = new Array<Dynamic>();
		var i:Int = currBuffer.displayTilemap.entities.length;
		while(i-->0)
		{
			var e:Dynamic = {};
			e.x = currBuffer.displayTilemap.entities[i].x;
			e.y = currBuffer.displayTilemap.entities[i].y;
			e.name = currBuffer.displayTilemap.entities[i].name;
			e.bounds = currBuffer.displayTilemap.entities[i].bounds;
			es.push(e);
		}

		obj.entities = es;
		obj.cfg = currBuffer.cfg;
		obj.sheet_name = currBuffer.tilesheetName;
		
		var tiles:String = new ByteImage(currBuffer.displayTilemap.graphic).data;
		//obj.tile_sheet_data = tiles;
		obj.sheet_width = currBuffer.displayTilemap.graphic.width;
		obj.sheet_height = currBuffer.displayTilemap.graphic.height;

		mapName = obj.map_name;
		SimpleOut.writeLn(flash.utils.JSON.stringify(obj));

		return flash.utils.JSON.stringify(obj);
	}

	public static function saveMap():Void
	{
		var str:String = encode();

		SimpleOut.writeLn("you are saving this string:");
		SimpleOut.writeLn(str);

		new FileReference().save(str,mapName + ".json");
	}
}