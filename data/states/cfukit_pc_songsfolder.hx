import flixel.util.FlxGradient;
import funkin.backend.chart.Chart;
import funkin.savedata.FunkinSave;
import FukitUtil;
import StarSprite;

var songList:Array<String> = [];
var songTexts:Array<FunkinText> = [];
var songScores:Array<Int> = [];
var songStarDiffs:Array<Int> = [];
var songStarDiffSprites:Array<StarSprite> = [];
var curSelect:Int = 0;
var prevCurSelect:Int = -10;

function create()
{
	FukitUtil.playMenuMusic();

	makeGradient();

	makeSongList();

	makeSongTexts();

	makeStars();

	makeScoreText();

	FlxG.mouse.visible = false;

	changeSelection(0);
}

function makeGradient()
{
	var gradientLinear:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xFFFFFFFF, 0xFFA1C0D9]);
	add(gradientLinear);
	gradientLinear.alpha = .3;
}

function makeSongList()
{
	songList = CoolUtil.coolTextFile(Paths.txt('songs/${data?.file ?? 'volume1'}'));

	trace('${songList.length} loaded song(s)');

	if (songList.length == 0)
	{
		songList = ['test'];

		var txt:FunkinText = new FunkinText(0, 10, FlxG.width, 'No songs', 64, false);
		txt.alignment = 'center';
		txt.color = 0x000000;
		txt.screenCenter();

		add(txt);
	}
}

function makeSongTexts()
{
	var i = 0;
	for (song in songList)
	{
		var songID:String = song.split('-')[0];
		var songVariation:String = song.split('-')[1];
		songID = StringTools.replace(songID, '_', '');

		songScores.push(FunkinSave.getSongHighscore(songID, 'normal', songVariation).score);

		if (StringTools.startsWith(song, '_') && songScores[i] == 0) continue;

		var chartMetaData:ChartMetaData = Chart.loadChartMeta(songID, songVariation ?? null, 'normal');

		if (chartMetaData.difficulties.length == 0) trace('"$song" has no difficulties (no meta?)');

		var starDiff = FlxG.random.int(0, 10);
		if (chartMetaData.customValues?.starDiff != null) starDiff = Std.parseInt(chartMetaData.customValues.starDiff);
		songStarDiffs.push(starDiff);

		var txt:FunkinText = new FunkinText(0, -FlxG.height, FlxG.width, chartMetaData?.displayName ?? chartMetaData.name, 64, false);
		txt.alignment = 'center';
		txt.screenCenter();
		txt.ID = i;
		add(txt);
		songTexts.push(txt);

		i++;
	}

	trace('${songTexts.length} made song text(s)');
}

var starText:FunkinText;

function makeStars()
{
	var MM = 10;
	var i = 0;

	starText = new FunkinText(32, FlxG.height, 0, 'Stars: ', 32);
	add(starText);
	starText.borderSize *= 2;

	while (i < MM)
	{
		var star:StarSprite = new StarSprite(i, 0);
		star.starXPad += starText.x + starText.width;

		songStarDiffSprites.push(star);
		add(star);

		i++;
	}

	starText.y -= songStarDiffSprites[0].starYPad + songStarDiffSprites[0].height / 2;
}

var scoreText:FunkinText;
var lerpScore:Float = 0;

function makeScoreText()
{
	scoreText = new FunkinText(FlxG.width, 10, FlxG.width, 'Score: 0000000000', 32);
	add(scoreText);
	scoreText.borderSize *= 2;
	scoreText.alignment = 'right';

	scoreText.x -= scoreText.width + 10;
}

function updateStarsForDifficulty(starDiff:Int = 0)
{
	for (star in songStarDiffSprites) star.setState((starDiff <= star.ID) ? 0 : 1);
}

var canSelectStuff:Bool = true;

function leaving(leaveScript:Void->Void, sfx = 1, additionalWait = 0.0)
{
	canSelectStuff = false;
	CoolUtil.playMenuSFX(sfx);

	FlxTween.tween(FlxG.camera, {alpha: 0}, .75, {startDelay: additionalWait, ease: FlxEase.sineOut});

	new FlxTimer().start(0.75 + additionalWait, function(timer)
	{
		if (leaveScript != null) leaveScript();
	});
}

function update(elapsed:Float)
{
	prevCurSelect = curSelect;

	if (controls.UP_R) changeSelection(-1);
	if (controls.DOWN_R) changeSelection(1);

	for (text in songTexts)
	{
		text.y = CoolUtil.fpsLerp(text.y, 320 + ((text.ID - curSelect) * 64), 0.1);
		text.color = (curSelect == text.ID) ? 0xFFFF00 : 0xFFFFFF;
	}

	lerpScore = CoolUtil.fpsLerp(lerpScore, songScores[curSelect], 0.4);
	scoreText.text = 'Score: ' + StringTools.lpad('${Math.round(lerpScore)}', '0', 10);

	if ((controls.BACK || songList.length == 0) && canSelectStuff)
	{
		leaving(function()
		{
			FlxG.switchState(new ModState('cfukit_pc'));
		}, 2, (songList.length == 0) ? 1 : 0);
	}

	if (controls.ACCEPT && canSelectStuff)
	{
		canSelectStuff = false;
		playSong(songList[curSelect]);
	}
}

function changeSelection(amount:Int)
{
	if (!canSelectStuff) return;

	curSelect += amount;

	if (curSelect < 0) curSelect = songTexts.length - 1;
	if (curSelect > songTexts.length - 1) curSelect = 0;

	if (curSelect != prevCurSelect)
	{
		CoolUtil.playMenuSFX();
		updateStarsForDifficulty(songStarDiffs[curSelect]);
	}
}

function playSong(song:String)
{
	if (song == null) return;
	trace(song);

	var songID:String = song.split('-')[0];
	var songVariation:String = song.split('-')[1];

	FlxG.sound.music?.stop();

	PlayState.loadSong(songID, 'normal', songVariation, false, false);
	FlxG.switchState(new PlayState());
}
