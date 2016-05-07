package sfbl.mpedtr 
{
	import flash.display.Sprite;
	import sfbl.toolkit.MiniApp;
	import sfbl.toolkit.SplashNotice;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MapEditor extends MiniApp 
	{
		private var topBar:TMTopBar;
		public static var currMap:TMEditPanel;
		public var spl:SplashNotice;
		
		public function MapEditor() 
		{
			super("Tilemap Editor", 400, 300);
			topBar = new TMTopBar();
			addChild(topBar);
			topBar.y = 20;
			
			spl =  new SplashNotice();
			addChild(spl);
			with (spl) 
				x = y = 100;
		}
		
	}

}