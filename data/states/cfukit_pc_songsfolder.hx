import flixel.util.FlxGradient;

var songs:Array<String> = CoolUtil.coolTextFile(Paths.txt('songList'));

function create() {
	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFFFFFFFF, 0xFFA1C0D9]);
	add(gradientLinear);

	// temp until I have music in
	FlxG.sound.music?.stop();

	trace(songs);
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
}
