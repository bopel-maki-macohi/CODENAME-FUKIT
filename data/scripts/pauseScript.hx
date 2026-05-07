import FukitUtil;

function onSelectOption(e)
{
	var name = Reflect.field(e, 'name');

	if (name.toLowerCase() == 'exit to menu') CoolUtil.playMusic(Paths.music('Fukit'), true, (FukitUtil.getSaveField('fukit_menuMusic')) ? 1 : 0, true, 120);
}
