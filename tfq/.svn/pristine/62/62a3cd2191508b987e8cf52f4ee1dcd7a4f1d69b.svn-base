package sfbl.mpedtr 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.as3yaml.YAML;
	import sfbl.DisplayPort;
	import sfbl.sys.YAMLHelper;
	import sfbl.Tilemap;
	import flash.display.BitmapData;
	import sfbl.toolkit.Panel;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TMEditPanel extends Panel 
	{	
		public var tm:Tilemap;
		private var display:DisplayPort;
		private var pallette:TMTilePallette;
		
		public var mapName:String;
		private var mapW:int;
		private var mapH:int;
		private var editing:Boolean;
		private var tilesize:Number;
		private var mainTilesize:Number;
		
		private var firstPoint:Point;
		private var secondPoint:Point;
		
		private var tools:TMToolPanel;
		
		private var frame:Sprite;
		private var container:Sprite;
		
		private var sh:YAMLHelper;
		private var sheetName:String;
		private var mainSheet:BitmapData;
		
		private var major:Number;
		private var lastMajor:Number;
		private var savePoint:Point;
		private var cfgStr:String;
		
		private var mYaml:Object;
		public var idVector:Vector.<Vector.<int>>;
		private var cfgname:String;
		
		public function TMEditPanel(_mapName:String, _mapW:int, _mapH:int, _tilesize:int, _graphic:BitmapData, _sheetName:String,_cfg:String, _cfgname:String) 
		{
			super("untitled.tm", 850, 650, true);
			
			mapName = _mapName;
			mapW = _mapW;
			mapH = _mapH;
			
			sheetName = _sheetName;
			
			mainSheet = _graphic;
			
			cfgStr = _cfg;
			
			mYaml = YAML.decode(cfgStr);
			
			idVector = new Vector.<Vector.<int>>(mapH, true);
			var i:int = mapH;
			while (i--)
			{
				idVector[i] = new Vector.<int>(mapW, true);
			}
			
			mainTilesize = tilesize = _tilesize;
			
			var v:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(mapH, true);
			i = mapH;
			while (i--)
			{
				v[i] = new Vector.<int>(mapW,true);
			}
			
			display = new DisplayPort(800, 600, 1);
			display.x = 25;
			display.y = 25;
			display.alpha = 0.7;
			addChild(display);
			
			tm = new Tilemap(v, tilesize, tilesize, _graphic);
			display.addEventListener(MouseEvent.MOUSE_DOWN, mdownf);
			display.addEventListener(MouseEvent.MOUSE_UP, mupf);
			display.addEventListener(MouseEvent.MOUSE_MOVE, setTile);
			
			container = new Sprite();
			addChild(container);
			container.x = container.y = 25;
			
			frame = new Sprite();
			frame.graphics.beginFill(0xff0000, 0.2);
			frame.graphics.drawRect(0, 0, 100, 100);
			container.addChild(frame);
			
			pallette = new TMTilePallette(_graphic, tilesize, mYaml);
			pallette.x = 300;
			pallette.y = 300;
			addPanel(pallette);
			
			tools = new TMToolPanel();
			tools.x = this.x + 100;
			tools.y = this.y + 100;
			addPanel(tools);
			
			firstPoint = new Point();
			secondPoint = new Point();
			
			frame.addEventListener(MouseEvent.MOUSE_UP, mupf);
			frame.addEventListener(MouseEvent.MOUSE_MOVE, setTile);
			addEventListener(MouseEvent.MOUSE_WHEEL, wheelf);
			addEventListener(Event.ENTER_FRAME, update);	
			
			sh = YAMLHelper.getInstance();
			major = 1;
			
			savePoint = new Point();
			
			cfgname = _cfgname;
		}
		
		public function serialize():String
		{			
			var ret:String = "";
			ret += "---\r\n";
			ret += "map:\r\n"
			ret += " " + sh.pairToYAMLScal("name", mapName);
			trace(sheetName);
			ret += " " + sh.pairToYAMLScal("sheet", sheetName);
			ret += " " + sh.pairToYAMLScal("config", cfgname);
			ret += " " + sh.pairToYAMLScal("tilesize", tilesize);
			ret += " " + sh.pairToYAMLScal("width", tm.mapW);
			ret += " " + sh.pairToYAMLScal("height", tm.mapH);
			ret += " " + sh.pairToYAMLScal("cfgname", cfgname);
			ret += " " + "data: \r\n";
			var len:int = idVector.length - 1;
			var i:int = -1;
			while (i++ < len)
			{
				ret += "  " + String(i) + ": ";
				ret += sh.vecToYAMLSeq2(idVector[i]);
				ret += "\r\n";
			}
			return ret;
		}
		
		private function wheelf(e:MouseEvent):void 
		{
			editing = false;
			var n:Number = e.delta / Math.abs(e.delta);
			if (n < 0)
			n = 2;
			else
			n = 0.5;
			lastMajor = major;
			major *= n;
			if (major < 0.125)
			major = 0.125;
			if (major > 8)
			major = 8;
			generateScaledSheet(major);
		}
		
		private function setTile(e:MouseEvent):void 
		{
			if(display.mouseX + display.cameraX < 0||
			display.mouseY + display.cameraY < 0||
			display.mouseX + display.cameraX > tilesize * mapW||
			display.mouseY + display.cameraY > tilesize * mapH)
			return;
			if (editing)
			{
				switch(tools.mode)
				{
					case TMToolPanel.NORMAL:
						var wx:int = display.mouseX + display.cameraX;
						var wy:int = display.mouseY + display.cameraY;
						idVector[int(wy / tilesize)][int(wx / tilesize)] = pallette.currIndex;
					break;
					
					case TMToolPanel.RECT:
						frame.visible = true;
						secondPoint.x = display.mouseX + display.cameraX;
						secondPoint.y = display.mouseY + display.cameraY;
						var left:int = Math.min(firstPoint.x, secondPoint.x);
						var right:int = Math.max(firstPoint.x, secondPoint.x);
						var up:int = Math.min(firstPoint.y, secondPoint.y);
						var down:int = Math.max(firstPoint.y, secondPoint.y);
						frame.x = int(left / tilesize) * tilesize - display.cameraX;
						frame.y = int(up / tilesize) * tilesize - display.cameraY;
						frame.width = (int(right / tilesize)+1) * tilesize - display.cameraX - frame.x;
						frame.height = (int(down / tilesize)+1) * tilesize - display.cameraY - frame.y;
					break;
					
					case TMToolPanel.DRAG:
						display.cameraX = savePoint.x - mouseX;
						display.cameraY = savePoint.y - mouseY;
				}
			}
			autotile();
		}
		
		public function autotile():void
		{
			var i:int = mapH-1;
			while (i-->1)
			{
				var j:int = mapW-1;
				while (j-->1)
				{
					var g:int = idVector[i][j];
					var l:Boolean, r:Boolean, u:Boolean, d:Boolean;
					l = (idVector[i][j - 1] != g);
					r = (idVector[i][j + 1] != g);
					u = (idVector[i - 1][j] != g);
					d = (idVector[i + 1][j] != g);
					var idx:int = (l?8:0) | (r?4:0) | (u?2:0) | int(d);
					tm.data[i][j] = mYaml.autotileSettings[idVector[i][j]].autotiles[idx];
				}
			}
		}
		
		private function updatedisplay():void
		{
			
		}
		
		private function mupf(e:MouseEvent):void 
		{
			if(display.mouseX + display.cameraX < 0||
			display.mouseY + display.cameraY < 0||
			display.mouseX + display.cameraX > tilesize * mapW||
			display.mouseY + display.cameraY > tilesize * mapH)
			return;
			editing = false;
			frame.visible = false;
			switch(tools.mode)
			{
				case TMToolPanel.NORMAL:
					
				break;
				case TMToolPanel.RECT:
					secondPoint.x = display.mouseX + display.cameraX;
					secondPoint.y = display.mouseY + display.cameraY;
					var left:int = Math.min(firstPoint.x, secondPoint.x)/tilesize;
					var right:int = Math.max(firstPoint.x, secondPoint.x)/tilesize;
					var up:int = Math.min(firstPoint.y, secondPoint.y)/tilesize;
					var down:int = Math.max(firstPoint.y, secondPoint.y)/tilesize;
					var i:int = right+1;
					while (i-->left)
					{
						var j:int = down+1;
						while (j-->up)
						{
							idVector[j][i] = pallette.currIndex;
						}
					}
				break;
			}
			autotile();
		}
		
		private function mdownf(e:MouseEvent):void 
		{
			if(display.mouseX + display.cameraX < 0||
			display.mouseY + display.cameraY < 0||
			display.mouseX + display.cameraX > tilesize * mapW||
			display.mouseY + display.cameraY > tilesize * mapH)
			return;
			editing = true;
			if (editing)
			{
				switch(tools.mode)
				{
					case TMToolPanel.NORMAL:
						var wx:int = display.mouseX + display.cameraX;
						var wy:int = display.mouseY + display.cameraY;
						idVector[int(wy / tilesize)][int(wx / tilesize)] = pallette.currIndex;
					break;
					
					case TMToolPanel.RECT:
						firstPoint.x = display.mouseX + display.cameraX;
						firstPoint.y = display.mouseY + display.cameraY;
					break;
					
					case TMToolPanel.DRAG:
						savePoint.x = mouseX + display.cameraX;
						savePoint.y = mouseY + display.cameraY;
					break;
				}
			}
			autotile();
		}
		
		private function generateScaledSheet(factor:Number):void
		{
			display.clear();
			var ret:BitmapData = new BitmapData(factor * mainSheet.width, factor * mainSheet.height);
			ret.draw(mainSheet, new Matrix(factor, 0, 0, factor));
			tm.graphics = ret;
			tm.tileH = mainTilesize * factor;
			tm.tileW = mainTilesize * factor;
			tm.tempRect.width = tm.tempRect.height = mainTilesize * factor;
			tilesize = mainTilesize * factor;
			var wx:int = display.mouseX + display.cameraX;
			var wy:int = display.mouseY + display.cameraY;
			display.cameraX = wx * (factor/lastMajor) - display.mouseX;
			display.cameraY = wy * (factor / lastMajor) - display.mouseY;
			tm.padding = factor;
		}
		
		private function update(e:Event):void 
		{
			tm.render(display);
		}
		
		override public function unload():void 
		{
			pallette.unload();
			removeEventListener(Event.ENTER_FRAME, update);
			super.unload();
		}
		
		override protected function addListeners(e:Event):void 
		{
			addEventListener(MouseEvent.MOUSE_DOWN, setCurr);
			super.addListeners(e);
		}
		
		private function setCurr(e:MouseEvent):void 
		{
			MapEditor.currMap = this;
		}
		
	}

}