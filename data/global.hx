import FukitUtil;
import funkin.backend.system.framerate.Framerate;

function new() {
	FukitUtil.initSaveField('fukit_menuMusic', true);
	FukitUtil.initSaveField('fukit_cutscenes', true);

	Framerate.debugMode = 0;
}
