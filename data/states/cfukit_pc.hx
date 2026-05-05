import flixel.util.FlxTimer;

import funkin.backend.MusicBeatState;

var daText:FunkinText;

function create() {

	daText = new FunkinText(0, 0, FlxG.width, 'PC', 64, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	add(daText);

	FlxG.mouse.visible = true;
}

function update(elapsed:Float)
{
    if (controls.DEV_ACCESS) {
		openSubState(new EditorPicker());
		persistentUpdate = !(persistentDraw = true);
    }

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}
}
