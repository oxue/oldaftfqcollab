package sfbl.toolkit 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class InputForm extends Panel 
	{
		public var itext:TextField;
		
		public function InputForm(_label:String = "default : ", sizeW:int = 200, formX:int = 100) 
		{
			super(_label, sizeW, 20, false);
			
			itext = new TextField();
			itext.defaultTextFormat = Panel.textFormat;
			itext.width = sizeW - formX;
			itext.height = 20;
			itext.x = formX;
			itext.type = "input";
			itext.border = true;
			itext.borderColor = 0xffffff;
			addChild(itext);
			
			backGround.visible = false;
		}
		
	}

}