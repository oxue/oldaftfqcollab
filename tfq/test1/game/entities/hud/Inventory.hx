package game.entities.hud;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.Vector;
import game.assets.Items;
import game.entities.Item;
import tFramework.core.KeyManager;
import tFramework.core.units.Unit;
import tFramework.render.PixMap;
import tFramework.render.RenderContext;

/**
 * ...
 * @author qwerber
 */

class Inventory implements Unit
{
	private var numWidth:Int;
	private var numHeight:Int;
	private var itemWidth:Int;
	private var itemHeight:Int;
	private var gap:Int;
	private var scrollY:Float;
	private var baseGraphic:BitmapData;
	private var tempPoint:Point;

	public var x:Float;
	public var y:Float;

	public var items:Vector<Item>;
	
	public var lastKeyE:Bool;
	
	private var shown:Bool;
	
	public function new() 
	{
		numWidth = 10;
		numHeight = 1;
		itemHeight = 16;
		itemWidth = 16;
		gap = 5;
		
		baseGraphic = new BitmapData(itemWidth, itemHeight, true, 0x44000000);
		
		scrollY = - numHeight * itemHeight + (numHeight - 1) * gap - gap;
		tempPoint = new Point();
		
		items = new Vector<Item>();
		
		lastKeyE = false;
	}
	
	public function render(map:PixMap, context:RenderContext):Void
	{
		var i:Int = numWidth;
		while (i-->0)
		{
			var j:Int = numHeight;
			while (j-->0)
			{
				tempPoint.x = i * (itemWidth + gap) + gap;
				tempPoint.y = j * (itemHeight + gap) + gap + scrollY;
				map.copyPixels(baseGraphic, baseGraphic.rect, tempPoint, null, null, true);
			}
		}
		i = items.length;
		
		while (i-->0)
		{
			tempPoint.x = items[i].x+gap;
			tempPoint.y = items[i].y + scrollY+gap;
			map.copyPixels(items[i].image, items[i].image.rect, tempPoint, null, null, true);
		}
	}
	
	public function addItem(_item:Item):Void
	{
		//trace(items.length);
		//trace(numHeight);
		//trace(gap);
		//trace(itemWidth);
		_item.x = items.length % numWidth * (gap + itemWidth);
		_item.y = Std.int(items.length/numWidth) * (gap + itemHeight);
		items.push(_item);
		//trace(_item.x);
	}
	
	public function update()
	{
		if (!lastKeyE && KeyManager.isPressedStr("E"))
		{
			shown = !shown;
		}
		lastKeyE = KeyManager.isPressedStr("E");
		
		if (shown)
		scrollY += -scrollY * 0.2;
		else
		scrollY += (( - numHeight * itemHeight + (numHeight - 1) * gap - gap) - scrollY) * 0.2;
	}
	
}