package sfbl.toolkit 
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MiniApp extends Panel 
	{	
		public function MiniApp(_label:String = "default", sizeW:int = 200, sizeH:int = 100) 
		{
			super(_label, sizeW, sizeH);
			lockDepth = true;
		}
		
		public static function init():void
		{
			Panel.textFormat = new TextFormat("courier new", 12, 0xffffff);
			Panel.dropFilter = new DropShadowFilter(5, 45, 0XFFFFFF, 1, 6, 6, 0.5);
			Panel.glowFilter = new GlowFilter(0xff0000,1,6,6,2);
		}
		
	}

}