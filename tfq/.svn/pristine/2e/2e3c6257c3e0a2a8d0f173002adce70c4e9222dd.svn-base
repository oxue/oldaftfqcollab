package tFramework.core;

import flash.events.Event;
import flash.display.Stage;
import flash.geom.Point;
import flash.Lib;
import flash.Vector;
import haxe.Log;
import haxe.PosInfos;
import libTF.structures.SaveDataManager;
import libTF.utils.GlyphEncoder;
import libTF.utils.Hasher; 
import tFramework.render.Screen;
import tFramework.core.modules.Module;
import Core;

class Manager
{
	//This is where random TODOs without a class go
	//Codewords are TODO FIXME BUG REVISE MAYBE RESOLVE
	//TODO shape renderables
	//TODO standardize rendering/pixie use/etc
	//TODO use IntRect/IntPoint
	//TODO comment everything
	//TODO origins on everything
	//TODO Write macro for quick multi-dim vector syntax
	
	public static var STAGE:Stage;
	public static var saves:SaveDataManager;
	public static var cyclesPassed:Int;
	public static var time(getTime, null):Int;
	public static var lastUpdate:Int;
	public static var updateRate:Int;
	public static var updateCap:Int;
	public static var updatesRun:Int;
	public static var lastMouse:Bool;
	
	public static var modules:Vector<Module>;
	
	public static function main()
	{
		//Log.trace = function(v:Dynamic, ?pos:PosInfos):Void { Lib.fscommand("trace", v.toString()); }
		
		STAGE = Lib.current.stage;
		Screen.setup(STAGE);
		KeyManager.setup(STAGE);
		MouseManager.setup(STAGE);
		GlyphEncoder.setup();
		GlyphEncoder.registerAll();
		STAGE.addEventListener(Event.ENTER_FRAME, cycle);
		
		saves = new SaveDataManager(Hasher.macrohash(10), 0);
		cyclesPassed = 0;
		time = Lib.getTimer();
		lastUpdate = Lib.getTimer();
		updateRate = 40;
		updateCap = 10;
		
		lastMouse = false;
		
		modules = new Vector<Module>();
		
		Core.setState("START");
	}
	
	public static function cycle(e:Event):Void
	{
		cyclesPassed++;
		updatesRun = 0;
		while (lastUpdate + updateRate < time && updatesRun < updateCap) 
		{
			updatesRun++;
			lastUpdate += updateRate;
			Core.update();
		}
		/*if (updatesRun > 0) 
		{
			if (MouseManager.isPressed && !lastMouse) { Core.click(); }
			else if (!MouseManager.isPressed && lastMouse) { Core.release(); }
		}*/
		if (updatesRun == updateCap) { lastUpdate = time; }
		Core.render();
	}
	
	public static function addModule(inModule:Module):Void
	{
		modules.push(inModule);
	}
	
	public static function removeModule(inModule:Module):Void
	{
		modules.splice(modules.indexOf(inModule), 1);
	}
	
	public static function clearModules():Void
	{
		var i:Int = modules.length - 1;
		while ( i >= 0)
		{
			removeModule(modules[i]);
			i--;
		}
	}
	
	inline private static function getTime():Int
	{
		return time = Lib.getTimer();
	}
	
}