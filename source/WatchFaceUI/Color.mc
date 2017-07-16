using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;

class Color {
    static function getPrimaryColor() {
    	var primaryColor = App.getApp().getProperty("color_primary");
    	if (primaryColor == null) {
			primaryColor = Gfx.COLOR_WHITE; 
		}
		primaryColor = checkConflictingColors(primaryColor); 
    	return primaryColor; 
    }
    
    static function checkConflictingColors(color) {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert && color == Gfx.COLOR_BLACK) {
    		return Gfx.COLOR_WHITE; 
    	} else if (invert && color == Gfx.COLOR_WHITE) {
    		return Gfx.COLOR_BLACK; 
    	} else {
    		return color; 
    	}
    }
    
    static function getSecondaryColor() {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert) {
			return Gfx.COLOR_WHITE;
		}
    	return Gfx.COLOR_BLACK; 
    }
    
    static function getBackgroundColor() {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert) {
			return Gfx.COLOR_BLACK;
		}
    	return Gfx.COLOR_WHITE; 
    }
}