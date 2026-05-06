import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
import flixel.effects.particles.FlxParticle;

var starsBG:FlxTypedEmitter;

function onStageXMLParsed() {
	starsBG = new FlxTypedEmitter();
	starsBG.maxSize = 100 * 10;

	for (i in 0...starsBG.maxSize) {
		var particle:FlxParticle = new FlxParticle();
		particle.loadGraphic(Paths.image('stages/space/star'), true, 16, 16);

		particle.animation.frameIndex = FlxG.random.int(0, 1);

		particle.scale.set(6, 6);
		particle.updateHitbox();

		particle.scrollFactor.x = FlxG.random.float(0.1, 1);
		particle.scrollFactor.y = particle.scrollFactor.x;

		starsBG.add(particle);
	}

	starsBG.width = 1;
	starsBG.height = FlxG.height * 2;

	starsBG.x = -480 * 2;

	var minS = 6 * .1;
	var maxS = 6 * .4;
	starsBG.scale.set(minS, minS, maxS, maxS);

	starsBG.alpha.set(0.5, 0.5, 0, 0);
	starsBG.angle.set(0, 90);

	starsBG.angularVelocity.set(-100, 100);

	starsBG.velocity.set(10000000);

	starsBG.acceleration.set(10, 0, 100, 0);

	starsBG.drag.set();

	starsBG.launchAngle.set(0, 0);

	starsBG.lifespan.set(6, 20);

	starsBG.keepScaleRatio = true;

	starsBG.start(false, .1);
	add(starsBG);

	// PlayState.instance.insert(PlayState.instance.members.indexOf(PlayState.instance.gf) - 1, starsBG);

	// trace('sparce');
}

function postCreate() {
	cloudDAD.x = dad.getGraphicMidpoint().x;
	cloudDAD.y = dad.getGraphicMidpoint().y + (cloudDAD.height * 1);
	cloudDAD.animation.frameIndex = FlxG.random.int(0, 7);

	cloudBF.x = bf.getGraphicMidpoint().x;
	cloudBF.y = bf.getGraphicMidpoint().y + (cloudBF.height * 1.5);
	cloudBF.animation.frameIndex = FlxG.random.int(0, 7);

	urath.screenCenter();

	urath.velocity.x = 0;
	urath.acceleration.x = 30;
	urath.moves = true;

	new FlxTimer().start(20, function(timer) {
		urath.moves = false;

		remove(urath);
		urath.destroy();
	});

	var charShader = new CustomShader("dropshadowShader");

    charShader.brightness = -11;
    charShader.hue = -22;
    charShader.saturation = -40;
    charShader.contrast = -20;

	dad.shader = charShader;
    cloudDAD.shader = charShader;

	bf.shader = charShader;
    cloudBF.shader = charShader;

	var urathShader = new CustomShader("dropshadowShader");

    urathShader.brightness = -40;
    urathShader.hue = 6;
    urathShader.saturation = -28;
    urathShader.contrast = -23;

    urath.shader = urathShader;
}
