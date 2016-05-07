package modules;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import game.assets.Logo;
import tFramework.core.modules.Module;
import tFramework.render.PixMap;
import tFramework.render.RenderContext; 
import tFramework.core.KeyManager;
import flash.ui.Keyboard;

/**
 * ...
 * @author TF
 */

class MainMenuModule extends Module
{

	var unit:PixMap;
	
	public function new() 
	{
		super();
		var b:BitmapData = new Logo();
		unit = new PixMap(b.width, b.height);
		unit.copyPixels(b, b.rect, new Point(0, 0));
	}
	
	override public function render(map:PixMap, context:RenderContext):Void 
	{
		unit.render(map, context);
	}
	
	override public function update():Void 
	{
		if (KeyManager.isPressed(Keyboard.SPACE))
		{
			Core.setState("GAME");
		}
	}
	
}