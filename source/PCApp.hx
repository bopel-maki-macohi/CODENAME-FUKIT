package source;

class PCApp extends FunkinSprite
{
	public var hovered:Bool = false;
	public var overlapped:Bool = false;

	public var selectionCondition:Bool = true;
	public var selectionFunction:Dynamic = null;

	public function new(app:String)
	{
		super(1060, 560);

		loadSprite(Paths.image('pc/apps/$app'));

		screenCenter();
		alpha = 0.3;
	}

	public function update(elapsed:Float)
	{
		overlapped = FlxG.mouse.overlaps(this);
		alpha = CoolUtil.fpsLerp(alpha, overlapped ? 1 : 0.3, 0.1);

		if (overlapped)
		{
			if (!hovered && selectionCondition)
			{
				hovered = true;
				CoolUtil.playMenuSFX(0);
			}

			if (FlxG.mouse.justReleased && selectionCondition)
			{
				if (selectionFunction != null) selectionFunction();
			}
		}
		else
		{
			hovered = false;
		}
	}
}
