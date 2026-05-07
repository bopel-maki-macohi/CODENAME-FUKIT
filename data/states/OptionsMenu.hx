import FukitUtil;

function postCreate()
{
	onMenuClosed.add(function()
	{
		if (FlxG.sound.music?.volume > 0 && !FukitUtil.getSaveField('fukit_menuMusic')) FlxG.sound.music.stop();

		FukitUtil.playMenuMusic();
	});

	onMenuClosed.dispatch();
}

function postUpdate()
{
	if (controls.ACCEPT)
		FlxG.sound.music.stop();
}
