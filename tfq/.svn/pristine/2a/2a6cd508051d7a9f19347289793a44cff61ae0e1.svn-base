package editor;
import tk.Button;
import tk.Input;
import tk.Panel;

/**
 * ...
 * @author worldedit
 */

class LayerTitleForm extends Panel
{
	private var nameInput:Input;
	private var okButton:Button;
	private var targetLayer:LayerButton;
	
	public function new(_targetLayer:LayerButton) 
	{
		super("Change Name", 200, 200, true, true, true, true, false);
		
		targetLayer = _targetLayer;
		
		nameInput = new Input("New Name", 180);
		stackSubPanel(nameInput);
		
		okButton = new Button("Ok", 50, 20, set);
		stackSubPanel(okButton);
	}
	
	private function set() 
	{
		targetLayer.changeTitle(nameInput.inputField.text);
		closeWindow();
	}
	
}