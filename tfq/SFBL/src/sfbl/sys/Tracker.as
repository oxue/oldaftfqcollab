package sfbl.sys 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class Tracker extends Sprite 
	{
		//object ref  ..  var name  ..  label  ..  text
		private static var table:Array;
		private static var tf:TextFormat;
		private static var tracker:Tracker;
		
		public function Tracker() 
		{
			graphics.beginFill(0,0.5);
			graphics.drawRect(0, 0, 400, 300);
		}
		
		public static function getInstance():Tracker
		{
			if (!tracker)
			{
				init();
				tracker = new Tracker();
			}
			return tracker;
		}
		
		public static function init():void
		{
			table = new Array();
			tf = new TextFormat('lucida console', 12 , 0xffffff);
		}
		
		public static function addValue(_object:Object, _varName:String, _label:String):void
		{
			var t:TextField = new TextField();
			t.defaultTextFormat = tf;
			t.y = 20 * table.length;
			tracker.addChild(t);
			table[table.length] = [_object, _varName, _label,t];
		}
		
		public static function update():void
		{
			var i:int = table.length;
			while (i--)
			{
				table[i][3].text = table[i][2] + " : " + String(table[i][0][table[i][1]]);
			}
		}
	}

}