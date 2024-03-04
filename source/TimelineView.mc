import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Communications;
var annum = null;
var colour = 1;
var cadd = 0;
var cminus = 0;
var Date = null;
var option = 1;
var ChosenMonth = null;
var ChosenYear = null;
var DataArray = null;

var ChosenDay = null;
var Description = "";
var Hour = null;
var Minutes = null;
var max = 0;
var min = 0;
var inputStr = "";
var newStr = "";
var type = null;
var pins = Application.Storage.getValue("pins");
var typeto = Application.Storage.getValue("type");
var scrollSelect = null;
var list = null;
var TimelineArr = [];
var wi =null;
var he = null;
var mYOffset = 35;
enum {
  SCREEN_SHAPE_CIRC = 0x000001,
  SCREEN_SHAPE_SEMICIRC = 0x000002,
  SCREEN_SHAPE_RECT = 0x000003
}
class TimelineView extends WatchUi.View {
var Pebble2 = null;
var pos = null;
var pos2 = null;
var Tpos = null;
var Tpos2 = null;
var index = 0;
var vert_layout = false;
    var canvas_h = 0;
    var canvas_w = 0;
    var canvas_shape = 0;
    var canvas_rect = false;
    var canvas_circ = false;
    var canvas_semicirc = false;
    var canvas_tall = false;
    var canvas_r240 = false;
  var icon1 = null;
    var icon2 = null;
     
    function initialize() {
        View.initialize();
        
    }

    // Load your resources here
    function onLayout(dc) {
   // find out the type of screen on the device
      canvas_tall = (vert_layout && canvas_shape == SCREEN_SHAPE_RECT) ? true : false;
      canvas_rect = (canvas_shape == SCREEN_SHAPE_RECT && !vert_layout) ? true : false;
      canvas_circ = (canvas_shape == SCREEN_SHAPE_CIRC) ? true : false;
      canvas_semicirc = (canvas_shape == SCREEN_SHAPE_SEMICIRC) ? true : false;
      canvas_r240 =  (canvas_w == 240 && canvas_w == 240) ? true : false;
    }
    
    
    
    
    function timerCallback() as Void {
    	WatchUi.requestUpdate();
	}

