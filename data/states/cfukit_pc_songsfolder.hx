import flixel.util.FlxGradient;

var songs:Array<String> = CoolUtil.coolTextFile(Paths.txt('songList'));
var songTexts:Array<FunkinText> = [];
var curSelect:Int = 0;
var prevCurSelect:Int = 0;

function create() {
	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFFFFFFFF, 0xFFA1C0D9]);
	add(gradientLinear);

	// temp until I have music in
	FlxG.sound.music?.stop();

	trace('${songs.length} songs');

	var i = 0;
	for (song in songs) {
		var txt:FunkinText;

		txt = new FunkinText(0, 10, FlxG.width, song, 64, false);
		txt.alignment = 'center';
		txt.color = 0x000000;
		txt.screenCenter();
		txt.ID = i;

		txt.y = -FlxG.height;

		add(txt);
		songTexts.push(txt);

		i++;
	}
}

var canSelectStuff:Bool = true;

function leaving(leaveScript:Void->Void, sfx = 1) {
	canSelectStuff = false;
	CoolUtil.playMenuSFX(sfx);

	FlxTween.tween(FlxG.camera, {alpha: 0}, .75, {ease: FlxEase.sineOut});

	new FlxTimer().start(0.75, function(timer) {
		if (leaveScript != null)
			leaveScript();
	});
}

function update(elapsed:Float) {
	if (controls.BACK) {
		leaving(function() {
			FlxG.switchState(new ModState('cfukit_pc'));
		}, 2);
	}

	prevCurSelect = curSelect;

	if (controls.UP_R) {
		curSelect--;

		if (curSelect < 0)
			curSelect = songTexts.length - 1;
	}

	if (controls.DOWN_R) {
		curSelect++;

		if (curSelect > songTexts.length - 1)
			curSelect = 0;
	}

	if (curSelect != prevCurSelect)
		CoolUtil.playMenuSFX();

	for (text in songTexts) {
		text.y = CoolUtil.fpsLerp(text.y, 320 + ((text.ID - curSelect) * 64), 0.1);

		text.color = 0x000000;

		if (curSelect == text.ID)
			text.color = 0xFFFF00;
	}
}
