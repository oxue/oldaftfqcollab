package sfbl.mpedtr 
{
	import sfbl.toolkit.Button;
	import sfbl.toolkit.Panel;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TMToolPanel extends Panel 
	{
		private var rectButton:Button;
		private var normalButton:Button;
		private var dragButton:Button;
		
		public var mode:int;
		public static const NORMAL:int = 0;
		public static const RECT:int = 1;
		public static const DRAG:int = 2;
		
		public function TMToolPanel() 
		{
			super("Tools", 110, 200);
			
			rectButton = new Button("Rectangle", 60, 20, rectf);
			normalButton = new Button("Normal", 60, 20, normalf);
			dragButton = new Button("Drag", 60, 20, dragf);
			normalButton.x = 25;
			normalButton.y = 25;
			rectButton.x = 25;
			rectButton.y = 45;
			dragButton.x = 25;
			dragButton.y = 65;
			
			addPanel(rectButton);
			addPanel(normalButton);
			addPanel(dragButton);
		}
		
		private function dragf():void 
		{
			mode = DRAG;
		}
		
		private function normalf():void 
		{
			mode = NORMAL;
		}
		
		private function rectf():void 
		{
			mode = RECT;
		}
		
	}

}