    // Update the view
    function onUpdate(dc) {
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
       dc.clear();
       dc.setColor(Graphics.COLOR_TRANSPARENT,Graphics.COLOR_WHITE);
       
       if (he == null){
        he= dc.getHeight();}
       if (wi == null) {
       wi = dc.getWidth();
       }
      
     View.onUpdate(dc); 
     
     
     
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
      
      if (animation <= 3){
      points = [[wi/2 - 2,he/2 - 2],[wi/2 + 2,he/2 - 2],  [wi/2 + 2, he/2 + 2],[ wi/2 - 2, he/2 + 2]];  }
      if (animation <= 3 && animation > 2){
      points = [[wi/2 - 40,he/2 + 40],[wi/2 - 60,he/2 + 65],  [wi/2 - 20, he/2 - 20],[ wi/2 + 70, he/2 - 50],[  wi/2 + 30, he/2 + 80]];}
      if (animation == 4){
        points = [[0,0],[wi,0],[wi, he],[0, he]];
      }
       if (points.size() > 0){
      dc.fillPolygon(points);}
      
       if (animation != 4) { 
      animation = animation + 1;}
     
     
     

     
    if (animation == 4) {
    
         
         
     
          
        
 
    
     
       
          
       
       if (list == null || list.size() == 0){
     dc.drawText(70,140, Pebble, "ZILCH GOIN ON", Graphics.TEXT_JUSTIFY_CENTER);
     }
     dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
      if (list != null && list.size() > 0 && scrollSelect != null){

     //System.println(list[scrollSelect]);
      
  
	 if (showSelected == null){  
	
    if (WatchUi has :getSubscreen){
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    dc.fillRectangle(170, 0, 80, 300);
    }
    else {
     if (n == 1){
     
    
     dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
     dc.fillRectangle(170, 0, 80, 300);
    }
 
     if (o == 1){
     
     dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
     dc.fillRectangle(170, 0, 80, 300);
     }     
        // Call the parent onUpdate function to redraw the layout
     } 
     if (list[scrollSelect].find("timer")!=null){ 
      pos = 16;
       Tpos = 4;
       icon1 = "=";
      }
     else if (list[scrollSelect].find("event")!= null){
      pos = 23;
      Tpos = 11;
      icon1 = "]";
     }
     else if (list[scrollSelect].find("reminder")!= null){
      pos = 26;
      Tpos = 11;
      icon1 = "<";
     } 
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
      dc.drawText(70,20, Pebble,list[scrollSelect].substring(Tpos, Tpos+5), Graphics.TEXT_JUSTIFY_CENTER);
       dc.drawText(80,45, Pebble,list[scrollSelect].substring(pos, pos+5) + "...", Graphics.TEXT_JUSTIFY_CENTER);
      dc.drawText(200,45, Pebble,icon1, Graphics.TEXT_JUSTIFY_CENTER);
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      dc.drawText(200,45, Pebble2,icon1, Graphics.TEXT_JUSTIFY_CENTER);

   if (list.size() > 1 && scrollSelect > 0){   
    if (list[scrollSelect-1].find("timer")!=null){ 
      pos2 = 16;
       Tpos2 = 4;
      icon2 = "=";
      }
     else if (list[scrollSelect-1].find("event")!= null){
      pos2 = 23;
      Tpos2 = 11;
      icon2 = "]";
     }
     else if (list[scrollSelect-1].find("reminder")!= null){
      pos2 = 26;
      Tpos2 = 11;
      icon2 = "<";
     }
           dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
      dc.drawText(70,130, Pebble, list[scrollSelect-1].substring(Tpos2, Tpos2+5), Graphics.TEXT_JUSTIFY_CENTER);
       dc.drawText(80,155, Pebble, list[scrollSelect-1].substring(pos2, pos2+5) + "...", Graphics.TEXT_JUSTIFY_CENTER);
      dc.drawText(200,155, Pebble,icon2, Graphics.TEXT_JUSTIFY_CENTER);
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
      dc.drawText(200,155, Pebble2,icon2, Graphics.TEXT_JUSTIFY_CENTER);
      
     
      
      }
      }
	  else {
	  var str = list[scrollSelect].substring(pos, list[scrollSelect].length());
	   var font_height = dc.getFontHeight(Pebble);
	  
	var length_of_str = str.length();
          var current_string = "";
          var lastvalue = 0;
          var length = 0;

          // padding for display text
          var padding_top = 45;
          var padding_bottom = 10;
          var padding_sides = 45;

          var x_pos = 0;
          //var y_pos = 50;
          var y_pos = mYOffset + padding_top;
          var max_width = wi - padding_sides;
          var y_cal = 0;
          var r = wi;
          var x1 = 0;


           // draw multi-line text
           dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

           // here, we loop thru each character
           for (var l=0; l <= length_of_str; l++) {

              // are we rendering text in a circle?
              if (canvas_circ) {

                  y_cal = y_pos + (font_height/2);

                // if so, calculate max_width based on position across a circle

                 if (y_pos > (r/2)) {
                   x1 = r - (-y_cal+r);
                 } else {
                   x1 = r - (y_cal);
                 }

                 // remember pythagoras theorem?
                 max_width = (Math.sqrt((r*r) - (x1*x1))) - padding_sides;

              }

              // let's grab the current section of text + next character, and it's calc it's length
              current_string = str.substring(lastvalue, l);
              length = dc.getTextWidthInPixels(current_string, Pebble);

              if ( (y_pos+font_height) < (he - padding_bottom) ) {

                  // have we reached a space, and near the end of the line? then truncate...
                  if ( (l>1) && (str.substring(l-1,l).equals(" ")) && (length > (max_width*5/6)) ) {

                     dc.drawText(wi/2,y_pos,Pebble, current_string ,Graphics.TEXT_JUSTIFY_CENTER);
                     y_pos = y_pos + font_height;
                     lastvalue = l;

                  // otherwise, have we exceeded the length?
                  } else if (length > max_width) {

                     dc.drawText(wi/2,y_pos,Pebble, current_string ,Graphics.TEXT_JUSTIFY_CENTER);
                     y_pos = y_pos + font_height;
                     lastvalue = l;

                  // if not, are we at the last section?
                  } else if (l == length_of_str) {

                     dc.drawText(wi/2,y_pos,Pebble, current_string ,Graphics.TEXT_JUSTIFY_CENTER);
                     y_pos = y_pos + font_height;
                     lastvalue = l;

                  }


              }

         }
	  
	  }
      }
  
     
     }
    } 
    
   
   
    
    
