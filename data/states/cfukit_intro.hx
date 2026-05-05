import flixel.util.FlxTimer;

import funkin.backend.MusicBeatState;

var daText:FunkinText;

function create()
{
	daText = new FunkinText(0, 0, FlxG.width, 'Hewo', 64, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	daText.screenCenter();
	add(daText);
	
	FlxG.mouse.visible = true;

	new FlxTimer().start(2, function(timer) {
		goToNextState();
	});
}

function goToNextState()
{
	MusicBeatState.skipTransIn = true;
	MusicBeatState.skipTransOut = true;

	FlxG.switchState(new ModState('cfukit_pc'));
}
