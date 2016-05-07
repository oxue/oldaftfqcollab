package sfbl.toolkit 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mx.core.ButtonAsset;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Panel extends Sprite 
	{
		protected var backGround:Sprite;
		private var label:TextField;
		private var quit:Boolean;
		protected var bgColor:int = 0x555555;
		
		public static var textFormat:TextFormat;
		public static var dropFilter:DropShadowFilter;
		public static var glowFilter:GlowFilter;
		public var lockDepth:Boolean = false;
		
		public var panels:Vector.<Panel>;
		
		public function Panel(_label:String = "default", sizeW:int = 200, sizeH:int = 100, quit:Boolean = false) 
		{
			backGround = new Sprite();
			backGround.graphics.beginFill(bgColor,1);
			backGround.graphics.drawRect(0, 0, 100, 100);
			
			backGround.width = sizeW;
			backGround.height = sizeH;
			
			label = new TextField();
			label.defaultTextFormat = Panel.textFormat;
			label.text = _label;
			label.width = sizeW;
			label.height = sizeH;
			
			addChild(backGround);
			addChild(label);
			
			panels = new Vector.<Panel>();
			
			label.mouseEnabled = false;
			label.selectable = false;
			
			label.filters = [Panel.glowFilter];
			
			if (quit)
			{
				var qb:Button = new Button(" X", 20, 20, unload);
				qb.x = width - 20;
				addPanel(qb);
			}

			backGround.alpha = 0.8;
			
			addEventListener(Event.ADDED_TO_STAGE, addListeners);
		}
		
		protected function addListeners(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addListeners);
			backGround.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			backGround.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		public function addPanel(_panel:Panel):Panel
		{
			addChild(_panel);
			panels.push(_panel);
			return _panel;
		}
		
		protected function upHandler(e:MouseEvent):void 
		{
			stopDrag();
		}
		
		protected function downHandler(e:MouseEvent):void 
		{
			startDrag(false);
			if (lockDepth)
			return;
		}
		
		public function unload():void
		{
			backGround.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			backGround.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			var i:int = panels.length;
			while (i--)
			{
				panels[i].unload();
			}
			i = Panel(parent).panels.length;
			while (i--)
			{
				if (Panel(parent).panels[i] == this)
				{
					Panel(parent).panels[i] = Panel(parent).panels[Panel(parent).panels.length - 1];
					Panel(parent).panels.length--;
					break;
				}
			}
			parent.removeChild(this);
		}
		
	}

}