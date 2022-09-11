import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time.Gregorian;
import Toybox.Timer;
import Toybox.Application;
var now = System.getClockTime();
var add = 1;
var t1 = null;
var t2 = null;
var t3 = Application.Storage.getValue("t3");
var ts = null;
var read = null;
var typetoread = null;
var dateTimeString = "";
var next = Application.Storage.getValue("next");
var repeat = null;
var timer;
var curr = null;
var arr3 = null;
var arr2 = null;
var arr = null;
var typetodisplay = null;
var tent = null;
var stefoscope = null;
var vehicle = null;
var sports = null;
var heart = null;
var beast = null;
class TimelineSnapshotView extends WatchUi.View {





    function initialize() {
        View.initialize();
    tent = new WatchUi.Bitmap({:rezId=>Rez.Drawables.tent,:locX=>173,:locY=>50});
    //stefoscope = new WatchUi.Bitmap({:rezId=>Rez.Drawables.stefoscope,:locX=>100,:locY=>100});
    vehicle = new WatchUi.Bitmap({:rezId=>Rez.Drawables.vehicle,:locX=>100,:locY=>150});
    //sports = new WatchUi.Bitmap({:rezId=>Rez.Drawables.sports,:locX=>100,:locY=>100});
   // heart = new WatchUi.Bitmap({:rezId=>Rez.Drawables.heart,:locX=>100,:locY=>100});
    //beast = new WatchUi.Bitmap({:rezId=>Rez.Drawables.beast,:locX=>100,:locY=>100});
    
    }

    // Load your resources here
    function onLayout(dc) {
        timer = new Timer.Timer();
        timer.start(method(:timerCallback), 10000, true);
     
    }
    
    function timerCallback() {
    	WatchUi.requestUpdate();
	}
    
    // Update the view
    function onUpdate(dc) {
    View.onUpdate(dc);
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
       dc.clear();
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    System.println(type);
      
            
      
        // Call the parent onUpdate function to redraw the layout
       
       var snaph = dc.getHeight()/2;
       var snapw = dc.getWidth()/2;
       var next = Application.Storage.getValue("next");
       var pinarray = Application.Storage.getValue("pins");

       var typetoread = Application.Storage.getValue("type");
      
     var skip = 1;  
       
       if (pinarray != null) {
       
       read = pinarray;
       
       
       }

       
       
 if(arr==null){arr = new [0];}
 if(arr2==null){arr2 = new [0];}
 if(arr3==null){arr3 = new [0];}
var i = null;
   if (read != null){   
       var len = read.size();
      if (repeat == 0) {
       for(i=0; i < len; i+=1) {
         System.println("read:" + read[i]);
         System.println("read:" + read);
           dateTimeString = read[i].toString();
           System.println("datetimestring:" + dateTimeString);
              var options={
:year => dateTimeString.substring(6,10).toNumber(),
:month => dateTimeString.substring(3,5).toNumber(),
:day => dateTimeString.substring(0,2).toNumber(),
:hour => dateTimeString.substring(11,13).toNumber(),
:minute => dateTimeString.substring(14,16).toNumber(),
:seconds => dateTimeString.substring(14,16).toNumber()};

ts = Gregorian.moment(options);
           
   if (ts != null && dateTimeString.length() > 1 && arr2.size() != pinarray.size()){
           t1 = ts.value(); 
           System.println("t1:" + t1);
         
         if (i==0) {
           arr.add(t1);
           arr2.add(read[i]);}
         
         if ( i>0 && read[i] != read[i-1]) {
           arr.add(t1);
           arr2.add(read[i]);}
         
   if (typetoread != null){
           arr3.add(typetoread[i]);   }
           System.println("arr:" + arr);
           System.println("arr2:" + arr2);
           System.println("i:"+ i);
          }
         

        
        if (i == (len - 1)) {
           var currtime = Time.now().value();
           System.println("currtime: " + currtime); 
     

      System.println("arr3:" + arr3);
      var number = currtime;
      var nex = null;
      var len2 = arr.size();
      System.println("len2:" + len2);
      curr = arr[0];
      System.println("curr: " + curr);
   if (arr3.size() > 1) {  
    for(var j=0; j < (len2  - 1); j+=1) {
    System.println("j: " + j);
    var time1 = (number - arr[j]).abs();
    
    var time2 = (number - curr).abs();
    
    
    System.println("times: " + time1 + "," + time2);
         if (time1 < time2) {
             curr = arr[j].abs();
            var string = arr2[j];
            if (typetoread != null){
             typetodisplay = arr3[j];}
             System.println("curr: " + curr);
              
             nex = string;
             Application.Storage.setValue("next", nex);
             System.println("nex: " + nex);
             
             System.println("len:" + len);    
       
       repeat = 1; add = 1;
        
             }
             
          }      
      }
          }
           
           }
           
       
           }}
        
        
       
       dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_TRANSPARENT);
        dc.drawText(snapw, snaph, Graphics.FONT_MEDIUM, next.substring(17, next.length()), Graphics.TEXT_JUSTIFY_CENTER);
         var camping = next.find("camping");
         //var medical = next.find("hospital") || next.find("appointment");
         //var car = next.find("serviced") || next.find("trip")) != null);
         //var race = next.find("race") || next.find("run");
         //var sport = next.find("baseball") || next.find("football") || next.find("tournament");
         //var romance = next.find("wedding") || next.find("date") || next.find("anniversary");
         //var animal = next.find("zoo") || next.find("farm") || next.find("vet");
         
         if (camping != null) {
         System.println("yes!");
         tent.draw(dc);
         }
         //else if (medical != null) {
         //dc.draw(stefoscope);
         //}
         //else if (car != null) {
         //dc.draw(vehicle);
         //}
         //else if (race != null) {
         //dc.draw(flag);
         //}
         //else if (sport != null) {
         //dc.draw(sports);
         //}
         //else if (romance != null) {
         //dc.draw(heart);
         //}
         //else if (animal != null) {
         //dc.draw(beast);
         //}
         else { dc.drawText(snapw, snaph, Graphics.FONT_SMALL, typetodisplay, Graphics.TEXT_JUSTIFY_CENTER);}
         
         
         
        
    
    
    
}


           function onShow() {
              repeat = 0;
        if (type != null) {
    
          if(pins==null){pins = new [0]; System.println(pins + "," + "yes!");}
            
            if (typeto==null){typeto = new [0];}


          
            var p = inputStr + newStr;
            var newarr = pins.add(p);
            var pintype = type;
            var typetoadd = typeto.add(pintype);
            Application.Storage.deleteValue("pins");
            Application.Storage.setValue("pins", newarr);
            Application.Storage.deleteValue("type");
            Application.Storage.setValue("type",typetoadd);
            
           }
           
           
           }


}