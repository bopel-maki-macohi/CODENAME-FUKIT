import FukitUtil;
import funkin.backend.system.framerate.Framerate;

function new() {
	FukitUtil.initSaveField('fukit_menuMusic', true);
	FukitUtil.initSaveField('fukit_cutscenes', true);
	FukitUtil.setSaveField('fukit_devMode', Paths.getFolderDirectories('.').contains('.dev'));

	Framerate.debugMode = 0;
}
