import Toybox.Communications;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;




class TimelineAddDelegate extends WatchUi.BehaviorDelegate {
    public var active = true;

    function initialize() {
        BehaviorDelegate.initialize();
    }
	
	function onMenu(){
	    return pushImagesCustom();
	    }
	    



//! Create the Images custom menu
public function pushImagesCustom() as Void {
    var customMenu = new $.ImagesMenu(80, Graphics.COLOR_BLACK);
    
    customMenu.addItem(new $.CustomImagesItem(:bear, "Reminder", WatchUi.loadResource($.Rez.Drawables.bear) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:dog, "Timer", WatchUi.loadResource($.Rez.Drawables.dog) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:fox, "Event", WatchUi.loadResource($.Rez.Drawables.fox) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:mouse, "Record", WatchUi.loadResource($.Rez.Drawables.mouse) as BitmapResource));
    customMenu.addItem(new $.CustomImagesItem(:turtle, "Delete", WatchUi.loadResource($.Rez.Drawables.turtle) as BitmapResource));
    WatchUi.pushView(customMenu, new Menu2TestMenu2Delegate(), WatchUi.SLIDE_UP);
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
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
        dc.setPenWidth(3);
        dc.drawLine(0, dc.getHeight() - 2, dc.getWidth(), dc.getHeight() - 2);
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
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
        
            dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
            dc.clear();
            
        }
        else {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_LT_GRAY);
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
        System.println("reminder");
        WatchUi.requestUpdate();
        WatchUi.pushView(new TextPickerSampleView(), new TextPickerSampleInput(), WatchUi.SLIDE_UP);
        } else if (id.equals(:fox)) {
         type = "event";
         System.println("event");
        WatchUi.requestUpdate();
        WatchUi.pushView(new TextPickerSampleView(), new TextPickerSampleInput(), WatchUi.SLIDE_UP);
        } else if (id.equals(:dog)) {
        
        System.println("timer");
        type = "timer";
        WatchUi.requestUpdate();
        WatchUi.pushView(new TextPickerSampleView(), new TextPickerSampleInput(), WatchUi.SLIDE_UP);
        } else if (id.equals(:turtle)) {
        
        System.println("delete");
        WatchUi.requestUpdate();
        } else if (id.equals(:mouse)) {
        type = "record";
        System.println("record");
        WatchUi.requestUpdate();
        WatchUi.pushView(new TextPickerSampleView(), new TextPickerSampleInput(), WatchUi.SLIDE_UP);
        }
        
       
    }

    //! Handle the back key being pressed
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}