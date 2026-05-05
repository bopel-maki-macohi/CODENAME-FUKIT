function onEvent(e) {
	if (e.event.name != 'CenterCam')
		return;

	// trace(e.event);

	var params = {
		xOffset: e.event.params[0],
		yOffset: e.event.params[1],
	};

	curCameraTarget = -1;
	camFollow.screenCenter();

    camFollow.x += params.xOffset;
    camFollow.y += params.yOffset;
}
