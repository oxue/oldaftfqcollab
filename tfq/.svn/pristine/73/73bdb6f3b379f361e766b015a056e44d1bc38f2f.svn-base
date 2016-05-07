package sfbl.mpedtr 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	import mx.core.ButtonAsset;
	import org.as3yaml.YAML;
	import sfbl.toolkit.Button;
	import sfbl.toolkit.DropMenu;
	import sfbl.toolkit.LoaderHelper;
	import sfbl.toolkit.Panel;
	import sfbl.toolkit.URLLoadHelper;
	import skyboy.serialization.JSON;
	
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TMTopBar extends Panel 
	{
		private var fileDropMenu:DropMenu;
		private var newButton:Button;
		private var openButton:Button;
		private var saveButton:Button;
		
		private var tilemapDropMenu:DropMenu;
		private var autotileButton:Button;
		private var serializeButton:Button;
		
		private var toolsDropMenu:DropMenu;
		private var QuickCodeButton:Button;
		
		private var fileReference:FileReference;
		
		private var saveMOBJ:Object;
		
		private var ldr:LoaderHelper;
		private var hlpr:URLLoadHelper;
		private var sstr:String;
		
		public function TMTopBar() 
		{
			super("Quick Menu", 400, 20);
			
			fileDropMenu = new DropMenu("File", 60);
			newButton = new Button("New", 150, 20, newf);
			fileDropMenu.y = 20;
			fileDropMenu.addButton(newButton);
			
			openButton = new Button("Open", 150, 20,openf);
			fileDropMenu.addButton(openButton);
			
			saveButton = new Button("Save", 150, 20, savef);
			fileDropMenu.addButton(saveButton);
			
			fileReference = new FileReference();
			
			tilemapDropMenu = new DropMenu("TileMap");
			tilemapDropMenu.y = 20;
			tilemapDropMenu.x = 60;
			
			autotileButton = new Button("Autotile Map", 150, 20, autotilef); 
			tilemapDropMenu.addButton(autotileButton);
			
			toolsDropMenu = new DropMenu("Tools");
			QuickCodeButton = new Button("QuickCode", 150, 20, quickcodef);
			toolsDropMenu.x = 120;
			toolsDropMenu.y = 20;
			addPanel(toolsDropMenu);
			toolsDropMenu.addButton(QuickCodeButton);
			
			addPanel(fileDropMenu);
			addPanel(tilemapDropMenu);
		}
		
		private function quickcodef():void 
		{
			Panel(parent).addPanel(new TMQuickCode());
		}
		
		private function autotilef():void 
		{
			MapEditor.currMap.autotile();
		}
		
		override protected function addListeners(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addListeners);
		}
		
		public function savef():void 
		{
			if (MapEditor.currMap)
			{
				fileReference.save(JSON.encode(YAML.decode(MapEditor.currMap.serialize())), MapEditor.currMap.mapName + ".tm");
			}
		}
		
		private function openf():void 
		{
			fileReference = new FileReference();
			fileReference.addEventListener(Event.SELECT, startLoad);
			fileReference.browse();
		}
		
		private function startLoad(e:Event):void 
		{
			MapEditor(parent).spl.show("LOADING");
			fileReference.removeEventListener(Event.SELECT, startLoad);
			fileReference.addEventListener(Event.COMPLETE, generate);
			fileReference.load();
		}
		
		private function generate(e:Event):void 
		{
			fileReference.removeEventListener(Event.COMPLETE, generate);
			sstr = fileReference.data.readUTFBytes(fileReference.data.length);
			saveMOBJ = JSON.decode(sstr);
			trace(saveMOBJ.map.sheet);
			trace(sstr);
			hlpr = new URLLoadHelper();
			hlpr.startURLloadProcedures(saveMOBJ.map.config, donef);
		}
		
		private function donef():void 
		{
			
			ldr = new LoaderHelper();
			trace(saveMOBJ.map.sheet);
			ldr.startLoadingProcedures(saveMOBJ.map.sheet, donef2);
			//var tme:TMEditPanel = new TMEditPanel(saveMOBJ.map.name,saveMOBJ.map.width,saveMOBJ.map.height,saveMOBJ.map.tilesize,
		}
		
		private function donef2():void 
		{
			var tme:TMEditPanel = new TMEditPanel(
			saveMOBJ.map.name,
			saveMOBJ.map.width,
			saveMOBJ.map.height,
			saveMOBJ.map.tilesize,
			Bitmap(ldr.data).bitmapData,
			saveMOBJ.map.sheet,
			hlpr.data,
			saveMOBJ.map.cfgname);
			
			var d:Vector.<Vector.<int>> = tme.tm.data;
			var idv:Vector.<Vector.<int>> = tme.idVector;
			var i:int = d.length;
			while (i--)
			{
				var j:int = d[0].length;
				while (j--)
				{
					d[i][j] = saveMOBJ.map.data[i][j];
					idv[i][j] = saveMOBJ.map.data[i][j];
				}
			}
			
			Panel(parent).addPanel(tme);
			
			MapEditor(parent).spl.visible = false;
		}
		
		private function newf():void 
		{
			var np:TMNewPanel = new TMNewPanel();
			Panel(parent).addPanel(np);
		}
		
	}

}