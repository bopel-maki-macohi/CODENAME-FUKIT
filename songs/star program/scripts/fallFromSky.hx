import flixel.effects.particles.FlxEmitter.FlxTypedEmitter;
import flixel.effects.particles.FlxParticle;
import funkin.editors.charter.Charter;

var underTale = false;

function onStartCountdown(e) {
	if (!underTale && !Charter.startHere) {
		e.cancel();
		underTale = true;

		burstStars();

		Conductor.songPosition -= Conductor.crochet * introLength - Conductor.songOffset;
		var len = (playCutscenes) ? 1 : 2.5;

		new FlxTimer().start(len, function(timer) {
			startCountdown();
		});
	}
}

var starsBG:FlxTypedEmitter;

function burstStars() {
	starsBG = new FlxTypedEmitter();
	starsBG.maxSize = 100 * 10;

	for (i in 0...starsBG.maxSize) {
		var particle:FlxParticle = new FlxParticle();
		particle.loadGraphic(Paths.image('stages/space/star'), true, 16, 16);

		particle.animation.frameIndex = FlxG.random.int(0, 1);

		particle.scale.set(6, 6);
		particle.updateHitbox();

		particle.scrollFactor.x = FlxG.random.float(0.1, 1);
		particle.scrollFactor.y = FlxG.random.float(0.1, 1);

		starsBG.add(particle);
	}

	starsBG.width = FlxG.width * 4;
	starsBG.height = FlxG.height * 8;

	starsBG.x = -starsBG.width * 0.25;
	starsBG.y = -starsBG.height * 0.5;

	var minS = 6 * .1;
	var maxS = 6 * .4;
	starsBG.scale.set(minS, minS, maxS, maxS);

	starsBG.alpha.set(0.5, 0.5, 0, 0);
	starsBG.angle.set(0, 90);

	starsBG.angularVelocity.set(-100, 100);

	starsBG.velocity.set(10000000);

	starsBG.acceleration.set(5, 10, 30, 50);

	starsBG.drag.set();

	starsBG.launchAngle.set(90, 90);

	starsBG.lifespan.set(20, 40);

	starsBG.keepScaleRatio = true;

	starsBG.start(true, .1);
	insert(members.indexOf(dad) - 1, starsBG);
}

function postUpdate() {
	if (starsBG != null) {
		if (starsBG.members.length < 1) {
			starsBG.destroy();
			starsBG = null;
		} else {
			for (star in starsBG.members)
				star.acceleration.x *= 1.0001;
		}
	}
}
