import flixel.util.FlxGradient;
import funkin.backend.chart.Chart;
import FukitUtil;

var songList:Array<String> = [];
var songDatas:Array<ChartMetaData> = [];
var songTexts:Array<FunkinText> = [];
var songStarDiffs:Array<Int> = [];
var prevStarStates:Array<Int> = [];
var songStarDiffSprites:Array<FunkinSprite> = [];
var curSelect:Int = 0;
var prevCurSelect:Int = -10;

function create()
{
	FukitUtil.playMenuMusic();

	makeGradient();

	makeSongList();

	makeSongTexts();

	makeStars();

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

	trace('${songList.length} song(s)');

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
		var chartMetaData:ChartMetaData = Chart.loadChartMeta(song.split('-')[0], 'normal', song.split('-')[1] ?? null);
		songDatas.push(chartMetaData);

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
}

function makeStars()
{
	var MM = 10;
	var i = 0;

	starText = new FunkinText(32, FlxG.height - starYPad, 0, 'Stars: ', 32);
	add(starText);
	starText.borderSize *= 2;

	while (i < MM)
	{
		var star:FunkinSprite = new FunkinSprite().loadGraphic(Paths.image('pc/stars/0'));
		star.ID = i;
		star.x = FlxG.width * (star.ID + 1) * 2;
		star.y = FlxG.height * (star.ID + 1) * 2;

		songStarDiffSprites.push(star);
		add(star);

		i++;
		prevStarStates.push(0);
	}

	starText.y -= songStarDiffSprites[0].height / 2;
}

var starXPad:Float = 24;
var starYPad:Float = 24;
var starText:FunkinText;

function parseDiff(starDiff:Int = 0)
{
	for (star in songStarDiffSprites)
	{
		var spr = (starDiff <= star.ID) ? 0 : 1;

		if (prevStarStates[star.ID] != spr)
		{
			star.colorTransform.blueMultiplier = 5;
			star.y -= star.height * (star.ID + 1) * .1;
		}

		prevStarStates[star.ID] = spr;
		star.loadGraphic(Paths.image('pc/stars/$spr'));
	}
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
	for (star in songStarDiffSprites)
	{
		star.x = CoolUtil.fpsLerp(star.x, (starText.x + starText.width) + starXPad + (star.width * star.ID * 1.5), 0.1);
		star.y = CoolUtil.fpsLerp(star.y, FlxG.height - star.height - starYPad, 0.1);

		star.colorTransform.blueMultiplier = CoolUtil.fpsLerp(star.colorTransform.blueMultiplier, 1, 0.1);
		star.colorTransform.redMultiplier = star.colorTransform.greenMultiplier = star.colorTransform.blueMultiplier;
	}

	prevCurSelect = curSelect;

	if (controls.UP_R) changeSelection(-1);
	if (controls.DOWN_R) changeSelection(1);

	for (text in songTexts)
	{
		text.y = CoolUtil.fpsLerp(text.y, 320 + ((text.ID - curSelect) * 64), 0.1);

		text.color = (curSelect == text.ID) ? 0xFFFF00 : 0xFFFFFF;
	}

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
		loadSong(songList[curSelect]);
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
		parseDiff(songStarDiffs[curSelect]);
	}
}

function loadSong(song:String)
{
	if (song == null) return;
	trace(song);

	var songID:String = song.split('-')[0];
	var songVariation:String = song.split('-')[1];

	FlxG.sound.music?.stop();

	PlayState.loadSong(songID, 'normal', songVariation, false, false);
	FlxG.switchState(new PlayState());
}
