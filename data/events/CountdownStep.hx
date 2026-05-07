var runningEvent:Bool = false;

function onEvent(e)
{
	if (e.event.name != 'CountdownStep') return;

	// trace(e.event);

	var params = {
		step: e.event.params[0],
	};

	runningEvent = true;
	PlayState.instance.countdown(params.step);
}

function onCountdown(e)
{
	if (runningEvent)
	{
		e.soundPath = null;
		runningEvent = false;
	}
}
