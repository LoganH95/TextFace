using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TextFaceView extends Ui.WatchFace { 
	hidden var time;
	hidden var layout; 
	 
    function initialize() {
        WatchFace.initialize();
        time = new TimeDisplay();
		layout = new Layout();
    }

    function onUpdate(dc) {		
    	resetScreen(dc);
        time.displayTime(dc);
        layout.displayInfo(dc); 
    }
    
    function resetScreen(dc) {
    	dc.setColor(Color.getBackgroundColor(), Color.getBackgroundColor());
		dc.clear();
		dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
    }
}
