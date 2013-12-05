StatusBarStyleANE
=================

Set UIStatusBarStyle for iOS7

This Native Extension require iOS7+ And Adobe AIR 3.9+

##Usage
	import jp.kazutoyo.ane.StatusBarStyleANE;

	if(StatusBarStyleANE.getInstance().isSupported()) {
		// Set Light Color
		StatusBarStyleANE.getInstance().setStatusBarStyle(StatusBarStyleANE.STATUS_BAR_STYLE_LIGHT_CONTENT);
	}