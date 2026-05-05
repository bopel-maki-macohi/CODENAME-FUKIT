class FukitUtil {
	public static function initSaveField(field:String, defaultValue:Dynamic = null) {
		if (Reflect.field(FlxG.save.data, field) == null && defaultValue != null) {
			trace('Setting Save Field "$field" to "$defaultValue"');
			Reflect.setField(FlxG.save.data, field, defaultValue);
		}
	}

	public static function getSaveField(field:String, defaultValue:Dynamic = null) {
		var field = Reflect.field(FlxG.save.data, field);

		if (field != null)
			return field;
		else
			return defaultValue;
	}

	public static function playMenuMusic() {
		var isPlayingMenuMusic:Bool = FlxG.sound.music != null && FlxG.sound.music.playing && FlxG.sound.music.volume != 0;
		var canPlayMenuMusic:Bool = getSaveField('fukit_menuMusic');

		trace(isPlayingMenuMusic);
		trace(canPlayMenuMusic);

		if (isPlayingMenuMusic && !canPlayMenuMusic)
			FlxG.sound.music.volume = 0;

		if (!isPlayingMenuMusic && canPlayMenuMusic || isPlayingMenuMusic && canPlayMenuMusic && FlxG.sound.music?.volume == 0) {
			CoolUtil.playMusic(Paths.music('Fukit'), true, 1, true, 120);
		}
	}
}
