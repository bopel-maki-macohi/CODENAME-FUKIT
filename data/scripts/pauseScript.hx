function onSelectOption(e)
{
	var name = Reflect.field(e, 'name');

	if (name.toLowerCase() == 'exit to menu') CoolUtil.playMusic(Paths.music('Fukit'), true, 0, true, 120);
}
