package tk;

import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

class Input extends Panel
{
	public var inputField:TextField;
	public var value(getValue, setValue):String;

	public function new(_title:String = "default", 
						_width:Int = 100):Void
	{
		super(_title, _width, 20, false, false, false);

		inputField = new TextField();
		inputField.defaultTextFormat = new TextFormat("courier new",12,0x000000,true);
		inputField.type = TextFieldType.INPUT;
		inputField.height = 20;
		inputField.border = true;
		inputField.borderColor = 0x000000;
		inputField.width = _width * 0.5;
		inputField.x = _width * 0.5;
		inputField.background = true;
		inputField.backgroundColor = 0xffffff;
		addChild(inputField);
	}

	public function getValue():String
	{
		return inputField.text;
	}

	public function setValue(_value:String):String
	{
		inputField.text = _value;
		return _value;
	}
}