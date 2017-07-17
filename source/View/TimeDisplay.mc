using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class TimeDisplay {
	hidden var times = ["O", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty", "Thirty", "Forty", "Fifty"];
	hidden var font; 
	hidden var width;
	hidden var height;

	function initialize() {
		font = Ui.loadResource(Rez.Fonts.id_font); 
    }
	
    function displayTime(dc) {
    	width = dc.getWidth();
    	height = dc.getHeight();
    
 		var x; 
 		var hour = Sys.getClockTime().hour;
 		var min = Sys.getClockTime().min; 
 		var tens; 
 		var ones = ""; 
    	
    	if (hour > 12) {
    		hour = hour - 12;
    	} else if (hour == 0) {
    		hour = 12; 
    	}
    	
    	dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
    	
    	if (Sys.getDeviceSettings().screenShape == Sys.SCREEN_SHAPE_SEMI_ROUND) {
    		x = 30;
        	dc.drawText(x, height/4 - 25, font, times[hour], Gfx.TEXT_JUSTIFY_LEFT);
        } else if (Sys.getDeviceSettings().screenShape == Sys.SCREEN_SHAPE_ROUND) {
        	x = 39;
        	dc.drawText(x, height/4 - 30, font, times[hour], Gfx.TEXT_JUSTIFY_LEFT);   	
        } else {
        	x = 10;
        	dc.drawText(x, height/4 - 35, font, times[hour], Gfx.TEXT_JUSTIFY_LEFT);
        }
    	
    	if (min >= 10 && min <= 19) {
    		tens = times[min]; 
    	} else if (min >= 20 && min <= 29) {
    		tens = times[20];
    	} else if (min >= 30 && min <= 39) {
    		tens = times[21]; 
    	} else if (min >= 40 && min <= 49) {
    		tens = times[22]; 
    	} else if (min >= 50 && min <= 59) {
    		tens = times[23];
    	} else {
    		if (min != 0) {
    			tens = times[0]; 
    		} else {
    			tens = "O'Clock"; 
    		}
    	}
    	
    	if ((min % 10) != 0 && min != 0 && !(min >= 10 && min <= 19)) {
    		ones = times[min % 10]; 
    	}
    	dc.setColor(Color.getSecondaryColor(), Gfx.COLOR_TRANSPARENT);
    	drawMinutes(dc, tens, ones, x); 
    }
    
    hidden function drawMinutes(dc, tens, ones, x) {
    	dc.drawText(x, height/4 + 5, font, tens, Gfx.TEXT_JUSTIFY_LEFT);
    	dc.drawText(x, height/4 + 35, font, ones, Gfx.TEXT_JUSTIFY_LEFT);
    }
}