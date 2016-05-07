package sfbl.toolkit 
{
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class URLLoadHelper 
	{
		public var data:String;
		public var callback:Function;
		public var loader:URLLoader;
		
		public function URLLoadHelper() 
		{
			loader = new URLLoader();
		}
		
		public function startURLloadProcedures(_url:String, _callback:Function):void
		{
			callback = _callback;
			loader.addEventListener(Event.COMPLETE, done);
			loader.load(new URLRequest(_url));
		}
		
		private function done(e:Event):void 
		{
			loader.removeEventListener(Event.COMPLETE, done);
			data = loader.data;
			callback();
		}
	}

}