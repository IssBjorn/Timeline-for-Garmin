using Toybox.Application;
using  Toybox.Lang;
using  Toybox.WatchUi;
using Toybox.Graphics as Gfx;

var gWidgetStarted = false;

class TimelineApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }
    
    // onStart() is called on application start up
    function onStart(state){
    
    }

    // onStop() is called when your application is exiting
    function onStop(state){
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new TimelineSnapshotView(), new TimelineSnapshotDelegate() ];
    }

}

class TextPickerSampleView extends WatchUi.View {
    var devH, devW;

    function initialize() {
        var deviceSettings = System.getDeviceSettings();
        devH = deviceSettings.screenHeight;
        devW = deviceSettings.screenWidth;
        View.initialize();
    }

    function onUpdate(dc) {
        $.gWidgetStarted = false;
        var fontHeight = Gfx.getFontHeight(Gfx.FONT_SYSTEM_MEDIUM);
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(devW/2, devH/2-fontHeight*1.5, Gfx.FONT_SYSTEM_LARGE, "Text Picker", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(devW/2, devH/2, Gfx.FONT_SYSTEM_MEDIUM, "Press START", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(devW/2, devH/2+fontHeight, Gfx.FONT_SYSTEM_MEDIUM, "to enter text.", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    }
}


class TextPickerSampleInput extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onKey(event) {
        var key = event.getKey();
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            return onSelect();
        } else if (key == WatchUi.KEY_ESC || key == WatchUi.KEY_LAP) {
            return onBack();
        }
        return false;
    }

    function onSelect() {
        if (!$.gWidgetStarted) {
            $.gWidgetStarted = true;
            var view = new TextPickerView("  New Pin","date,time,info:",4,6,"");
            WatchUi.pushView(view, new TextPickerDelegate(view), WatchUi.SLIDE_LEFT);
        }
        return true;
    }

    function onBack() {
        if ($.gWidgetStarted) {
            $.gWidgetStarted = false;
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }

}
