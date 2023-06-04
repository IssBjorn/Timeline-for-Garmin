using Toybox.Communications;
using Toybox.Application;
using Toybox.WatchUi;

class TimelineSnapshotDelegate extends WatchUi.BehaviorDelegate {
    public var active = true;

    function initialize() {
        BehaviorDelegate.initialize();
    }
	
	function onMenu(){
	    WatchUi.pushView(new TimelineView(), new TimelineAddDelegate(), WatchUi.SLIDE_RIGHT);
	    return true;
	    }

    function onTap(clickEvent){
     
        WatchUi.requestUpdate();
        return true;
        }
}