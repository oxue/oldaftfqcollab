package editor;

import editor.Entities;
import editor.Tilemap;
import editor.TilePallet;
import editor.ToolBox;
import tk.Input;
import tk.io.BinaryLoader;
import tk.io.GraphicLoader;
import tk.Panel;
import tk.Button;
import tk.SimpleOut;

class NewBufferWizard extends Panel
{
	public var mapNameInput:Input;
	public var mapWidthInput:Input;
	public var mapHeightInput:Input;
	public var tileSizeInput:Input;
	public var cfgFileInput:Input;
	public var tilesheetFileInput:Input;
	public var browseCfgButton:Button;
	public var browseTilesheetButton:Button;

	public var tilesheetReady:Bool;
	public var cfgReady:Bool;

	public var okButton:Button;

	public function new()
	{
		super("New Buffer", 300, 400, true, true, true);

		mapNameInput = new Input("map name", 250);
		mapWidthInput = new Input("map width", 250);
		mapHeightInput = new Input("map height", 250);
		tileSizeInput = new Input("tilesize", 250);
		cfgFileInput = new Input("config", 200);
		browseCfgButton = new Button("...",30,20,browseCfg);
		tilesheetFileInput = new Input("tilesheet", 200);
		browseTilesheetButton = new Button("...",30,20,browseSheet);
		okButton = new Button("accept", 100,100, ok);

		stackSubPanel(mapNameInput);
		stackSubPanel(mapWidthInput);
		stackSubPanel(mapHeightInput);
		stackSubPanel(tileSizeInput);
		stackSubPanel(cfgFileInput);
		stackSubPanel(browseCfgButton);
		stackSubPanel(tilesheetFileInput);
		stackSubPanel(browseTilesheetButton);
		stackSubPanel(okButton);
	}

	public function browseCfg():Void
	{
		BinaryLoader.startLoadSequence(cfgComplete);
		SimpleOut.writeLn("loading config file, moment please. You cannot click ok at this moment");
	}

	public function cfgComplete():Void
	{
		cfgReady = true;
		cfgFileInput.value = BinaryLoader.fr.name;
		SimpleOut.writeLn("    config file done loading without error");
	}

	public function browseSheet():Void
	{
		GraphicLoader.startLoadSequence(sheetComplete);
		SimpleOut.writeLn("loading graphic, moment please. You cannot click ok at this moment");
	}

	public function sheetComplete():Void
	{
		tilesheetReady = true;
		tilesheetFileInput.value = GraphicLoader.fr.name;
		SimpleOut.writeLn("    graphic file done loading without error");
	}

	public function ok():Void
	{
		SimpleOut.writeLn("I'm now checking the form for validation");
		var allFilled:Bool = true;
		var i:Int = children.length;
		while(i-->0)
		{
			if(Std.is(children[i],Input))
			{
				if(cast(children[i],Input).value == '')
				{
					allFilled = false;
					break;
				}
			}
		}

		if(!tilesheetReady || !cfgReady || !allFilled)
		{
			SimpleOut.writeLn("you clicked ok in new buffer wizard; your request can't be completed because:");
			SimpleOut.writeLn("    one or more required fields are empty, malformed, incomplete or loading in progress");
			SimpleOut.writeLn("    tilesheet ready : " + cast tilesheetReady);
			SimpleOut.writeLn("    cfg ready : " + cast cfgReady);
			SimpleOut.writeLn("    fields ready : " + cast allFilled);
			return;
		}

		SimpleOut.writeLn("accepted, I'm now generating a tilemap object");
		var t:Tilemap = new Tilemap(GraphicLoader.data, cast mapWidthInput.value, cast mapHeightInput.value, cast tileSizeInput.value);
		SimpleOut.writeLn("I have made the tilemap without any problems, will now give you the buffer window");
		var p:EditBuffer =cast  EditorCore.addPanel(new EditBuffer(mapNameInput.value,t));
		EditorCore.currBuffer = cast p;
		SimpleOut.writeLn("buffer created, making toolbox right now");

		var tb:ToolBox = new ToolBox();
		EditorCore.currBuffer.binds.push(tb);
		SimpleOut.writeLn("tools created, I'm now going to make the pallet available");

		var tp:TilePallet = new TilePallet(GraphicLoader.data, cast tileSizeInput.value, BinaryLoader.data);
		p.onTopOfMe.push(EditorCore.addPanel(tp));
		tp.x = 800;
		SimpleOut.writeLn("pallet created, I'm now making the entities window");
		tp.y = tb.y + tb.height;
		EditorCore.currBuffer.binds.push(tp);

		var es:Entities = new Entities(BinaryLoader.data);
		EditorCore.currBuffer.binds.push(es);
		EditorCore.addPanel(es);
		p.onTopOfMe.push(es);
		p.onTopOfMe.push(EditorCore.addPanel(tb));
		tb.x = 800;
		es.x = 800;
		es.y = tp.y + tp.height;
		
		p.tilesheetName = tilesheetFileInput.value;

		SimpleOut.writeLn("entities done, everying should be set, closing the wizard window");
		closeWindow();
	}
}