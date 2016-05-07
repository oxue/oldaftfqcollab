package sfbl.toolkit 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class SplashNotice extends Panel 
	{
		private var text:TextField;
		
		public function SplashNotice() 
		{
			super("!", 200, 100);
			text = new TextField();
			text.defaultTextFormat = Panel.textFormat;
			addChild(text);
			with (text)
			{	x = y = 20;
				scaleX = scaleY = 2;
				filters = [Panel.glowFilter];
			}
			visible = false;
		}
		
		public function show(msg:String):void
		{
			text.text = msg;
			visible = true;
		}
		
	}

}