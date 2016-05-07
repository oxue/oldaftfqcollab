package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import sfbl.DisplayPort;
	import sfbl.GfxSprite;
	import sfbl.sys.Tracker;
	import sfbl.TileEntity;
	import sfbl.Tilemap;
	import sfbl.toolkit.MapEditor;
	import sfbl.toolkit.MiniApp;
	
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class Main extends Sprite 
	{
		private var gr:int;
		private var g:TileEntity;
		private var tm:Tilemap;
		private var jumpb:Boolean;
		private var map:Array = 
		[
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ,1 ,1 ,1 ,1], 
		[1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1 ,1 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ,0 ,0 ,1 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1 ,1 ,0 ,0 ,1], 
		[1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1 ,0 ,0 ,1 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 ,1 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 ,0 ,0 ,0 ,1],
		[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 ,0 ,0 ,0 ,1],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ,1 ,1 ,1 ,1]];
		                                                          
		
		private var map2:Array = 
		[
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1, 1 ,1 ,1 ,1 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,1, 0, 0, 0,1, 0, 0, 0,1, 0, 0, 0,1, 0, 0, 0,1, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1, 1, 1, 0, 0 ,1], 
		[1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1,0, 0, 0, 1, 1, 1, 0, 0 ,1], 
		[1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0,0, 0, 0, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 0, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1, 0 ,0 ,0 ,0 ,1], 
		[1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1, 0 ,0 ,0 ,0 ,1],
		[1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1, 0 ,0 ,0 ,0 ,1],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1,1, 1, 1, 1, 1 ,1 ,1 ,1 ,1]];
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			g = new TileEntity(32,32);
			//g.rotation = 45;
			//g.scaleX = 2;
			//g.setAsAnimated(16, 16, 10);
			//g.addAnimation([0, 1, 2, 3]);
			g.render(DisplayPort(addChildAt(new DisplayPort(400, 300, 2, 0xffffffff), 0)));
			var ma:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(100, true);
			var i:int = 100;
			while (i--)
			{
				ma[i] = new <int>[0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0];
			}
			var ve:Vector.<Vector.<int>> = Tilemap.from(map2);
			tm = new Tilemap(ve);
			tm.render(DisplayPort(getChildAt(0)));
			
			DisplayPort(getChildAt(0)).follow(g);
			
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(MouseEvent.MOUSE_DOWN, jump);
			gr = 1.5;
			MiniApp.init();
			
			addChild(new MapEditor())
		}
		
		private function jump(e:MouseEvent):void 
		{
			/*if (gr == 5)
			gr = -5;
			else
			gr = 5;*/
			jumpb = true;
		}
		
		private function update(e:Event):void 
		{
			g.velX = 0;
			DisplayPort(getChildAt(0)).clear();
			if (mouseX / 2 + DisplayPort(getChildAt(0)).cameraX > g.x + 20)
			g.velX  +=5;
			else if (mouseX / 2 + DisplayPort(getChildAt(0)).cameraX < g.x - 20)
			g.velX  -= 5;
			if (g.velX > 5)
			g.velX = 5;
			if (g.velX < -5)
			g.velX = -5;
			//else
			//if (mouseX / 2 + DisplayPort(getChildAt(0)).cameraX < g.x+5 && mouseX / 2 + DisplayPort(getChildAt(0)).cameraX > g.x-5)
			//g.velX = mouseX / 2 + DisplayPort(getChildAt(0)).cameraX - g.x;
			/*if (mouseY / 2 - mouseY/2 %2  > g.y)
			if (mouseY / 2 - mouseY/2 %2 < g.y)
			g.velY = -1;*/
			//g.velX = mouseX / 2 - g.x;
			//g.velY = mouseY / 2 - g.y;
			if (jumpb && g.resting)
			{
				g.resting = false;
				g.velY = -15;
			}
			jumpb = false;
			g.velY += gr;
			//g.x = mouseX / 2;
			//g.y = mouseY / 2;
			//trace("before", g.velY);
			g.update();
			//var t:int = getTimer();
			g.solveMap(tm);
			//trace(getTimer() - t);
			DisplayPort(getChildAt(0)).update();
			tm.render(DisplayPort(getChildAt(0)));
			g.render(DisplayPort(getChildAt(0)));
			//DisplayPort(getChildAt(0)).cameraX -=1;
		}
		
	}
	
}