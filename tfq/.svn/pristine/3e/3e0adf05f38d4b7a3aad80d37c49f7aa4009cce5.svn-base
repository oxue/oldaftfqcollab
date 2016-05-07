package sfbl.toolkit 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class Button extends Panel 
	{
		public var down:Boolean = true;
		private var callback:Function;
		
		public function Button(_label:String="default", sizeW:int=60, sizeH:int=20,_callback:Function = null) 
		{
			callback = _callback;
			super(_label, sizeW, sizeH);
		}
		
		override protected function addListeners(e:Event):void 
		{
			backGround.addEventListener(MouseEvent.MOUSE_OUT, deglow);
			backGround.addEventListener(MouseEvent.MOUSE_OVER, glow)
			super.addListeners(e);
		}
		
		private function glow(e:MouseEvent):void 
		{
			backGround.alpha = 0.1;
		}
		
		private function deglow(e:MouseEvent):void 
		{
			backGround.alpha = 0.8;
		}
		
		override protected function downHandler(e:MouseEvent):void 
		{
			down = true;
			backGround.alpha = 0.8;
			if (callback != null)
			callback();
		}
		
		override protected function upHandler(e:MouseEvent):void 
		{
			down = false;
			backGround.alpha = 0.8;
		}
		
	}

}