package io;

import flash.utils.TypedDictionary;
import game.entities.Crate;
import game.entities.Jumper;
import game.entities.Pacer;
import game.entities.Player;
import game.entities.Plushie;
import tFramework.core.units.Unit;

class EntFactory
{
	public static var items:TypedDictionary<String,Class<Dynamic>>;

	public static function init():Void
	{
		items = new TypedDictionary<String,Class<Dynamic>>();
		items.set("player",PlayerInfo);
		items.set("crate",Crate);
		items.set("plushie",Plushie);
		items.set("pacer",Pacer);
		items.set("jumper",Jumper);
	}

	public static function get(_obj:Dynamic, args):Dynamic
	{
		var o = Type.createInstance(items.get(_obj.name),args);
		o.x = _obj.x + _obj.bounds.left;
		o.y = _obj.y + _obj.bounds.up;

		return cast o;
	}

	public function new()
	{

	}
}