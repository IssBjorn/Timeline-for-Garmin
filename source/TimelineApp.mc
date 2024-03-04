import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;
import Toybox.System;
import Toybox.Time;



var inBackground=false;
(:glance :background)
	
class TimelineApp extends Application.AppBase {
private var _timerView as TimelineSnapshotView?;

    function initialize() {
        AppBase.initialize();
        }
   
    
    
    // onStart() is called on application start up
    function onStart(state){
    System.println("started");
    }

    // onStop() is called when your application is exiting
    function onStop(state){
    //if(!inBackground) {
	    //	Background.registerForTemporalEvent(closestWake);   
    	//} else {
    		System.println("onStop");
    	//}
           }

    // Return the initial view of your application here
    function getInitialView() {
    
        return [ new TimelineSnapshotView(), new TimelineSnapshotDelegate() ];
        
    }
    
    public function getServiceDelegate() as ServiceDelegate{
    System.println("svc");
        return [new MyServiceDelegate()];
    }
    
    function getGlanceView(){
    
    return [new glanceView()];
    

}

}

