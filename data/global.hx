import FukitUtil;
import funkin.backend.system.framerate.Framerate;
import ArgUtil;

function new()
{
	// store anything I want in here
	FukitUtil.initSaveField('fukit', {
		// why does the formatting do this? I have no idea...
	});
	FukitUtil.initFukitSaveField('versionChangeWarning', false);

	if (ArgUtil.argPairExists(ArgUtil.FORCE_VERSIONCHANGEWARNING))
	{
		FukitUtil.setFukitSaveField('versionChangeWarning', false);
	}

	FukitUtil.initSaveField('fukit_menuMusic', true);
	FukitUtil.initSaveField('fukit_cutscenes', true);
	FukitUtil.setSaveField('fukit_devMode', Paths.getFolderDirectories('.').contains('.dev')
		|| ArgUtil.argPairNotCancelled(ArgUtil.FORCE_DEVMODE));

	Framerate.debugMode = 0;

	ArgUtil.logExistingArgPairs();
}