    function onShow(){
    Pebble2 = WatchUi.loadResource(Rez.Fonts.pebble2);
    list = Application.Storage.getValue("next");
     if (list != null && list.size() > 0){
     scrollSelect = list.size() - 1;
   
     }
    }
    
    
    
    function onHide(){
    list = null;
    }
    
    
    }
    class PinAddView extends WatchUi.View {
  
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
   
     
    }
    
    function timerCallback() as Void {
    	WatchUi.requestUpdate();
	}
	
	function onShow(){
	
	}

    // Update the view
    function onUpdate(dc) {

      
     View.onUpdate(dc); 
    
   // dc.setClip(dc.getWidth() - 40, 0, 0, dc.getHeight());
         dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
       dc.clear();
       dc.setColor(Graphics.COLOR_TRANSPARENT,Graphics.COLOR_WHITE);
     
    
    
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    dc.fillRectangle(dc.getWidth() - 60, 0, 60, dc.getHeight());
    

    var x = dc.getWidth()/2;
     var y = dc.getHeight()/4;
     var TextArr = [];
     var yy = null;
     dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    if (type != null && type.find("event") != null || type.find("reminder") != null) {  
        
     TextArr = [ChosenYear,ChosenMonth,ChosenDay,Hour,Minutes,Description];
     yy = y;}
     else {TextArr = [ChosenDay,Hour,Minutes,Description];
     yy = y-15;}
    for (var i=0; i<TextArr.size(); i++){
    if (TextArr[i] != null){
 
   dc.drawText(x, yy, Pebble, TextArr[i], 1|4);}
   else {
   dc.drawText(x, yy + 30, Pebble, "NOT SET", 1|4);
   }  
    yy = yy + 30;
       
       }
       dc.setPenWidth(4);
      dc.drawCircle(dc.getWidth() - 60, y + 80, 4);
    
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       dc.drawCircle(dc.getWidth() - 30, y + 80, 40);
            
  if (DataArray != null) {
   dc.drawText(dc.getWidth() - 30, y + 80,  Pebble, DataArray[select] , 1|4);
 // dc.clearClip();
   if (select == DataArray.size() - 1){
   dc.drawText(dc.getWidth() - 30, y,      Pebble, DataArray[select - 2] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 40, Pebble, DataArray[select - 1] , 1|4);
   
   dc.drawText(dc.getWidth() - 30, y + 120,  Pebble, DataArray[0] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 160,  Pebble, DataArray[1] , 1|4); 
   }
   if (select == DataArray.size() - 2){
   dc.drawText(dc.getWidth() - 30, y,      Pebble, DataArray[select - 2] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 40, Pebble, DataArray[select - 1] , 1|4);
   
   dc.drawText(dc.getWidth() - 30, y + 120,  Pebble, DataArray[DataArray.size() - 1] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 160,  Pebble, DataArray[0] , 1|4); 
   }
   if (select >= 2 && select < DataArray.size() - 2) {
   dc.drawText(dc.getWidth() - 30, y,      Pebble, DataArray[select - 2] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 40, Pebble, DataArray[select - 1] , 1|4);
   
   dc.drawText(dc.getWidth() - 30, y + 120,  Pebble, DataArray[select + 1] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 160,  Pebble, DataArray[select + 2] , 1|4); 

   }              
   else if (select == 1){
   dc.drawText(dc.getWidth() - 30, y,      Pebble, DataArray[DataArray.size() - 1] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 40, Pebble, DataArray[select - 1] , 1|4);
   
   dc.drawText(dc.getWidth() - 30, y + 120,  Pebble, DataArray[select + 1] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 160,  Pebble, DataArray[select + 2] , 1|4); 

  }
   else if (select == 0){
   dc.drawText(dc.getWidth() - 30, y,      Pebble, DataArray[DataArray.size() - 2] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 40, Pebble, DataArray[DataArray.size() - 1] , 1|4);
   
   dc.drawText(dc.getWidth() - 30, y + 120,  Pebble, DataArray[select + 1] , 1|4);
   dc.drawText(dc.getWidth() - 30, y + 160,  Pebble, DataArray[select + 2] , 1|4); 

   }
  
       }  
         
     
     
  if (type.find("event") != null || type.find("reminder") != null) {    
   if (option == 1) {
 
if (ChosenYear == null){
if (type.find("event") != null){
DataArray = [annum.toNumber().toString(),(annum.toNumber()+1).toString(), (annum.toNumber()+2).toString(), (annum.toNumber()+3).toString(), (annum.toNumber()+4).toString(),(annum.toNumber()+5).toString(),"]"];

max = 7;}
else {
DataArray = [annum.toNumber().toString(),(annum.toNumber()+1).toString(), (annum.toNumber()+2).toString(), (annum.toNumber()+3).toString(), (annum.toNumber()+4).toString(),(annum.toNumber()+5).toString()];
max = 6;
}}}
if (option == 2 && ChosenMonth == null && ChosenYear != null){
if (type.find("event") != null && ChosenYear.find("RPT ") != null){
DataArray = ["01","02","03","04","05","06","07","08","09","10","11","12","]"];
max = 13;}
else {DataArray = ["01","02","03","04","05","06","07","08","09","10","11","12"];
max = 12;}}
if (option == 3 && ChosenMonth != null && ChosenDay == null) {
DataArray = null;
if (DataArray == null){
getLeapYear();
DataArray = Date; }
}}
else if (option == 1){
DataArray = ["MON","TUE","WED","THU","FRI","SAT","SUN","]"];
max = 8;
}
if (option == 4) {
DataArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","00"];
max = 24;
}
if (option == 5) {
DataArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","00"];
max = 60;
}

if (option == 6){
DataArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"," ","OK"];
max = 28;
}


         }
         
         
         
         
         
        function getLeapYear() {
        var filter = ["01","03","05","07","08","10","12"];
     
    
    if (ChosenMonth.find("02") != null){  
   var result = (ChosenYear / 4);
   result = result.toString();
    if (result.find(".") == null) {
     result = (ChosenYear / 100);
     result = result.toString();
     if (result.find(".") != null) {
     Date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29"];
        max = 29;
     }
     else {
     
     result = (ChosenYear / 400);
     result = result.toString();
     if (result.find(".") != null) {
     Date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29"];
        max = 29;
     }
     
     else {
     Date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
        max = 28;
     }
     
     }
     
     }
     
    
    else {
    Date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28"];
     max = 28;
    }
    }
    else if (ChosenMonth.find("02") == null) {
    
    if (filter.indexOf(finalStr.substring(5,7)) != -1) {
      Date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
      max = 31;}
    else {
    Date = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"];
     max = 30;
    }
    }
        
    
        }
         
         
         }
         
 class NumberDelegate extends WatchUi.BehaviorDelegate {  



  
  
  public function initialize() {
        BehaviorDelegate.initialize();
    }
    
      public function onKey(event) as Boolean {
        var key = event.getKey();
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            return onSelect();
        } else if (key == WatchUi.KEY_ESC || key == WatchUi.KEY_LAP) {
            return onBack();
        } else if (key == WatchUi.KEY_UP || key == WatchUi.KEY_MODE) {
            return controlPre();
        } else if (key == WatchUi.KEY_DOWN || key == WatchUi.KEY_CLOCK) {
            return controlNex();
        }
        return false;
    }
    
     function onSwipe(swipeEvent) as Boolean
    {    
    var swi = swipeEvent.getDirection();
         if (swi == WatchUi.SWIPE_DOWN){
         return controlNex();}
         if (swi == WatchUi.SWIPE_UP){
              return controlPre();
         }
           WatchUi.requestUpdate();
       
      return true;  
      }
     
     
     
     function controlPre() as Boolean { 
   
    
    
     if (select > min) {
    select = select - 1;}
    else if (select == min){
  
    select = (max - 1);}
    
	
        WatchUi.requestUpdate();
        return true;
    }
    
    
    
    
    
    function controlNex() as Boolean {
    
    
    if (select < max - 1) {
    select = select + 1;}
    else if (select == (max - 1)) {
    
    select = min;}
    

    WatchUi.requestUpdate();
        return true;
    }
    



