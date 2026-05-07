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
	{
		for (i => thing in tree)
		{
			var thingName = Reflect.field(thing, 'name');

			// trace('$i / $thingName : ${Reflect.field(thing, 'name')}');

			// if (thingName == 'Gameplay')
			// thing.__metronome = FlxG.sound.load(Paths.music('Fukit'));
			FlxG.sound.music.stop();
		}
	}
}
