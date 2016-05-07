package sfbl.toolkit 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class LoaderHelper 
	{
		public var data:DisplayObject;
		public var loader:Loader;
		public var callback:Function;
		
		public function LoaderHelper() 
		{
			loader = new Loader();
		}
		
		public function startLoadingProcedures(_url:String, _callback:Function):void
		{
			callback = _callback;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, donef);
			loader.load(new URLRequest(_url));
		}
		
		private function donef(e:Event):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, donef);
			data = loader.content;
			callback();
		}
		
	}

}