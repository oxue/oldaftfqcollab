package tk;

import flash.text.TextField;
import flash.text.TextFormat;

class SimpleOut extends Panel
{
	public var outputBox:TextField;
	public var line:Int;

	function new()
	{
		super("Output",800,150);
		outputBox = new TextField();
		outputBox.width = 780;
		outputBox.height = 110;
		outputBox.border = true;
		outputBox.borderColor = 0x000000;
		outputBox.x = 10;
		outputBox.y = 30;
		outputBox.background = true;
		outputBox.backgroundColor = 0xffffff;
		outputBox.defaultTextFormat = new TextFormat("courier new",12,0x000000,true);
		outputBox.multiline = true;
		outputBox.wordWrap = true;
		addChild(outputBox);
		y = 450;
	}

	public static var instance:SimpleOut;

	public static function init():Void
	{
		instance = new SimpleOut();
	}

	public static function writeLn(_msg:Dynamic):Void
	{
		instance.outputBox.appendText(cast(_msg,String) + '\n');
		if(instance.outputBox.text.length > 800)
		{
		//	instance.outputBox.text = instance.outputBox.text.substr(instance.outputBox.text.length - 600,instance.outputBox.text.length);
		}
		instance.outputBox.scrollV = instance.outputBox.maxScrollV;
	}

}