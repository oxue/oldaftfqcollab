package sfbl.toolkit 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 
	 */
	public class DropMenu extends Button 
	{
		private var shown:Boolean;
		
		public function DropMenu(_label:String = "default", _sizeW:int = 60) 
		{
			super(_label, _sizeW, 20, showMenu);
		}
		
		public function addButton(_button:Button):void
		{
			_button.visible = false;
			_button.y = panels.length * 20 + 20;
			addPanel(_button);
		}
		
		override protected function addListeners(e:Event):void 
		{
			addEventListener(MouseEvent.ROLL_OUT,hideMenu);
			super.addListeners(e);
		}
		
		private function hideMenu(e:MouseEvent):void 
		{
			shown = false;
			var i:int = panels.length;
			while (i--)
			{
				panels[i].visible = false;
			}
		}
		
		private function showMenu():void 
		{
			shown = true;
			var i:int = panels.length;
			while (i--)
			{
				panels[i].visible = true;
			}
		}
		
	}

}