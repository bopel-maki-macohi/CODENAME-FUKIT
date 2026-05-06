import FukitUtil;

function create()
{
    PlayState.instance.playCutscenes = FukitUtil.getSaveField('fukit_cutscenes');

    PauseSubState.script = 'data/scripts/pauseScript';
}