public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
      ChosenMonth = null;
 ChosenYear = null;
 DataArray = null;
 ChosenDay = null;
 Description = "";
 Hour = null;
Minutes = null;
 option = 1;
 Date = null;
  max = 0;
  min = 0;
    select = 0;
    }



public function onSelect() as Boolean {
       
        
      if (type.find("event") != null || type.find("reminder") != null) {   
        if (option == 1 && DataArray != null){
       if (DataArray[select].find("]") == null){
        ChosenYear = DataArray[select];}
       else {
       ChosenYear = "RPT ";
       }
       
    DataArray = null;
    option = 2;
    
   
        select = 0;
       
    }
    
    if (option == 2 && DataArray != null){
    
    
     ChosenMonth = DataArray[select];
         DataArray = null;
    option = 3;
    
    select = 0;}
    
    if (option == 3 && DataArray != null){
      if (DataArray[select].find("]") == null){
        ChosenDay = DataArray[select];}
       else {
       ChosenDay = "RPT";
       }
     DataArray = null;
    option = 4;
    
    select = 0;
    }
    }
    
    else if (type.find("timer") != null && option == 1 && DataArray != null){
    ChosenDay = DataArray[select];
     select = 0;
     DataArray = null;
     option = 4;
    }
    
    if (option == 4 && DataArray != null){
       Hour = DataArray[select];
       select = 0;
       DataArray = null;
       option = 5;
    }
    if (option == 5 && DataArray != null){
       Minutes = DataArray[select];
        select = 0;
        DataArray = null;
        option = 6;
    }
    if (option == 6 && DataArray != null){
    if (DataArray[select].find("OK") == null){
       Description = Description + DataArray[select];}
    else if (DataArray[select].find("OK")  != null && type.find("event") != null || type.find("reminder") != null){
    DataArray = null;
         inputStr = ChosenYear + "." + ChosenMonth + "." + ChosenDay + "," + Hour + ":" + Minutes + "," + type + "," + Description;
          ChosenYear = null;
            ChosenMonth = null;
 DataArray = null;
 ChosenDay = null;
 Description = "";
 Hour = null;
Minutes = null;
 option = 1;
 Date = null;
  max = 0;
  min = 0;
    select = 0;
if (old != null && next != null && old.size() + next.size() > 10) {
toDelete = Application.Storage.getValue("old");
       toDelete = toDelete.remove(toDelete[old.size()-1]);
       Application.Storage.setValue("old",toDelete);
}
else {

}
         WatchUi.pushView(new TimelineSnapshotView(), new TimelineSnapshotDelegate(), WatchUi.SLIDE_UP);
 
        } 
    else if (DataArray[select].find("OK") != null && type.find("timer") != null){
    DataArray = null;
          inputStr = ChosenDay + "," + Hour + ":" + Minutes + "," + type + "," + Description;
          ChosenMonth = null;
 ChosenYear = null;

 DataArray = null;
 ChosenDay = null;
 Description = "";
 Hour = null;
Minutes = null;
 option = 1;
 Date = null;
  max = 0;
  min = 0;
    select = 0;
     
         WatchUi.pushView(new TimelineSnapshotView(), new TimelineSnapshotDelegate(), WatchUi.SLIDE_UP);
        }
        
       
    }
 
    }
     
}
