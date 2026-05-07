import FukitUtil;
import funkin.backend.system.framerate.Framerate;
import ArgUtil;

function new()
{
	FukitUtil.initSaveField('fukit_menuMusic', true);
	FukitUtil.initSaveField('fukit_cutscenes', true);
	FukitUtil.setSaveField('fukit_devMode', Paths.getFolderDirectories('.').contains('.dev')
		|| ArgUtil.argPairNotCancelled(ArgUtil.FORCE_DEVMODE));

	if (ArgUtil.argPairNotCancelled(ArgUtil.FORCE_ENABLE_MUSIC)) FukitUtil.setSaveField('fukit_menuMusic', true);
	if (ArgUtil.argPairNotCancelled(ArgUtil.FORCE_DISABLE_MUSIC)) FukitUtil.setSaveField('fukit_menuMusic', false);

	if (ArgUtil.argPairNotCancelled(ArgUtil.FORCE_ENABLE_CUTSCENES)) FukitUtil.setSaveField('fukit_cutscenes', true);
	if (ArgUtil.argPairNotCancelled(ArgUtil.FORCE_DISABLE_CUTSCENES)) FukitUtil.setSaveField('fukit_cutscenes', false);

	Framerate.debugMode = 0;

	ArgUtil.logExistingArgPairs();
}
