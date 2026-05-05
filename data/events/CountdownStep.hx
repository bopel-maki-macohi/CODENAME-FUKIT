function onEvent(e) {
	if (e.event.name != 'CountdownStep')
		return;

	// trace(e.event);

	var params = {
		step: e.event.params[0],
	};

	PlayState.instance.countdown(params.step);
}
