import flixel.util.FlxTimer;
import flixel.util.FlxGradient;
import funkin.backend.MusicBeatState;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import FukitUtil;
import PCApp;

var daText:FunkinText;
var settings:PCApp;
var songsFolder:PCApp;
var creditsTextFile:PCApp;

function create()
{
	FukitUtil.playMenuMusic();

	makeVersionText();

	makeGradient();

	makeApps();

	FlxG.mouse.visible = true;
}

function makeVersionText()
{
	daText = new FunkinText(0, 16, FlxG.width, 'CODENAME FUKIT ${FukitUtil.MOD_VERSION}', 32, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	add(daText);
}

function makeGradient()
{
	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0x7F4E1E61, 0xFF0D4A50]);
	gradientLinear.alpha = 0.6;
	add(gradientLinear);
}

function makeApps()
{
	settings = new PCApp('settings');
	settings.x -= settings.width * 2;
	add(settings);

	settings.selectionFunction = function()
	{
		leaving(function()
		{
			if (!FukitUtil.getSaveField('fukit_menuMusic'))
			{
				FlxG.sound.playMusic(Paths.music('Fukit'));
				FlxG.sound.music.volume = 0;
			}

			FlxG.switchState(new OptionsMenu());
		});
	};

	songsFolder = new PCApp('songsFolder');
	songsFolder.x += songsFolder.width * 1.25;
	add(songsFolder);

	songsFolder.selectionFunction = function()
	{
		leaving(function()
		{
			FlxG.switchState(new ModState('cfukit_pc_songsfolder', {file: 'volume1'}));
		});
	};

	creditsTextFile = new PCApp('creditsTextFile');
	add(creditsTextFile);

	creditsTextFile.selectionFunction = function()
	{
		leaving(function()
		{
			FlxG.switchState(new CreditsMain());
		});
	};
}

var canSelectStuff:Bool = true;

function leaving(leaveScript:Void->Void)
{
	canSelectStuff = false;
	CoolUtil.playMenuSFX(1);

	FlxTween.tween(FlxG.camera, {zoom: 1.1, alpha: .75}, .75, {ease: FlxEase.sineOut});

	new FlxTimer().start(0.75, function(timer)
	{
		if (leaveScript != null) leaveScript();
	});
}

function update(elapsed:Float)
{
	settings.selectionCondition = canSelectStuff;
	songsFolder.selectionCondition = canSelectStuff;
	creditsTextFile.selectionCondition = canSelectStuff;

	if (controls.DEV_ACCESS)
	{
		openSubState(new EditorPicker());
		persistentUpdate = !(persistentDraw = true);
	}

	if (controls.SWITCHMOD)
	{
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}
}
