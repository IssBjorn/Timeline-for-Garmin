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
	    }

    function onTap(clickEvent){
      repeat = 0;
        WatchUi.requestUpdate();
        
        }
}