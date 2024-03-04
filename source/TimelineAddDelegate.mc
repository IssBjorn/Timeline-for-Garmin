import Toybox.Communications;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
var showSelected = null;
var finalStr = "";
var select = 0;
var currNumber = null;
var o = 0;
var n = 1;
class TimelineAddDelegate extends WatchUi.BehaviorDelegate {
var old = Application.Storage.getValue("old");
    public var active = true;

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
     public function onKey(event) as Boolean {
        var key = event.getKey();
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            return onSelect();
        } else if (key == WatchUi.KEY_ESC || key == WatchUi.KEY_LAP) {
            return onBack();
        } else if (key == WatchUi.KEY_UP || key == WatchUi.KEY_MODE) {
            return controlPrev();
        } else if (key == WatchUi.KEY_DOWN || key == WatchUi.KEY_CLOCK) {
            return controlNext();
        }
        return false;
    }
    
    public function onSelect() as Boolean {
    showSelected = 1;
    }
    
    
 public function onBack() as Boolean {
 if (showSelected == 1){
 showSelected = null;
 }
 else {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);}
        return true;
    }
	
	function onMenu() {
	var hasMenu2=(WatchUi has :Menu2);
	if(hasMenu2) {
	    return pushImagesCustom();
	    }
	else {
	return true;
	}
	}
	
	
    
    function onSwipe(swipeEvent) as Boolean
    {    
    var swi = swipeEvent.getDirection();
         if (swi == WatchUi.SWIPE_DOWN){
         return controlNext();}
         if (swi == WatchUi.SWIPE_UP){
              return controlPrev();
         }
           WatchUi.requestUpdate();
         if (swi == WatchUi.SWIPE_LEFT){
          showSelected = 1;
         }
       
      return true;  
      }
      
      
	function controlNext() {

    if (list != null && list.size() > 0){    
         System.println("swipe!");
         
   if (showSelected != 1){  
    if (n == 1){  
     if (scrollSelect > 0){
     scrollSelect--;
       }
    }
    else if (o == 1) {
    if (scrollSelect < list.size()-1){
     scrollSelect++;}
     else if (scrollSelect == list.size()-1){
     n = 1;
     o = 0;
       list = Application.Storage.getValue("next");
         scrollSelect = list.size()-1;
     }
    }}
    else if (showSelected == 1) {
     mYOffset += 5;
    WatchUi.requestUpdate();
    
    }
   } return true;}
    
   function controlPrev(){
   if (list != null && list.size() > 0){ 
  
   if (showSelected != 1){     
   if (o == 1){  
     if (scrollSelect > 0){
     scrollSelect--;}
     else if (scrollSelect == 0){
      System.println("nothing");
     }
    }
    
    
    else if (n == 1) {
    if (scrollSelect < list.size()-1){
     scrollSelect++;}
    else if (scrollSelect == list.size()-1 && old != null){
       o = 1;
       n = 0;
       list = Application.Storage.getValue("old");
      scrollSelect = list.size()-1;
     }
    
    }}
    
    else if (showSelected == 1 && mYOffset != 38){
    mYOffset -= 5;
    WatchUi.requestUpdate();
    
    }
     
    }return true;}
 

//! Create the Images custom menu
public function pushImagesCustom() {
    var customMenu = new $.ImagesMenu(80, Graphics.COLOR_BLACK);
    customMenu.addItem(new $.CustomImagesItem(:bear, "New Reminder", WatchUi.loadResource($.Rez.Drawables.bear) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:dog, "New Timer", WatchUi.loadResource($.Rez.Drawables.dog) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:event, "New Event", WatchUi.loadResource($.Rez.Drawables.event) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:sync, "Sync Timeline", WatchUi.loadResource($.Rez.Drawables.sync) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:turtle, "Delete", WatchUi.loadResource($.Rez.Drawables.bin) as BitmapResource));
    WatchUi.pushView(customMenu, new Menu2TestMenu2Delegate(), WatchUi.SLIDE_IMMEDIATE);
}}

//! This is the Images custom menu, which shows an
//! image and text for each item
class ImagesMenu extends WatchUi.CustomMenu {

