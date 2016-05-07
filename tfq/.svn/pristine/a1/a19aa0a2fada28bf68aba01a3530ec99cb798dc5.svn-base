package editor;

import flash.display.BitmapData;
import flash.utils.ByteArray;

class ByteImage
{
	public var data:String;
	public var width:Int;
	public var height:Int;

	public function new(_bitmap:BitmapData = null)
	{
		if(_bitmap == null)
		{
			return;
		}
		width = _bitmap.width;
		height = _bitmap.height;
		var b:ByteArray = _bitmap.getPixels(_bitmap.rect);
		data = '';
		var i:Int = -1;
		while(i++<b.length-1)
		{
			data+=String.fromCharCode(b[i]);
		}
	}

	public function decode():BitmapData
	{
		var ret:BitmapData = new BitmapData(width,height);
		var b:ByteArray = new ByteArray();
		b.length = width*height*4;
		var i:Int = -1;
		while(i++<data.length-1)
		{
			b.writeByte(data.charCodeAt(i));
		}
		b.position = 0;
		ret.setPixels(ret.rect,b);
		return ret;
	}
}