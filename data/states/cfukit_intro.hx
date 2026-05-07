import flixel.util.FlxTimer;
import funkin.backend.MusicBeatState;
import funkin.backend.assets.ModsFolder;
import FukitUtil;
import ArgUtil;

var daText:FunkinText;
var delay:Float = 0;

function create() {
	if (ArgUtil.argPairNotCancelled(ArgUtil.SKIP_INTRO))
		goToNextState();
	else
		intro();
}

function intro() {
	daText = new FunkinText(0, 0, FlxG.width, 'Hewo', 64, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	daText.screenCenter();
	add(daText);

	FlxG.mouse.visible = true;

	if (ArgUtil.argPairNotCancelled(ArgUtil.OXIPNG) && FukitUtil.getSaveField('fukit_devMode'))
		oxipng();

	daText.screenCenter();

	new FlxTimer().start(2 + delay, function(timer) {
		goToNextState();
	});
}

function goToNextState() {
	MusicBeatState.skipTransIn = true;
	MusicBeatState.skipTransOut = delay == 0;

	FlxG.switchState(new ModState('cfukit_pc'));
}

function oxipng() {
	daText.text = 'OXIPNGING!';

	delay = 3;
	new FlxTimer().start(1, function(timer) {
		var process = new sys.io.Process('cd "mods/' + ModsFolder.currentModFolder + '" && oxipng --verbose -o max --strip safe --alpha **/*.png');

		daText.size = 32;

		if (process.exitCode() != 0) {
			daText.text = 'Coudlnt oxipng...';
			daText.text += '\n\nstderr:\n';
			daText.text += process.stderr.readAll().toString();
		} else {
			daText.text = 'OXIPNGED!';
			daText.text += '\n\nstdout:\n';
			daText.text += process.stdout.readAll().toString();
		}
		trace(daText.text);

		daText.screenCenter();

		process.close();
	});
}