    //! Constructor
    //! @param itemHeight The pixel height of menu items rendered by this menu
    //! @param backgroundColor The color for the menu background
    public function initialize(itemHeight as Number, backgroundColor as ColorType) {
        CustomMenu.initialize(itemHeight, backgroundColor, {});
    }

    //! Draw the menu title
    //! @param dc Device Context
    public function drawTitle(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.setPenWidth(3);
        dc.drawLine(0, dc.getHeight() - 2, dc.getWidth(), dc.getHeight() - 2);
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, "New pin", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}

//! This is the menu input delegate for the images custom menu


    //! Constructor
    

    //! Handle an item being selected
    //! @param item The selected menu item
   

//! This is the custom item drawable.
//! It draws the item's bitmap and label.
class CustomImagesItem extends WatchUi.CustomMenuItem {

    private var _label as String;
    private var _bitmap as BitmapResource;
    private var _bitmapOffset as Number;

    //! Constructor
    //! @param id The identifier for this item
    //! @param label Text to display
    //! @param bitmap Color of the text
    public function initialize(id as Symbol, label as String, bitmap as BitmapResource) {
        CustomMenuItem.initialize(id, {});
        _label = label;
        _bitmap = bitmap;
        _bitmapOffset = 0 - bitmap.getWidth() / 2;
    }

    //! Draw the item's label and bitmap
    //! @param dc Device context
    public function draw(dc as Dc) as Void {
        var font = Graphics.FONT_SMALL;
        var bmXY = dc.getHeight() / 2 + _bitmapOffset;
        
        if (isFocused()) {
            font = Graphics.FONT_LARGE;
        }

        if (isSelected()) {
        
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.clear();
            
        }
        else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
            dc.clear();
        }
       
        

        dc.drawBitmap(bmXY, bmXY, _bitmap);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getHeight(), dc.getHeight() / 2, font, _label, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}


class Menu2TestMenu2Delegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

public function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        
        System.println(id); 
        
        if (id.equals(:bear)) {
        type = "reminder";
         WatchUi.pushView(new PinAddView(), new NumberDelegate(), WatchUi.SLIDE_RIGHT);
        WatchUi.requestUpdate();
        
        
        }
        
         if (id.equals(:dog)) {
         type = "timer";
          WatchUi.pushView(new PinAddView(), new NumberDelegate(), WatchUi.SLIDE_RIGHT);
        WatchUi.requestUpdate();
        
        }
        
        if (id.equals(:event)) {
        type = "event";
         WatchUi.pushView(new PinAddView(), new NumberDelegate(), WatchUi.SLIDE_RIGHT);
        WatchUi.requestUpdate();
     
        }
        
        if (id.equals(:sync)) {
       getTimelineData(method(:getLoaded));
     
        }
        
        
        else if (id.equals(:turtle)) {
        
        System.println("delete");
        nex = null;
             dateTimeString = "";
             
         
        var toDelete = null; 
        
       if (o!=1) {
       toDelete = Application.Storage.getValue("next");
       toDelete = toDelete.remove(toDelete[scrollSelect]);
       Application.Storage.setValue("next",toDelete);
        }
       else {
       toDelete = Application.Storage.getValue("old");
       toDelete = toDelete.remove(toDelete[scrollSelect]);
       Application.Storage.setValue("old",toDelete);
       }
       
        
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.requestUpdate();
        }
        
       
        
       
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_LEFT);
     inputStr = "";
    newStr = "";
     type = null;
    }
    
     function getTimelineData(callback) {
    
    var url = "https://timeline-api.rebble.io/v1/sync";
    
    var token = Application.Properties.getValue("token");
    
     var parameters = null;
     
     var options = {
     :method => Communications.HTTP_REQUEST_METHOD_GET,
     :headers => {"Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
     "Authorization" => "Bearer " + token}
     };
  
     Communications.makeWebRequest(url, parameters, options,callback);
     
    }
    
    
    
    function next() {
    index = index + 1;
    }
    
    function getLoaded(status,data) {
   if (status == 200) {
    
  var timelineData = data;
 index = index + 1;
  var pin = timelineData["updates"][index]["data"];
   TimelineArr.add(pin);
   next();
   }
   else {
   var source = status.toString();
   System.println(source);
   }
   System.println("loaded");
  return true;
   }
    
    
}