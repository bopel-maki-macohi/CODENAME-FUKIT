import FukitUtil;

function create()
{
    playCutscenes = FukitUtil.getSaveField('fukit_cutscenes') && !PlayState.chartingMode;

    PauseSubState.script = 'data/scripts/pauseScript';
}