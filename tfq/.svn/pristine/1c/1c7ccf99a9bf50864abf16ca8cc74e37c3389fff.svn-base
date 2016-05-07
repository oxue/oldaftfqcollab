package sfbl.mpedtr 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import sfbl.toolkit.Button;
	import sfbl.toolkit.InputForm;
	/**
	 * ...
	 * @author WorldEdit
	 */
	public class TMQuickCode extends InputForm 
	{
		private var newButton:Button;
		private var saveButton:Button;
		private var openButton:Button;
		private var closeButton:Button;
		private var saved:Boolean;
		private var fileref:FileReference;
		
		public function TMQuickCode() 
		{
			super("C>", 800, 20);
			this.itext.height = 300;
			backGround.height = 300;
			backGround.visible = true;
			itext.multiline = true;
			
			newButton = new Button("!n", 20, 20, newf);
			newButton.y = 40;
			addPanel(newButton);
			
			saveButton = new Button("<s", 20, 20, savef);
			saveButton.y = 60;
			addPanel(saveButton);
			
			openButton = new Button(">o", 20, 20, openf);
			openButton.y = 80;
			addPanel(openButton);
			
			closeButton = new Button("~x" , 20, 20, closef);
			closeButton.y = 200;
			addPanel(closeButton);
			
			itext.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, TextKeyFocusChange);
			
			fileref = new FileReference();
		}
		
		private function TextKeyFocusChange(e:FocusEvent):void
		{
			e.preventDefault();         
			var txt:TextField = TextField(e.currentTarget);
			txt.replaceText(txt.caretIndex, txt.caretIndex, "\t");
			txt.setSelection(txt.caretIndex + 1, txt.caretIndex + 1);
		}
		
		private function closef():void 
		{
			unload();
		}
		
		private function newf():void 
		{
			itext.text = '';
		}
		
		private function openf():void 
		{
			fileref.addEventListener(Event.SELECT, loadf);
			fileref.browse();
		}
		
		private function loadf(e:Event):void 
		{
			fileref.removeEventListener(Event.SELECT, loadf);
			fileref.addEventListener(Event.COMPLETE, completef);
			fileref.load();
		}
		
		private function completef(e:Event):void 
		{
			fileref.removeEventListener(Event.COMPLETE, completef);
			itext.text = fileref.data.readUTFBytes(fileref.data.length);
		}
		
		private function savef():void 
		{
			fileref.save(itext.text);
		}
		
	}

}