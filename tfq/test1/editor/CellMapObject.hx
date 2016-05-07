package editor;

import editor.CellMap;
import editor.Float2;

interface CellMapObject 
{
	function setIndexes(_j:Int,_i:Int,_cm:CellMap):Void;
	function getPosition():Float2;
	function removeFrom():Void;
}