import FukitUtil;

function postCreate() {
	FukitUtil.playMenuMusic();

	onMenuClosed.add(function() {
		FukitUtil.playMenuMusic();
	});
}
