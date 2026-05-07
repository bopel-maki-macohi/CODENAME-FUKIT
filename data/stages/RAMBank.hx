import funkin.editors.charter.Charter;

var guardTween:FlxTween;
var flippedGuard:Bool = false;

function onEvent(e) {
	if (e.event.name != 'RAMBankGuard')
		return;

	var params = {
		duration: e.event.params[0],
	};

	// trace('RAMBankGuard: ' + params);

	if (guardTween != null)
		guardTween.cancel();

	guard.flipX = flippedGuard;

	if (!flippedGuard) {
		guard.x = 920;
		guardTween = FlxTween.tween(guard, {x: 200}, params.duration);
	} else {
		guard.x = 200;
		guardTween = FlxTween.tween(guard, {x: 920}, params.duration);
	}

	flippedGuard = !flippedGuard;
}


var time:Float = 0;

function update(elapsed:Float) {
    time += elapsed * 2;

    guard.y = 400 - (Math.cos(time) * 10);
}

function postCreate() {
	var bgShader = new CustomShader("dropshadowShader");

	bgShader.brightness = -36;
	bgShader.hue = -4;
	bgShader.saturation = -45;
	bgShader.contrast = -16;

	doorway.shader = bgShader;
	ground.shader = bgShader;
	void.shader = bgShader;

	var charShader = new CustomShader("dropshadowShader");

	charShader.brightness = -70;
	charShader.hue = -22;
	charShader.saturation = -48;
	charShader.contrast = -44;

	dad.shader = charShader;
	bf.shader = charShader;
}
