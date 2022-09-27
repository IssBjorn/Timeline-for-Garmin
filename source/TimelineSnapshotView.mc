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
var todisplay = Application.Storage.getValue("ttd");
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
var ARCTOS = null;
var CANINE = null;
var WILY = null;
var REPTILE = null;
class TimelineSnapshotView extends WatchUi.View {





    function initialize() {
        View.initialize();
    tent = new WatchUi.Bitmap({:rezId=>Rez.Drawables.tent,:locX=>70,:locY=>50});
    stefoscope = new WatchUi.Bitmap({:rezId=>Rez.Drawables.stefoscope,:locX=>70,:locY=>50});
    vehicle = new WatchUi.Bitmap({:rezId=>Rez.Drawables.vehicle,:locX=>70,:locY=>50});
    sports = new WatchUi.Bitmap({:rezId=>Rez.Drawables.sports,:locX=>70,:locY=>50});
   heart = new WatchUi.Bitmap({:rezId=>Rez.Drawables.heart,:locX=>70,:locY=>50});
    beast = new WatchUi.Bitmap({:rezId=>Rez.Drawables.beast,:locX=>70,:locY=>50});
    ARCTOS = new WatchUi.Bitmap({:rezId=>Rez.Drawables.bear,:locX=>70,:locY=>50});
    CANINE = new WatchUi.Bitmap({:rezId=>Rez.Drawables.dog,:locX=>70,:locY=>50});
    WILY = new WatchUi.Bitmap({:rezId=>Rez.Drawables.fox,:locX=>70,:locY=>50});
    REPTILE = new WatchUi.Bitmap({:rezId=>Rez.Drawables.turtle,:locX=>70,:locY=>50});
    
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
      var ttd = null;
      var len2 = arr.size();
      System.println("len2:" + len2);
      curr = arr[0];
      System.println("curr: " + curr);
   if (arr3.size() > 1) {  
    for(var j=0; j < (len2); j+=1) {
    System.println("j: " + j);
    var time1 = (number - arr[j]).abs();
    
    var time2 = (number - curr).abs();
    
    
    System.println("times: " + time1 + "," + time2);
         if (time1 < time2) {
             curr = arr[j].abs();
            var string = arr2[j];
            typetodisplay = arr3[j];
       
             System.println(typetodisplay);
             System.println("curr: " + curr);
              
             nex = string;
             ttd = typetodisplay;
             Application.Storage.setValue("next", nex);
             Application.Storage.setValue("ttd", ttd);
             System.println("nex: " + nex);
             
             System.println("len:" + len);    
       
       repeat = 1; add = 1;
        
             }
             
          }      
      }
          }
           
           }
           
       
           }}
        
        
       if (next != null){
       dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_TRANSPARENT);
        dc.drawText(snapw, snaph+30, Graphics.FONT_MEDIUM, next.substring(17, next.length()), Graphics.TEXT_JUSTIFY_CENTER);
        
        var yes = null;
         if (next.find("camping") != null) {
         System.println("disp: " + todisplay);
         yes = "yes";
         tent.draw(dc);
         }
         if (next.find("hospital") != null || next.find("baby") != null || next.find("appointment") != null || next.find("meds") != null || next.find("medical") != null) {
         yes = "yes";
         stefoscope.draw(dc);
         }
         if (next.find("trip") != null || next.find("service") != null || next.find("garage") != null) {
         yes = "yes";
         vehicle.draw(dc);
         }
         if (next.find("race") != null || next.find("run") != null || next.find("cross country") != null) {
         yes = "yes";
         flag.draw(dc);
         }
         if (next.find("tournament") != null || next.find("sports") != null || next.find("the game") != null || next.find("baseball") != null) {
         yes = "yes";
         sports.draw(dc);
         }
         if (next.find("anniversary") != null || next.find("date night") != null || next.find("wedding") != null) {
         yes = "yes";
         heart.draw(dc);
         }
         if (next.find("zoo") != null || next.find("farm") != null || next.find("vet") != null) {
         yes = "yes";
         beast.draw(dc);
         }
          System.println(yes);
         if (yes == null)
         {
         if (todisplay.find("reminder") !=null){
         System.println("working");
         ARCTOS.draw(dc);}
         if (todisplay.find("timer") !=null){
         CANINE.draw(dc);}
         if (todisplay.find("event") !=null){
         WILY.draw(dc);}
         if (todisplay.find("record") !=null){
         REPTILE.draw(dc);}
         }
         }
        
    
    
    
}


           function onShow() {
           Application.Storage.setValue("next",null);
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