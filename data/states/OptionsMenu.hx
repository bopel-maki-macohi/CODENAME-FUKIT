import FukitUtil;

function preCreate() {
	if (!FlxG.sound.music?.playing)
		CoolUtil.playMusic(Paths.music('Fukit'), true, 0, true, 120);
}

function postCreate() {
	FukitUtil.playMenuMusic();

	onMenuClosed.add(function() {
		FukitUtil.playMenuMusic();
	});
}
