package libTF.utils;
import tFramework.render.PixMap;
import tFramework.render.Pixie;

/**
 * ...
 * @author 
 */

class BitmapUtils 
{

	private function new() 
	{
		
	}
	
	public static function trimBitmap(map:PixMap, rect:IntRect = null, col:UInt = 0xFF00FF, col2:UInt = 0xFF01FF, col3:UInt = 0xFF02FF):Pixie
	{
		var r:IntRect;
		if (rect == null) { r = new IntRect(map.width, map.height, 0, 0); }
		else 
		{
			rect = rect.clone().intersection(IntRect.fromRect(map.rect));
			r = new IntRect(rect.x + rect.width, rect.y + rect.height, 0, 0); 
		}
		
		var i:Int = rect.x;
		var j:Int = rect.y;
		
		var trimmed:Bool = false;
		
		while (i < rect.x + rect.width)
		{
			j = rect.y;
			while (j < rect.y + rect.height)
			{
				if (map.getPixel(i, j) == col)
				{
					if (i == rect.x && map.getPixel(i, j + 1) != col && map.getPixel(i, j - 1) != col) { r.x = rect.x; }
					if (j == rect.y && map.getPixel(i + 1, j) != col && map.getPixel(i - 1, j) != col) { r.y = rect.y; }
					if (i == rect.x + rect.width - 1 && map.getPixel(i, j + 1) != col && map.getPixel(i, j - 1) != col) { r.width = rect.width - r.x + rect.x; }
					if (j == rect.y + rect.height - 1 && map.getPixel(i + 1, j) != col && map.getPixel(i - 1, j) != col) { r.height = rect.height - r.y + rect.y; }
					r.x = MathUtils.imin(r.x, i+1);
					r.y = MathUtils.imin(r.y, j+1);
					r.width = MathUtils.imax(r.width, i - r.x);
					r.height = MathUtils.imax(r.height, j - r.y);
					trimmed = true;
				}
				else if (map.getPixel(i, j) == col2)
				{
					if (map.getPixel(i + 1, j) == col2 || map.getPixel(i - 1, j) == col2)
					{
						r.x = rect.x;
						r.width = rect.width;
						r.y = j + 1;
						r.height = rect.height - r.y + rect.y;
					}
					else if ( map.getPixel(i, j + 1) == col2 || map.getPixel(i, j - 1) == col2)
					{
						r.x = i + 1;
						r.width = rect.width - r.x + rect.x;
						r.y = rect.y;
						r.height = rect.height;
					}
					trimmed = true;
					i = rect.x + rect.width;
					break;
				}
				else if (map.getPixel(i, j) == col3)
				{
					if (map.getPixel(i + 1, j) == col3 || map.getPixel(i - 1, j) == col3)
					{
						r.x = rect.x;
						r.width = rect.width;
						r.y = rect.y;
						r.height = j - 1 + rect.y;
					}
					else if ( map.getPixel(i, j + 1) == col3 || map.getPixel(i, j - 1) == col3)
					{
						r.x = rect.x;
						r.width = i - 1 + rect.x;
						r.y = rect.y;
						r.height = rect.height;
					}
					trimmed = true;
					i = rect.x + rect.width;
					break;
				}
				j++;
			}
			i++;
		}
		
		if (!trimmed) { r = rect.clone(); }
		return (new Pixie(map, r));
	}
	
}