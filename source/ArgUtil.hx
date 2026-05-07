package;

class ArgUtil
{
	public static var OXIPNG:Array<String> = ['OXIPNG', 'NO_OXIPNG'];
	public static var FORCE_DEVMODE:Array<String> = ['FORCE_DEVMODE'];
	public static var SKIP_INTRO:Array<String> = ['SKIP_INTRO'];

	public static function logExistingArgPairs()
	{
		var pairs:Array<Array<String>> = [];
		pairs.push(OXIPNG);
		pairs.push(FORCE_DEVMODE);
		pairs.push(SKIP_INTRO);

		logArgPairs(pairs);
	}

	public static function logArgPairs(argPairs:Array<Array<String>>)
	{
		for (pair in argPairs)
		{
			if (!argPairNotCancelled(pair))
			{
				trace('Cancelled: ${pair[0]} (Cancelled via ${pair[1]})');
				continue;
			}

			if (argExists(pair[0]))
			{
				trace('Defined: ${pair[0]}');
				continue;
			}

			trace('Undefined: ${pair[0]}');
		}
	}

	public static function argPairExists(argPair:Array<String>):Bool return argExists(argPair[0]) && !argPairNotCancelled(argPair);

	public static function argPairNotCancelled(argPair:Array<String>):Bool return !argExists(argPair[1]);

	public static function argExists(arg:String):Bool return Sys.args().contains('-' + arg);
}
