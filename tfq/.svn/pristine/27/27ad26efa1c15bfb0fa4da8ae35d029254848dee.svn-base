package sfbl 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import sfbl.GfxSprite;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class Tilemap implements IGfx 
	{
		[Embed(source = 'data/tiles.png')]
		private static const DEFAULT_GRAPHICS:Class;
		
		public var padding:Number;
		
		public var graphics:BitmapData;
		
		public var tileW:int;
		public var tileH:int;
		
		public var mapW:int;
		public var mapH:int;
		
		private var sheetGridW:int;
		private var sheetGridH:int;
		
		public var data:Vector.<Vector.<int>>;
		
		public var colIndex:int;
		
		private var dataTable:Vector.<int>;
		
		public var tempRect:Rectangle;
		private var tempPoint:Point;
		
		public function Tilemap(_data:Vector.<Vector.<int>>, _tileW:int = 16, _tileH:int = 16, _graphics:BitmapData = null, _padding:int = 1) 
		{
			data = _data;
			
			mapW = data[0].length;
			mapH = data.length;
			
			tileW = _tileW;
			tileH = _tileH;	
			
			padding = _padding
			
			if (!_graphics)
			{
				graphics = Bitmap(new DEFAULT_GRAPHICS()).bitmapData;
				tileH = tileW = 16;
			}else
			graphics = _graphics;
			
			sheetGridW = int((graphics.width + padding) / (_tileW+padding));
			sheetGridH = int((graphics.height + padding) / (_tileH+padding));
			
			tempRect = new Rectangle(0, 0, tileW, tileH);
			tempPoint = new Point();
			
			colIndex = 1;
			
			trace(sheetGridW);
			trace(tileW);
			trace(tileH);
			trace(padding);
		}
		
		public function render(_dp:DisplayPort):void
		{
			var left:int = Math.floor(_dp.cameraX / tileW);
			var right:int = Math.ceil((_dp.cameraX + _dp.width) / tileW) + 1;
			var up:int = Math.floor(_dp.cameraY / tileH);
			var down:int = Math.ceil((_dp.cameraY + _dp.height) / tileH) + 1;
			if (right > mapW)
			right = mapW;
			if (left < 0)
			left = 0;
			if (down > mapH)
			down = mapH;
			if (up < 0)
			up = 0;
			var i:int = down;
			while (i-->up)
			{
				var j:int = right;
				while (j-->left)
				{
					tempRect.x = (data[i][j] % sheetGridW)*(tileW+padding);
					tempRect.y = int(data[i][j] / sheetGridW)*(tileH+padding);
					tempPoint.x = j * tileW - _dp.cameraX;
					tempPoint.y = i * tileH - _dp.cameraY;
					_dp.data.copyPixels(graphics,tempRect,tempPoint,null,null,false)
				}
			}
			trace(data[1][1]);
		}
		
		public function autotile():void
		{
			var newMap:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(mapH, true);
			var i:int = mapH;
			while (i--)
			{
				newMap[i] = new Vector.<int>(mapW, true);
			}
			
			i = mapH - 1;
			while (i-- > 1)
			{
				var j:int = mapW - 1;
				while (j-->1)
				{
					if (data[i][j] == 0)
					continue;
					var left:int=0, right:int=0, up:int=0, down:int = 0;
					if(data[i][j - 1] != data[i][j])
					left = 1;
					if(data[i][j + 1] != data[i][j])
					right = 1;
					if(data[i-1][j] != data[i][j])
					up = 1;
					if(data[i+1][j] != data[i][j])
					down = 1;
					trace(index);
					var index:int = left + (right << 1) + (up << 2) + (down << 3);
					newMap[i][j] = index + 1;
					//newMap[i][j] = 5;
				}
			}
			data = newMap;
		}
		
		public static function from(_data:Array):Vector.<Vector.<int>>
		{
			var i:int = _data.length;
			var ret:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(i, true);
			while (i--)
			{
				ret[i] = new Vector.<int>(_data[i].length, true);
				var j:int = _data[i].length;
				while (j--)
				{
					ret[i][j] = _data[i][j];
				}
			}
			return ret;
		}
	}

}