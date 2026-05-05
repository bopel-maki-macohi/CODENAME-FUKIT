import flixel.util.FlxTimer;
import flixel.util.FlxGradient;
import funkin.backend.MusicBeatState;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;

var daText:FunkinText;

var settings:FunkinSprite;
var songsFolder:FunkinSprite;

function create() {
	daText = new FunkinText(0, 0, FlxG.width, 'PC', 64, false);
	daText.alignment = 'center';
	daText.color = 0xFFFFFF;
	daText.x = FlxG.width - daText.width;
	// add(daText);

	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0x7F4E1E61, 0xFF0D4A50]);
	gradientLinear.alpha = 0.6;
	add(gradientLinear);

	settings = new FunkinSprite(1060, 560).loadSprite(Paths.image('pc/settingsGear'));
	
	settings.screenCenter();
	settings.x -= settings.width * 2;

	settings.alpha = 0.3;
	add(settings);

	FlxG.mouse.visible = true;
}

function update(elapsed:Float) {
	
	var overlapsButton:Bool = FlxG.mouse.overlaps(settings);
	settings.alpha = CoolUtil.fpsLerp(settings.alpha, overlapsButton ? 1 : 0.3, 0.1);

	if (controls.DEV_ACCESS) {
		openSubState(new EditorPicker());
		persistentUpdate = !(persistentDraw = true);
	}

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}
}
