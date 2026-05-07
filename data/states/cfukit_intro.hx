import flixel.util.FlxTimer;
import funkin.backend.MusicBeatState;
import funkin.backend.assets.ModsFolder;
import FukitUtil;
import ArgUtil;

var daText:FunkinText;
var delay:Float = 0;

function create()
{
	if (ArgUtil.argPairExists(ArgUtil.SKIP_INTRO)) goToNextState();
	else
		intro();
}

function goToNextState()
{
	MusicBeatState.skipTransIn = delay == 0;
	MusicBeatState.skipTransOut = delay == 0;

	FlxG.switchState(new ModState('cfukit_pc'));
}

function intro()
{
	daText = new FunkinText(0, 0, FlxG.width, 'Hewo', 64, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	daText.screenCenter();
	add(daText);

	FlxG.mouse.visible = true;

	if (ArgUtil.argPairNotCancelled(ArgUtil.OXIPNG) && FukitUtil.getSaveField('fukit_devMode')) oxipng();

	new FlxTimer().start(delay, function(timer)
	{
		if (!FukitUtil.getFukitSaveField('versionChangeWarning')) versionChangeWarning();

		new FlxTimer().start(2 + delay, function(timer)
		{
			goToNextState();
		});
	});
}

function versionChangeWarning()
{
	daText.size = 24;
	daText.text = 'Hewa there! Welcome to 1.2.1!\n'
		+ 'I\'m just here to tell you about the version change format that will come with 2.1!\n\n'
		+ 'It will be more based on the OST Volume, and there wont be a .0 update.\n'
		+ 'It will start with .1 and increase from there '
		+ 'until the volume is considered complete.\n\n'
		+ '(If you play or heard of Minecraft)\n'
		+ 'Think of it like the new Minecraft Version System with the drop system (for Java Edition).\n'
		+ '26.1... 26.2... etc.\n\n'
		+ 'That\'s all, enjoy the mod :D';
	daText.screenCenter();

	delay += 8;
}

function oxipng()
{
	daText.text = 'OXIPNGING!';

	delay = 3;
	new FlxTimer().start(1, function(timer)
	{
		var process = new sys.io.Process('cd "mods/' + ModsFolder.currentModFolder + '" && oxipng --verbose -o max --strip safe --alpha **/*.png');

		daText.size = 32;

		if (process.exitCode() != 0)
		{
			daText.text = 'Coudlnt oxipng...';
			daText.text += '\n\nstderr:\n';
			daText.text += process.stderr.readAll().toString();
		}
		else
		{
			daText.text = 'OXIPNGED!';
			daText.text += '\n\nstdout:\n';
			daText.text += process.stdout.readAll().toString();
		}
		trace(daText.text);

		daText.screenCenter();

		process.close();
	});
}
