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
class TimelineSnapshotView extends WatchUi.View {

    function initialize() {
        View.initialize();
        
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
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
       dc.clear();
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    System.println(type);
      
            
      
        // Call the parent onUpdate function to redraw the layout
       
       var snaph = dc.getHeight()/2;
       var snapw = dc.getWidth()/2;
       var next = Application.Storage.getValue("next");
       var remarray = Application.Storage.getValue("reminders");
       var timarray = Application.Storage.getValue("alarm");
       var evnarray = Application.Storage.getValue("events");
       var recarray = Application.Storage.getValue("record");
       var typetorem = Application.Storage.getValue("typerem");
       var typetotim = Application.Storage.getValue("typetim");
       var typetoeve = Application.Storage.getValue("typeeve");
       var typetorec = Application.Storage.getValue("typerec");
       
     var skip = 1;  
      if(add != null){
       if (add == 1 && remarray != null && typetorem != null) {
       remarray.add(skip);
       read = remarray;
       typetorem.add(skip);
       typetoread = typetorem;
       }
       else if (add == 2 && timarray != null && typetotim != null){
       timarray.add(skip);
       read = timarray;
       typetotim.add(skip);
       typetoread = typetotim;
       }
       else if (add == 3 && evnarray != null && typetoeve != null){
       evnarray.add(skip);
       read = evnarray;
       typetoeve.add(skip);
       typetoread = typetoeve;
       } 
       else if (add == 4 && recarray != null && typetorec != null){
       recarray.add(skip);
       read = recarray;
       typetorec.add(skip);
       typetoread = typetorec;
       }
       
       }
       
       
 var arr = new [0];      
 var arr2 = new [0];
 var arr3 = new[0];
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
           
           if (ts != null && dateTimeString.length() > 1){
           t1 = ts.value(); 
           System.println("t1:" + t1);
           arr.add(t1);
           arr2.add(read[i]);
           if (typetoread != null){
           arr3.add(typetoread[i]);   }
           System.println("arr:" + arr);
           System.println("arr2:" + arr2);
           System.println("i:"+ i);
          }
         
         if (i == (len - 2) && add != 4) {
           add = add + 1;
          System.println("add:" + add); 
           }
        
        else if (i == (len - 2)  && add == 4) {
           var currtime = Time.now().value();
           System.println("currtime: " + currtime); 
      var skip2 = 2456;
      arr.add(skip2);
      System.println("arr3:" + arr);
      var number = currtime;
      var nex = null;
      var len2 = arr.size();
      System.println("len2:" + len2);
      curr = arr[0];
      System.println("curr: " + curr);
      
    for(var j=0; j < (len2  - 1); j+=1) {
    System.println("j: " + j);
    var time1 = (number - arr[j]).abs();
    
    var time2 = (number - curr).abs();
    
    
    System.println("times: " + time1 + "," + time2);
         if (time1 < time2) {
             curr = arr[j].abs();
            var string = arr2[j];
            if (typetoread != null){
            var typetodisplay = arr3[j];}
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
           
       
           }}
        
        
       
       dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
        dc.drawText(snapw, snaph, Graphics.FONT_MEDIUM, next, Graphics.TEXT_JUSTIFY_CENTER);
         
        
        
    
    
    
}


           function onShow() {
              repeat = 0;
        if (type != null) {
    
          if(remind==null){remind = new [0]; System.println(remind + "," + "yes!");}
            else if(event==null){event = new [0];}
            else if(alarms==null){alarms = new [0];}
            else if(records==null){records = new [0];}
            
            if (typeto==null){typeto = new [0];}


          if (type.equals("reminder")){
            var re = inputStr + newStr;
            var newarrre = remind.add(re);
            var remtype = type;
            var remtypetoadd = typeto.add(remtype);
            Application.Storage.deleteValue("reminders");
            Application.Storage.setValue("reminders", newarrre);
            Application.Storage.deleteValue("type");
            Application.Storage.setValue("type",remtypetoadd);
            }
            
       else if (type.equals("event")){
            var ev = inputStr + newStr + "event";
            var newarrev = event.add(ev);
            var evetype = type;
            var evetypetoadd = typeto.add(evetype);
            System.println(event);
            Application.Storage.deleteValue("events");
            Application.Storage.setValue("events", newarrev);
            Application.Storage.deleteValue("type");
            Application.Storage.setValue("type",evetypetoadd);
            }
       
       else if (type.equals("timer")){
            var al = inputStr + newStr;
            var newarral = alarms.add(al);
            var timtype = type;
            var timtypetoadd = typeto.add(timtype);
            Application.Storage.deleteValue("alarm");
            Application.Storage.setValue("alarm", newarral);
            Application.Storage.deleteValue("type");
            Application.Storage.setValue("type",timtypetoadd);
            }
       else if (type.equals("record")){
            var rec = inputStr + newStr;
            var newarrrec = records.add(rec);
            var rectype = type;
            var rectypetoadd = typeto.add(rectype);
            Application.Storage.deleteValue("record");
            Application.Storage.setValue("record", newarrrec);
            Application.Storage.deleteValue("type");
            Application.Storage.setValue("type",rectypetoadd);
            }
      
           }
           
           
           }


}