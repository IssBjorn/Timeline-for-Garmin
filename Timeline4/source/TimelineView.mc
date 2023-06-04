import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
var colour = 1;
var cadd = 0;
var cminus = 0;
class TimelineView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    timer = new Timer.Timer();
        timer.start(method(:timerCallback), 30, true);
     
    }
    
    function timerCallback() as Void {
    	WatchUi.requestUpdate();
	}

    // Update the view
    function onUpdate(dc) {
    
      
     View.onUpdate(dc); 
     
     if (cadd < 320 && cminus != -20){
     cadd = cadd+20;}
     
     if (cminus > 0 && cadd != 320){
     cminus = cminus-20;}
     

     
     System.println(next);
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
       dc.clear();
       dc.setColor(Graphics.COLOR_TRANSPARENT,Graphics.COLOR_WHITE);
     dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
     if (next.find("Mon")!=null ||  next.find("Tue")!=null ||  next.find("Wed")!=null ||  next.find("Thu")!=null ||  next.find("Fri")!=null || next.find("Sat")!=null ||  next.find("Sun")!=null){ 
      dc.drawText(70,19, Graphics.FONT_TINY, next.substring(10, next.length()), Graphics.TEXT_JUSTIFY_CENTER);
      }
      
     else{
     dc.drawText(70,19, Graphics.FONT_TINY, next.substring(16, next.length()), Graphics.TEXT_JUSTIFY_CENTER);
     }
     if (colour == 2){
     
     
     dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
     dc.fillRectangle(170, 0, 80, 300);
    }
    else if (colour == 1){
     
     dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
     dc.fillRectangle(170, 0, 80, 300);
     }     
      
     if (colour == 1){
     
     
     dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
     dc.fillRectangle(170, cminus, 80, 300);
    }
    else if (colour == 2){
     
     dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
     dc.fillRectangle(170, 0, 80, cadd);
     }     
        // Call the parent onUpdate function to redraw the layout
       
    } }
