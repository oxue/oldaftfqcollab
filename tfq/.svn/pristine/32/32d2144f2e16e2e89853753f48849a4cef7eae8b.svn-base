package sfbl 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class DisplayPort extends Sprite implements IUpdated
	{
		private var map:Bitmap;
		public var data:BitmapData;
		
		private var bgColor:int;
		private var zoom:int;
		private var resX:int;
		private var resY:int;
		
		public var cameraX:int;
		public var cameraY:int;
		
		public var tempPoint:Point;
		public var tempMatrix:Matrix;
		public var tempRect:Rectangle;
		
		public var followTarget:GfxSprite;
		
		public function DisplayPort(_resX:int = 400, _resY:int = 300, _zoom:int = 2, _bgColor:int = 0xffffffff) 
		{
			resX = _resX;
			resY = _resY;
			zoom = _zoom;
			bgColor = _bgColor;
			data = new BitmapData(resX, resY, true, bgColor);
			map = new Bitmap(data);
			map.scaleX = map.scaleY = zoom;
			addChild(map);
			tempPoint = new Point();
			tempMatrix = new Matrix();
			tempRect = new Rectangle();
		}
		
		public function follow(_o:GfxSprite):void
		{
			followTarget = _o;
		}
		
		public function update():void
		{
			if (!followTarget)
			return;
			cameraX = followTarget.x - width / 4;
			cameraY = followTarget.y - height / 4;
		}
		
		public function clear():void
		{
			data.fillRect(data.rect, bgColor);
		}
	}

}