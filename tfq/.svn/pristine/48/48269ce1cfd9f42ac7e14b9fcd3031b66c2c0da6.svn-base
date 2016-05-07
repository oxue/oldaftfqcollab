package sfbl.mpedtr 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import sfbl.toolkit.Panel;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TMTilePallette extends Panel 
	{
		private var tilesize:int;
		private var hilite:Shape;
		private var bitmap:Bitmap;
		private var container:Sprite;
		public var currIndex:int;
		private var mYaml:Object
		
		public var memObj:Object;
		
		public function TMTilePallette(_graphic:BitmapData,_tilesize:int,_yaml:Object) 
		{
			tilesize = _tilesize;
			
			//constructing a pallete according to the yaml obj first
			mYaml = _yaml;
			var palW:int = 4 * tilesize;
			var palH:int = (int(mYaml.length / 4)+1) * tilesize
			super("Pallette", palW + 50, palH + 50);
			
			var palleteData:BitmapData = new BitmapData(palW, palH,true, 0);
			
			var temprect:Rectangle = new Rectangle(0, 0, tilesize, tilesize);
			var temppoint:Point = new Point();
			
			memObj = new Object();
			
			var i:int = mYaml.autotileSettings.length;
			while (i--)
			{
				temprect.x = (mYaml.autotileSettings[i].main % ((_graphic.width) / (tilesize + mYaml.padding))) * (tilesize + mYaml.padding);
				temprect.y = int(mYaml.autotileSettings[i].main / ((_graphic.width) / (tilesize + mYaml.padding))) * (tilesize + mYaml.padding);
				trace(temprect.x,temprect.y);
				temppoint.x = (i % 4) * tilesize;
				temppoint.y = int(i / 4) * tilesize;
				palleteData.copyPixels(_graphic, temprect, temppoint);
				memObj[i] = mYaml.autotileSettings[i].id;
			}
			bitmap = new Bitmap(palleteData);
			
			hilite = new Shape();
			hilite.graphics.lineStyle(1, 0xff0000);
			hilite.graphics.drawRect(0, 0, _tilesize, _tilesize);
			
			hilite.x = 25;
			hilite.y = 25;
			hilite.filters = [Panel.glowFilter];
			
			container = new Sprite();
			container.addChild(bitmap);
			addChild(container);
			container.x = 25;
			container.y = 25;
			addChild(hilite);
			
			container.addEventListener(MouseEvent.MOUSE_DOWN, select);
		}
		
		private function select(e:MouseEvent):void 
		{
			var gx:int = int(bitmap.mouseX / tilesize);
			var gy:int = int(bitmap.mouseY / tilesize);
			
			hilite.x = gx * tilesize + 25;
			hilite.y = gy * tilesize + 25;
			
			currIndex = memObj[gy * int(bitmap.width / tilesize) + gx];
	   	}
		
	}

}