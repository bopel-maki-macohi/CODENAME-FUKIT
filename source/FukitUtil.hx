package;

class FukitUtil
{
	public static var MOD_VERSION:String = Flags.customFlags.get('MOD_VERSION');

	public static function initSaveField(field:String, defaultValue:Dynamic = null)
	{
		if (Reflect.field(FlxG.save.data, field) == null && defaultValue != null)
		{
			trace('Setting Save Field "$field" to "$defaultValue"');
			setSaveField(field, defaultValue);
		}
	}

	public static function initFukitSaveField(field:String, defaultValue:Dynamic = null)
	{
		if (Reflect.field(FlxG.save.data.fukit, field) == null && defaultValue != null)
		{
			trace('Setting Fukit Save Field "$field" to "$defaultValue"');
			setFukitSaveField(field, defaultValue);
		}
	}

	public static function setSaveField(field:String, value:Dynamic = null) Reflect.setField(FlxG.save.data, field, value);
	public static function setFukitSaveField(field:String, value:Dynamic = null) Reflect.setField(FlxG.save.data.fukit, field, value);

	public static function getSaveField(field:String, defaultValue:Dynamic = null)
	{
		var field = Reflect.field(FlxG.save.data, field);

		if (field != null) return field;
		else
			return defaultValue;
	}

	public static function getFukitSaveField(field:String, defaultValue:Dynamic = null)
	{
		var field = Reflect.field(FlxG.save.data.fukit, field);

		if (field != null) return field;
		else
			return defaultValue;
	}

	public static function playMenuMusic()
	{
		var isPlayingMenuMusic:Bool = FlxG.sound.music != null && FlxG.sound.music.playing && FlxG.sound.music.volume != 0;
		var canPlayMenuMusic:Bool = getSaveField('fukit_menuMusic');

		if (isPlayingMenuMusic && !canPlayMenuMusic) FlxG.sound.music.volume = 0;

		if (!isPlayingMenuMusic && canPlayMenuMusic || isPlayingMenuMusic && canPlayMenuMusic && FlxG.sound.music?.volume == 0)
		{
			CoolUtil.playMusic(Paths.music('Fukit'), true, 1, true, 120);
		}
	}
}
