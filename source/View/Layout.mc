using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Application as App;


class Layout {
	hidden var type;
	hidden var cycle; 
	hidden var dateString; 
	hidden var batteryString; 
	
	function initialize() {
		type = App.getApp().getProperty("layout");
    }
    
    function displayInfo(dc){
    	var hour = Sys.getClockTime().hour;
	    var width = dc.getWidth();
    	var height = dc.getHeight();
    	dc.setColor(Color.getSecondaryColor(), Gfx.COLOR_TRANSPARENT);      
    	
        setCycle(hour); 
        setDate(); 
        batteryString = Lang.format("$1$%", [Sys.getSystemStats().battery.toNumber()]);
        
        if (Sys.getDeviceSettings().screenShape == 2) {
    		displaySemiRound(dc, width, height); 
        }
        else if (Sys.getDeviceSettings().screenShape == 1) {
        	displayRound(dc, width, height); 
        }
        else {
        	displaySquare(dc, width, height); 
        }        
    }
    
    hidden function displaySquare(dc, width, height) {
    	dc.drawLine(10, height - 7, width - 10, height - 7);
    	dc.drawText(203, -2, Gfx.FONT_MEDIUM, batteryString, Gfx.TEXT_JUSTIFY_RIGHT);
    	dc.drawText(10, height - 32, Gfx.FONT_MEDIUM, cycle, Gfx.TEXT_JUSTIFY_LEFT);
    	dc.drawText(width - 7 ,height - 32, Gfx.FONT_MEDIUM, dateString, Gfx.TEXT_JUSTIFY_RIGHT);
   	 	dc.drawText(width - 10, height - 52, Gfx.FONT_MEDIUM, Calendar.info(Time.now(), Time.FORMAT_LONG).day_of_week, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    hidden function displayRound(dc, width, height) {
    	dc.drawLine(39, height - 30, width - 39, height - 30);
    	dc.drawText(width - 39, height/4 - 33, Gfx.FONT_MEDIUM, batteryString, Gfx.TEXT_JUSTIFY_RIGHT);
    	dc.drawText(39, height - 80, Gfx.FONT_MEDIUM, cycle, Gfx.TEXT_JUSTIFY_LEFT);
    	dc.drawText(width/2, height - 58, Gfx.FONT_MEDIUM, dateString, Gfx.TEXT_JUSTIFY_CENTER);        
    	dc.drawText(width - 39, height - 80, Gfx.FONT_MEDIUM, Calendar.info(Time.now(), Time.FORMAT_LONG).day_of_week, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    hidden function displaySemiRound(dc, width, height) {
    	dc.drawLine(30, height - 15, width - 30, height - 15);
		dc.drawText(width - 30, height/4 - 38, Gfx.FONT_MEDIUM, batteryString, Gfx.TEXT_JUSTIFY_RIGHT);
		dc.drawText(30, height - 40, Gfx.FONT_MEDIUM, cycle, Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawText(width - 30 ,height - 40, Gfx.FONT_MEDIUM, dateString, Gfx.TEXT_JUSTIFY_RIGHT);        
   		dc.drawText(width - 30, height - 60, Gfx.FONT_MEDIUM, Calendar.info(Time.now(), Time.FORMAT_LONG).day_of_week, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    hidden function setDate() {
    	var date = Calendar.info(Time.now(), Time.FORMAT_LONG);
        if (date.day == 2 || date.day == 22) {
        	dateString= Lang.format("$1$ $2$nd, $3$", [date.month, date.day, date.year]); 
        }
        else if (date.day == 3 || date.day == 23) {
        	dateString= Lang.format("$1$ $2$rd, $3$", [date.month, date.day, date.year]); 
        }
        else if (date.day == 1 || date.day == 21 || date.day == 31) {
        	dateString= Lang.format("$1$ $2$st, $3$", [date.month, date.day, date.year]); 
        }
        else {
        	dateString= Lang.format("$1$ $2$th, $3$", [date.month, date.day, date.year]); 
        }
    }
    
    hidden function setCycle(hour) {
	    if (hour < 12) {
        	cycle = "AM"; 
        }
        else {
        	cycle = "PM"; 
        }
    }
    
    function battery(dc){
    	dc.drawRectangle(width/2 - 8, 7, 16, 10);
    	dc.fillRectangle(width/2 + 8, 9, 3, 6);
    	var percent = Sys.getSystemStats().battery.toNumber().toDouble()/100.toDouble();
    	if (percent <= .2) {
    		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	}
    	dc.fillRectangle(width/2 - 6, 9, 12 * percent, 6);
    	if (percent < .1 && percent > .03) {
    		dc.fillRectangle(width/2 - 6, 9, 1, 6);
    	}
    }
}