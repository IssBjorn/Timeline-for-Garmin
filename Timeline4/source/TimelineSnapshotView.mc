import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Timer;
import Toybox.Application;
import Toybox.Lang;
var now = System.getClockTime();
var next = Application.Storage.getValue("next");
var add = 1;
var t1 = null;
var t2 = null;
var t3 = Application.Storage.getValue("t3");
var ts = null;
var read = null;
var typetoread = null;
var todisplay = Application.Storage.getValue("ttd");
var dateTimeString = "";

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
var PictureTime = null;
var yes = null;
var nex = null;
var date = null;
var ttd = null;
class TimelineSnapshotView extends WatchUi.View {





    function initialize() {
        View.initialize();
        
    }

    // Load your resources here
    function onLayout(dc) {
       timer = new Timer.Timer();
        timer.start(method(:timerCallback), 1000, true);
    }
    

    
    function timerCallback() as Void {
    	WatchUi.requestUpdate();
	}
    
    // Update the view
    function onUpdate(dc) {
    
    
    View.onUpdate(dc);
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
       dc.clear();
       dc.setColor(Graphics.COLOR_TRANSPARENT,Graphics.COLOR_WHITE);
   
      
            
      
        // Call the parent onUpdate function to redraw the layout
       
       var snaph = dc.getHeight()/2;
       var snapw = dc.getWidth()/2;
       
       var pinarray = Application.Storage.getValue("pins");
       
       var typetoread = Application.Storage.getValue("type");
      

       
       if (pinarray != null) {
       
       read = pinarray;
       
       
       }

       
if (PictureTime != null) {       
 if(arr==null){arr = new [0];}
 if(arr2==null){arr2 = new [0];}
 if(arr3==null){arr3 = new [0];}
var d = "01";
var i = null;
   if (read != null){   
       var len = read.size();
      if (repeat == 0) {
       for(i=0; i < len; i+=1) {
         System.println("read:" + read[i]);
         System.println("read:" + read);
           dateTimeString = read[i].toString();
           System.println("datetimestring:" + dateTimeString);
           System.println("typetoread:" + typetoread[i]);
    if (typetoread[i].find("reminder") != null || typetoread[i].find("record") != null){ 
    System.println("if works");       
             var options={
:year => dateTimeString.substring(6,10).toNumber(),
:month => dateTimeString.substring(3,5).toNumber(),
:day => dateTimeString.substring(0,2).toNumber(),
:hour => dateTimeString.substring(11,13).toNumber(),
:minute => dateTimeString.substring(14,16).toNumber(),
:seconds => dateTimeString.substring(14,16).toNumber()};
date = options;}
    
    if (typetoread[i].find("timer") != null || typetoread[i].find("event") != null ){  
    var dayGiven = dateTimeString.substring(0,3);
    var cd = 1;
    System.println(dayGiven);
    if (dayGiven != null) {
    if (dayGiven.find("MON") != null ){
    
    d = "1";}
    else if (dayGiven.find("TUE") != null ){
    d = "2";}
    else if (dayGiven.find("WED") != null ){
    d = "3";}
    else if (dayGiven.find("THU") != null ){
    d = "4";}
    else if (dayGiven.find("FRI") != null ){
    d = "5";}
    else if (dayGiven.find("SAT") != null ){
    d = "6";}
    else if (dayGiven.find("SUN") != null ){
    d = "7";}
    System.println("day: " + d);
    
    var Tdow = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    var Dow = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    Dow = Dow.day_of_week;
    System.println("Dow: " + Dow);
    if (Dow.find("MON") != null ){
    cd = 1;}
    else if (Dow.find("Tue") != null ){
    cd = 2;}
    else if (Dow.find("Wed") != null ){
    cd = 3;}
    else if (Dow.find("Thu") != null ){
    cd = 4;}
    else if (Dow.find("Fri") != null ){
    cd = 5;}
    else if (Dow.find("Sat") != null ){
    cd = 6;}
    else if (Dow.find("Sun") != null ){
    cd = 7;}
    System.println("cd: " + cd);
    var moy = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    var annum = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    
    Tdow = Lang.format("$1$", [
    Tdow.day.format("%02u")]);
    moy = Lang.format("$1$", [
    moy.month.format("%02u")]);
    annum = Lang.format("$1$", [
    annum.year.format("%04u")]);
    var bdow = Tdow.toNumber();
    var nmdow = moy.toNumber();
    var Ddow = d.toNumber();
    
    System.println("currdate: " + Tdow + "/" + moy + "/" + annum);
    System.println("calculation: " + cd + "-" + Ddow + "+" + bdow);
    var NdD = (bdow + (Ddow - cd)%7);
    System.println("NdD: " + NdD);
    
    if (bdow > NdD){
    nmdow = (nmdow + 1);

    }
    if (bdow > NdD && nmdow == 12){
    annum = (annum + 1);}
    if (NdD > 31){
    NdD = (NdD - 31);}
             var options={
:year => annum.toNumber(),
:month => nmdow.toNumber(),
:day => NdD.toNumber(),
:hour => dateTimeString.substring(0,2).toNumber(),
:minute => dateTimeString.substring(3,5).toNumber(),
:seconds => dateTimeString.substring(3,5).toNumber()};
date = options;
 }}
if (date != null) {
ts = Gregorian.moment(date);
           
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
if (arr.size() >= 1) {
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
         if (time1 < time2 || time1 == time2) {
             curr = arr[j].abs();
            var string = arr2[j];
            typetodisplay = arr3[j];
             System.println("ttd" + typetodisplay);
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
}

   }
      
  
      
      }        
        
     if (next != null){
       yes = null;
       if (ttd.find("reminder") != null) {
       dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_TRANSPARENT);
        dc.drawText(snapw, snaph+30, Graphics.FONT_MEDIUM, next.substring(17, next.length()), Graphics.TEXT_JUSTIFY_CENTER);
       }
       else if (ttd.find("timer") != null) {
       dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_TRANSPARENT);
       dc.drawText(snapw, snaph+30, Graphics.FONT_MEDIUM, next.substring(10, next.length()), Graphics.TEXT_JUSTIFY_CENTER);
       } 
          
    if (next.find("camping") != null){
    yes = "yes";
    tent = WatchUi.loadResource(Rez.Drawables.tent);
    dc.drawBitmap(70, 55, tent);
    }
    if (next.find("hospital") != null || next.find("baby") != null || next.find("appointment") != null || next.find("meds") != null || next.find("medical") != null) {
    stefoscope = new WatchUi.Bitmap({:rezId=>Rez.Drawables.stefoscope,:locX=>70,:locY=>50});}
    if (next.find("trip") != null || next.find("service") != null || next.find("garage") != null) {
    vehicle = new WatchUi.Bitmap({:rezId=>Rez.Drawables.vehicle,:locX=>70,:locY=>50});}
    if (next.find("race") != null || next.find("run") != null || next.find("cross country") != null) {
    sports = new WatchUi.Bitmap({:rezId=>Rez.Drawables.sports,:locX=>70,:locY=>50});}
    if (next.find("anniversary") != null || next.find("date night") != null || next.find("wedding") != null) {
    heart = new WatchUi.Bitmap({:rezId=>Rez.Drawables.heart,:locX=>70,:locY=>50});}
    if (next.find("zoo") != null || next.find("farm") != null || next.find("vet") != null) {
    beast = new WatchUi.Bitmap({:rezId=>Rez.Drawables.beast,:locX=>70,:locY=>50});}
    if (yes == null){
    ARCTOS = new WatchUi.Bitmap({:rezId=>Rez.Drawables.bear,:locX=>70,:locY=>50});
    CANINE = new WatchUi.Bitmap({:rezId=>Rez.Drawables.dog,:locX=>70,:locY=>50});
    REPTILE = new WatchUi.Bitmap({:rezId=>Rez.Drawables.turtle,:locX=>70,:locY=>50});
    }
         
         

         
         if (next.find("hospital") != null || next.find("baby") != null || next.find("appointment") != null || next.find("meds") != null || next.find("medical") != null) {
         yes = "yes";
         stefoscope.draw(dc);
         }
         
         else if (next.find("trip") != null || next.find("service") != null || next.find("garage") != null) {
         yes = "yes";
         vehicle.draw(dc);
         }
        
         
         else if (next.find("race") != null || next.find("run") != null || next.find("cross country") != null || next.find("tournament") != null || next.find("sports") != null || next.find("the game") != null || next.find("baseball") != null) {
         yes = "yes";
         sports.draw(dc);
         }
         
         else if (next.find("anniversary") != null || next.find("date night") != null || next.find("wedding") != null) {
         yes = "yes";
         heart.draw(dc);
         }
         
         else if (next.find("zoo") != null || next.find("farm") != null || next.find("vet") != null) {
         yes = "yes";
         beast.draw(dc);
         }
         
          
         if (yes == null)
         {
         if (todisplay.find("reminder") !=null){
         System.println("working");
         ARCTOS.draw(dc);}
         
         else if (todisplay.find("timer") !=null){
         CANINE.draw(dc);}
         
         }
       
       
        }    
      }
     
    }
  
  
   if (date == null){
   dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_TRANSPARENT);
   dc.drawText(snapw, snaph+30, Graphics.FONT_MEDIUM, "No Pins", Graphics.TEXT_JUSTIFY_CENTER);
   
   
  }
}   
     
           function onShow() {
    Application.Storage.setValue("next", nex);
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
           
        PictureTime = "yes";   
           }
           
           function onHide() {
           PictureTime = null;
           }


}