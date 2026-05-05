import flixel.util.FlxGradient;

import funkin.backend.chart.Chart;

var songs:Array<String> = CoolUtil.coolTextFile(Paths.txt('songList'));
var songDatas:Array<ChartMetaData> = [];

var songTexts:Array<FunkinText> = [];
var curSelect:Int = 0;
var prevCurSelect:Int = 0;

var isPlayingMenuMusic:Bool = FlxG.sound.music != null && FlxG.sound.music.playing && FlxG.sound.music.volume > 0;

function create() {
    if (!isPlayingMenuMusic) {
        CoolUtil.playMusic(Paths.music('Fukit'), true, 1, true, 61.5);
    }
	
	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFFFFFFFF, 0xFFA1C0D9]);
	add(gradientLinear);
	gradientLinear.alpha = .3;

	trace('${songs.length} song(s)');

	if (songs.length == 0) {
		var txt:FunkinText;

		txt = new FunkinText(0, 10, FlxG.width, 'No songs', 64, false);
		txt.alignment = 'center';
		txt.color = 0x000000;
		txt.screenCenter();

		add(txt);
	}

	var i = 0;
	for (song in songs) {
		var songID:String = song.split('-')[0];
		var songVariation:String = song.split('-')[1] ?? null;

		var chartData:ChartMetaData = Chart.loadChartMeta(songID, 'normal', songVariation);

		songDatas.push(chartData);

		var txt:FunkinText;

		txt = new FunkinText(0, 10, FlxG.width, chartData?.displayName ?? chartData.name, 64, false);
		txt.alignment = 'center';
		txt.screenCenter();
		txt.ID = i;

		txt.y = -FlxG.height;

		add(txt);
		songTexts.push(txt);

		i++;
	}
}

var canSelectStuff:Bool = true;

function leaving(leaveScript:Void->Void, sfx = 1, additionalWait = 0.0) {
	canSelectStuff = false;
	CoolUtil.playMenuSFX(sfx);

	FlxTween.tween(FlxG.camera, {alpha: 0}, .75, {startDelay: additionalWait, ease: FlxEase.sineOut});

	new FlxTimer().start(0.75 + additionalWait, function(timer) {
		if (leaveScript != null)
			leaveScript();
	});
}

function update(elapsed:Float) {
	if ((controls.BACK || songs.length == 0) && canSelectStuff) {
		leaving(function() {
			FlxG.switchState(new ModState('cfukit_pc'));
		}, 2, (songs.length == 0) ? 1 : 0);
	}

	prevCurSelect = curSelect;

	if (controls.UP_R && canSelectStuff) {
		curSelect--;

		if (curSelect < 0)
			curSelect = songTexts.length - 1;
	}

	if (controls.DOWN_R && canSelectStuff) {
		curSelect++;

		if (curSelect > songTexts.length - 1)
			curSelect = 0;
	}

	if (curSelect != prevCurSelect)
		CoolUtil.playMenuSFX();

	if (controls.ACCEPT && canSelectStuff) {
		canSelectStuff = false;

		loadSong(songs[curSelect]);
	}

	for (text in songTexts) {
		text.y = CoolUtil.fpsLerp(text.y, 320 + ((text.ID - curSelect) * 64), 0.1);

		text.color = 0xFFFFFF;

		if (curSelect == text.ID)
			text.color = 0xFFFF00;
	}
}

function loadSong(song:String) {
	if (song == null)
		return;

	trace(song);

	var songID:String = song.split('-')[0];
	var songVariation:String = song.split('-')[1] ?? null;

	FlxG.sound.music?.stop();

	PlayState.loadSong(songID, 'normal', songVariation, false, false);
	FlxG.switchState(new PlayState());
}
