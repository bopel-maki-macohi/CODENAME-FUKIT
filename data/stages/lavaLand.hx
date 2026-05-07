function create()
{
	lavafallGlow.x = lavafall.x - 85;
	lavafallGlow.y = lavafall.y - 85;
}

var time:Float = 0;

function update(elapsed:Float)
{
	time += elapsed;

	lavaGlowBack.y = 580 - (Math.cos(time) * 80);
	lava1.y = 806 + (Math.cos(time) * 40);
	// lava2.y = 830 + (Math.cos(time / 2) * 40);
	lavaGlowFront.y = 610 - (Math.cos(time) * 50);
}
