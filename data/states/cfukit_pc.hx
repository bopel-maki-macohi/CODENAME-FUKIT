import flixel.util.FlxTimer;
import flixel.util.FlxGradient;
import funkin.backend.MusicBeatState;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import FukitUtil;

var daText:FunkinText;
var settings:FunkinSprite;
var songsFolder:FunkinSprite;
var creditsTextFile:FunkinSprite;

function create() {
	FukitUtil.playMenuMusic();

	daText = new FunkinText(0, 16, FlxG.width, 'CODENAME FUKIT ${FukitUtil.MOD_VERSION}', 32, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	add(daText);

	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0x7F4E1E61, 0xFF0D4A50]);
	gradientLinear.alpha = 0.6;
	add(gradientLinear);

	settings = new FunkinSprite(1060, 560).loadSprite(Paths.image('pc/settingsGear'));

	settings.screenCenter();
	settings.x -= settings.width * 2;

	settings.alpha = 0.3;
	add(settings);

	songsFolder = new FunkinSprite(1060, 560).loadSprite(Paths.image('pc/songsFolder'));

	songsFolder.screenCenter();
	songsFolder.x += songsFolder.width * 1.25;

	songsFolder.alpha = 0.3;
	add(songsFolder);

	creditsTextFile = new FunkinSprite(1060, 560).loadSprite(Paths.image('pc/credits'));

	creditsTextFile.screenCenter();

	creditsTextFile.alpha = 0.3;
	add(creditsTextFile);

	FlxG.mouse.visible = true;
}

var canSelectStuff:Bool = true;
var hoveringOptions:Bool = false;
var hoveringSongsFolder:Bool = false;
var hoveringCreditsTextFile:Bool = false;

function leaving(leaveScript:Void->Void) {
	canSelectStuff = false;
	CoolUtil.playMenuSFX(1);

	FlxTween.tween(FlxG.camera, {zoom: 1.1, alpha: .75}, .75, {ease: FlxEase.sineOut});

	new FlxTimer().start(0.75, function(timer) {
		if (leaveScript != null)
			leaveScript();
	});
}

function update(elapsed:Float) {
	var overlapsSettings:Bool = FlxG.mouse.overlaps(settings);
	settings.alpha = CoolUtil.fpsLerp(settings.alpha, overlapsSettings ? 1 : 0.3, 0.1);

	if (overlapsSettings) {
		if (!hoveringOptions && canSelectStuff) {
			CoolUtil.playMenuSFX(0);
			hoveringOptions = true;
		}

		if (FlxG.mouse.justReleased && canSelectStuff) {
			leaving(function() {
				if (!FukitUtil.getSaveField('fukit_menuMusic')) {
					FlxG.sound.playMusic(Paths.music('Fukit'));
					FlxG.sound.music.volume = 0;
				}

				FlxG.switchState(new OptionsMenu());
			});
		}
	} else
		hoveringOptions = false;

	var overlapssongsFolder:Bool = FlxG.mouse.overlaps(songsFolder);
	songsFolder.alpha = CoolUtil.fpsLerp(songsFolder.alpha, overlapssongsFolder ? 1 : 0.3, 0.1);

	if (overlapssongsFolder) {
		if (!hoveringSongsFolder && canSelectStuff) {
			CoolUtil.playMenuSFX(0);
			hoveringSongsFolder = true;
		}

		if (FlxG.mouse.justReleased && canSelectStuff) {
			leaving(function() {
				FlxG.switchState(new ModState('cfukit_pc_songsfolder', {file: 'volume2'}));
			});
		}
	} else
		hoveringSongsFolder = false;

	var overlappingCreds:Bool = FlxG.mouse.overlaps(creditsTextFile);
	creditsTextFile.alpha = CoolUtil.fpsLerp(creditsTextFile.alpha, overlappingCreds ? 1 : 0.3, 0.1);

	if (overlappingCreds) {
		if (!hoveringCreditsTextFile && canSelectStuff) {
			CoolUtil.playMenuSFX(0);
			hoveringCreditsTextFile = true;
		}

		if (FlxG.mouse.justReleased && canSelectStuff) {
			leaving(function() {
				FlxG.switchState(new CreditsMain());
			});
		}
	} else
		hoveringCreditsTextFile = false;

	if (controls.DEV_ACCESS) {
		openSubState(new EditorPicker());
		persistentUpdate = !(persistentDraw = true);
	}

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}
}
