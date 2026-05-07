import FukitUtil;
import funkin.backend.system.framerate.Framerate;
import ArgUtil;

function new()
{
	FukitUtil.initSaveField('fukit_menuMusic', true);
	FukitUtil.initSaveField('fukit_cutscenes', true);
	FukitUtil.setSaveField('fukit_devMode', Paths.getFolderDirectories('.').contains('.dev')
		|| ArgUtil.argPairNotCancelled(ArgUtil.FORCE_DEVMODE));

	if (ArgUtil.argPairNotCancelled(ArgUtil.DISABLE_MUSIC)) FukitUtil.setSaveField('fukit_menuMusic', false);

	Framerate.debugMode = 0;

	ArgUtil.logExistingArgPairs();
}
