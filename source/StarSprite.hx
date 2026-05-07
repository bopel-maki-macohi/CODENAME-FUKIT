package source;

class StarSprite extends FunkinSprite
{
	public function new(index:Int, startingState:Int = 0)
	{
		super();

		this.ID = index;
		setState(startingState);

		x = FlxG.width * (ID + 1) * 2;
		y = FlxG.height * (ID + 1) * 2;
	}

	public var previousState:Int = -1;

	public function setState(newState:Int)
	{
		if (previousState != newState)
		{
			previousState = newState;
			flash();
		}

		loadGraphic(Paths.image('pc/stars/$newState'));
	}

	public function flash()
	{
		// naked = true;

		colorTransform.blueMultiplier = 5;
		y -= height * (ID + 1) * .1;
	}

    public var starXPad:Float = 24;
    public var starYPad:Float = 24;

	public function update(elapsed:Float)
	{
		x = CoolUtil.fpsLerp(x, starXPad + (width * ID * 1.5), 0.1);
		y = CoolUtil.fpsLerp(y, FlxG.height - height - starYPad, 0.1);

		colorTransform.blueMultiplier = CoolUtil.fpsLerp(colorTransform.blueMultiplier, 1, 0.1);
		colorTransform.redMultiplier = colorTransform.greenMultiplier = colorTransform.blueMultiplier;
	}
}
