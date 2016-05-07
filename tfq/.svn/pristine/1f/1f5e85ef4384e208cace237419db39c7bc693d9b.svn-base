package sfbl 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import sfbl.sys.Tracker;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class GfxSprite implements IGfx
	{
		[Embed(source='data/logo.png')]
		private static const DEFAULT_GRAPHICS:Class;
		
		private var graphics:BitmapData;
		
		public var x:Number;
		public var y:Number;
		
		public var originX:int;
		public var originY:int;
		
		public var width:int;
		public var height:int;
		
		public var scaleX:int;
		public var scaleY:int;
		
		public var rotation:Number;
		
		public var animated:Boolean;
		public var curTime:int;
		public var frameTime:int;
		public var curFrame:int;
		public var curAnimation:int;
		public var gridX:int;
		public var gridY:int;
		public var animations:Vector.<Vector.<int>>;
		
		public function GfxSprite(_x:int = 0, _y:int = 0, _graphics:BitmapData = null) 
		{
			x = _x;
			y = _y;
			_graphics = getDefaultGfx();
			graphics = _graphics;
			
			width = graphics.width;
			height = graphics.height;
			
			rotation = 0;
			scaleX = scaleY = 1;
			originX = width >> 1;
			originY = height >> 1;
		}
		
		public function render(_dp:DisplayPort):void
		{
			if (!rotation && scaleX == 1 && scaleY == 1)
			{
				_dp.tempPoint.x = this.x -_dp.cameraX - originX;
				_dp.tempPoint.y = this.y -_dp.cameraY - originY;
				if (animated)
				{
					curTime++;
					if (curTime >= frameTime)
					{	curTime = 0;
						curFrame++;
						if (curFrame >= animations[curAnimation].length)
						{
							curFrame = 0;
						}
					}
					var fNum:int = animations[curAnimation][curFrame];
					_dp.tempRect.x = fNum % gridX * width;
					_dp.tempRect.y = int(fNum / gridX) * height;
					_dp.tempRect.width = width;
					_dp.tempRect.height = height;
					_dp.data.copyPixels(graphics, _dp.tempRect, _dp.tempPoint, null, null, true);
					return;
				}
				_dp.data.copyPixels(graphics, graphics.rect, _dp.tempPoint, null, null, true);
			}else
			{
				_dp.tempMatrix.translate(-originX, -originY);
				_dp.tempMatrix.scale(scaleX, scaleY);
				_dp.tempMatrix.rotate(rotation / 180 * 3.1415926);
				_dp.tempMatrix.translate(this.x -_dp.cameraX - originX - originX, this.y -_dp.cameraY - originY - originY);
				_dp.data.draw(graphics, _dp.tempMatrix, null);
				_dp.tempMatrix.identity();
			}
		}
		
		public function setAsAnimated(_width:int, _height:int, _frameTime:int):void
		{
			animated = true;
			frameTime = _frameTime;
			width = _width;
			height = _height;
			gridX = int(graphics.width / width);
			gridY = int(graphics.height / height);
			animations = new Vector.<Vector.<int>>();
		}
		
		public function addAnimation(_frames:Array):int
		{
			var v:Vector.<int> = new Vector.<int>(_frames.length, true);
			animations.push(v);
			var i:int = _frames.length;
			while (i--)
			v[i] = _frames[i];
			return animations.length - 1;
		}
		
		public function bake(rots:int = 32):void
		{
			if (!animated)
			{
				var newData:BitmapData = new BitmapData(int(width * 1.42 + 0.5) * rots, int(height * 1.42 + 0.5));
				var i:int = 32;
				while (i--)
				{
					
				}
			}
		}
		
		public static var defaultGfxInstance:BitmapData;
		
		public static function getDefaultGfx():BitmapData
		{
			if (!defaultGfxInstance)
				defaultGfxInstance = Bitmap(new DEFAULT_GRAPHICS()).bitmapData;
			return defaultGfxInstance;
		}
		
	}

}