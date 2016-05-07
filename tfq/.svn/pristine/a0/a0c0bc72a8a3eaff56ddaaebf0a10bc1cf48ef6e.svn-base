package sfbl.mpedtr 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import sfbl.toolkit.Button;
	import sfbl.toolkit.InputForm;
	import sfbl.toolkit.Panel;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TMNewPanel extends Panel 
	{
		private var mapW:InputForm;
		private var mapH:InputForm;
		private var mapName:InputForm;
		private var tileSize:InputForm;
		private var tilesheet:InputForm;
		private var okButton:Button;
		private var browseButton:Button;
		private var config:InputForm;
		private var configButton:Button;
		private var fileReference:FileReference;
		private var fileReference2:FileReference;
		private var bitmap:Bitmap;
		private var cfgStr:String;
		
		public function TMNewPanel() 
		{
			super("New Map",240,200,true);
			
			mapW = new InputForm("Map Width");
			mapH = new InputForm("Map Height");
			mapName = new InputForm("Map Name");
			tileSize = new InputForm("Tile Size");
			tilesheet = new InputForm("Tile Sheet", 200, 130);
			config = new InputForm("Cfg File", 200, 130);
			
			mapName.itext.text = "default";
			mapW.itext.text = "100";
			mapH.itext.text = "100";
			tileSize.itext.text = "16";
			
			addPanel(mapW);
			addPanel(mapH);
			addPanel(mapName);
			addPanel(tileSize);
			addPanel(tilesheet);
			addPanel(config);
			mapName.y = 20;
			mapName.x = 20;
			mapW.y = 40;
			mapW.x = 20;
			mapH.y = 60;
			mapH.x = 20;
			tileSize.x = 20;
			tileSize.y = 80;
			tilesheet.x = 20;
			tilesheet.y = 100;
			config.x = 20;
			config.y = 120;
			
			browseButton = new Button("...", 30, 20, browsef);
			browseButton.x = 120;
			browseButton.y = 100;
			addPanel(browseButton);
			
			okButton = new Button("Accept",60,20,newf);
			okButton.x = 90;
			okButton.y = 180;
			addPanel(okButton);
			
			configButton = new Button("...", 30, 20, configf);
			configButton.x = 120;
			configButton.y = 120;
			addPanel(configButton);
			
			fileReference = new FileReference();
			fileReference2 = new FileReference();
		}
		
		private function configf():void 
		{
			fileReference2.addEventListener(Event.SELECT, setPath2);
			fileReference2.browse();
		}
		
		private function setPath2(e:Event):void 
		{
			config.itext.text = fileReference2.name;
			fileReference2.removeEventListener(Event.SELECT, setPath2);
		}
		
		private function setPath(e:Event):void 
		{
			tilesheet.itext.text = fileReference.name;
			fileReference.removeEventListener(Event.SELECT, setPath);
		}
		
		private function browsef():void 
		{
			fileReference.addEventListener(Event.SELECT, setPath);
			fileReference.browse();
		}
		
		private function newf():void 
		{
			fileReference.addEventListener(Event.COMPLETE, loadB);
			fileReference.load();
		}
		
		private function loadB(e:Event):void 
		{
			fileReference.removeEventListener(Event.COMPLETE, loadB);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadConfig);
			loader.loadBytes(fileReference.data);
		}
		
		private function loadConfig(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, loadConfig);
			bitmap = Bitmap(LoaderInfo(e.target).content);
			fileReference2.addEventListener(Event.COMPLETE, loadC);
			fileReference2.load();
		}
		
		private function loadC(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, loadC);
			cfgStr = fileReference2.data.readUTFBytes(fileReference2.data.length);
			generatePanel(null);
		}
		
		private function generatePanel(e:Event):void 
		{	
			Panel(parent).addPanel(new TMEditPanel(
													mapName.itext.text, 
													int(mapW.itext.text), 
													int(mapH.itext.text),
													int(tileSize.itext.text),
													bitmap.bitmapData,
													tilesheet.itext.text,
													cfgStr,
													config.itext.text
													)
									);
			unload();
		}
		
	}

}