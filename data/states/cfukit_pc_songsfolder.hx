import flixel.util.FlxGradient;

function create() {
	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFFFFFFFF, 0xFFA1C0D9]);
	add(gradientLinear);

	// temp until I have music in
	FlxG.sound.music?.stop();
}

var canSelectStuff:Bool = true;

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
	if (controls.BACK) {
		leaving(function() {
			FlxG.switchState(new ModState('cfukit_pc'));
		});
	}
}
