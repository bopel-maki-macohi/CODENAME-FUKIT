import flixel.util.FlxGradient;
import funkin.backend.chart.Chart;
import FukitUtil;

var songs:Array<String> = CoolUtil.coolTextFile(Paths.txt('songList'));
var songDatas:Array<ChartMetaData> = [];
var songTexts:Array<FunkinText> = [];
var songStarDiffs:Array<Int> = [];
var songStarDiffSprites:Array<FunkinSprite> = [];
var curSelect:Int = 0;
var prevCurSelect:Int = 0;

function create() {
	FukitUtil.playMenuMusic();

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

		var chartMetaData:ChartMetaData = Chart.loadChartMeta(songID, 'normal', songVariation);

		songDatas.push(chartMetaData);

		var starDiff = 0;
		if (chartMetaData.customValues.starDiff != null)
			starDiff = Std.parseInt(chartMetaData.customValues.starDiff);
		songStarDiffs.push(starDiff);

		var txt:FunkinText;

		txt = new FunkinText(0, 10, FlxG.width, chartMetaData?.displayName ?? chartMetaData.name, 64, false);
		txt.alignment = 'center';
		txt.screenCenter();
		txt.ID = i;

		txt.y = -FlxG.height;

		add(txt);
		songTexts.push(txt);

		i++;
	}

	var MM = 10;
	var m = 0;

	starText = new FunkinText(32, FlxG.height - starYPad, 0, 'Stars: ', 32);
	add(starText);
	starText.borderSize *= 2;

	while (m < MM) {
		var star:FunkinSprite = new FunkinSprite().loadGraphic(Paths.image('pc/stars/0'));

		star.ID = m;

		star.y = FlxG.height - star.height - starYPad;

		songStarDiffSprites.push(star);
		add(star);

		m++;
	}

	starText.y -= songStarDiffSprites[0].height / 2;

	parseDiff(songStarDiffs[curSelect]);
}

var starXPad:Float = 24;
var starYPad:Float = 24;
var starText:FunkinText;

function parseDiff(starDiff:Int = 0) {
	for (star in songStarDiffSprites) {
		var spr = 1;

		if (starDiff <= star.ID)
			spr = 0;

		star.loadGraphic(Paths.image('pc/stars/$spr'));
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
	for (star in songStarDiffSprites) {
		var targX = (starText.x + starText.width) + starXPad + (star.width * star.ID * 1.5);

		star.x = CoolUtil.fpsLerp(star.x, targX, 0.1);
	}

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

	if (curSelect != prevCurSelect) {
		CoolUtil.playMenuSFX();
		parseDiff(songStarDiffs[curSelect]);
	}

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
