using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Application as App;
var inputStr = "";
var newStr = "";
var typetoadd = "";
var type = null;
var pins = App.Storage.getValue("pins");
var typeto = App.Storage.getValue("type");
class TextPickerView extends Ui.View {

    // this is here for completeness but is likely calculated elsewhere in an app
    static const DEVICE_WIDTH = System.getDeviceSettings().screenHeight;
    static const DEVICE_HEIGHT = System.getDeviceSettings().screenWidth;
    
    static const INPUT_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:_ !@,.#()£$? \n";  // valid characters for input
    static const INPUT_CONTROLS = "<*";   // control characters for input
    static const INPUT_OK = "OK";         // what to render in place of the '*' (accept) character
    static const INPUT_BACK = "<<";       // what to render in place of the '<' (delete) character
    static const INPUT_ENTER = "+";       // new line
    static const INPUT_SPACE = "<>";       // space
    // these will likely need to be changed based on device
    static const PICKER_TITLE_POS = [95,30];                // title position
    static const PICKER_SUBTITLE_POS = [10,80] ;             // subtitle/info position
    var PICKER_INPUT_POS = [10,DEVICE_HEIGHT/2];   // input display position
    static const PICKER_X = 174;                            // X coordinate of left side of picker
    static const PICKER_WIDTH = 32;                         // width of the picker (from left bar to right bar)

    // fonts to use for various text; will likely change based on device
    static const FONT_PICKER_TITLE = Gfx.FONT_SMALL;
    static const FONT_PICKER_SUBTITLE = Gfx.FONT_TINY;
    static const FONT_PICKER_VALUE = Gfx.FONT_XTINY;
    static const FONT_PICKER_LETTER_NOT_SELECTED = Gfx.FONT_XTINY;
    static const FONT_PICKER_LETTER_SELECTED = Gfx.FONT_TINY;

    var mTitle;
    var mSubTitle;
    var mMinChars;
    var mMaxChars;
    var input_chars;
    var charIdx = 0;

    function initialize(title, subTitle, minChars, maxChars, prefix) {
        mTitle = title;
        mSubTitle = subTitle;
        mMinChars = minChars;
        mMaxChars = maxChars;
        if (prefix != null) {
            inputStr = prefix;
        }
        input_chars = INPUT_LETTERS+INPUT_CONTROLS;
        View.initialize();
    }

    function onUpdate(dc) {
        // clear whatever is on the screen to prepare for update
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();

        var rightBarX = PICKER_X + PICKER_WIDTH;

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(PICKER_TITLE_POS[0], PICKER_TITLE_POS[1], FONT_PICKER_TITLE, mTitle, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(PICKER_SUBTITLE_POS[0], PICKER_SUBTITLE_POS[1], FONT_PICKER_SUBTITLE, mSubTitle, Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
        dc.setPenWidth(2);
        dc.drawLine(PICKER_X, 0, PICKER_X, DEVICE_HEIGHT);
        dc.drawLine(rightBarX, 0, rightBarX, DEVICE_HEIGHT);

        var pickerFontHeight = dc.getTextDimensions(input_chars.substring(0,1), FONT_PICKER_LETTER_SELECTED)[1];

        var sidx;   // index of character at the top of visible list
        var eidx;   // index of character at the bottom of visible list
        var ch;     // character under the cursor

        // draw the (visible) list of characters
        for (var i=(input_chars.length() > 5 ? -2 : input_chars.length()/2-1); i <= (input_chars.length() > 5 ? 2 : input_chars.length()/2); i++) {
            if (i == 0) {
                dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
                dc.setPenWidth(2);
                dc.drawCircle(175, 119, 205);
                dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            }
            sidx = (charIdx+i) % input_chars.length();
            if (sidx < 0) {
                sidx = sidx + input_chars.length();
            }
            if (input_chars.substring(sidx,sidx+1).equals("\n")) {
                ch = INPUT_ENTER;
            } else if (input_chars.substring(sidx,sidx+1).equals(" ")) {
                ch = INPUT_SPACE;
            } else if (input_chars.substring(sidx,sidx+1).equals("<")) {
                ch = INPUT_BACK;
            } else if (input_chars.substring(sidx,sidx+1).equals("*")) {
                ch = INPUT_OK;
                // grey out the 'OK' if there aren't enough characters
                if (inputStr.length() < 2) {
                    dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
                }
            
            }else {
                eidx = sidx + 1;
                ch = input_chars.substring(sidx,eidx);
            }
            dc.drawText(PICKER_X+PICKER_WIDTH/2, (DEVICE_HEIGHT/2)+i*27, i == 0 ? FONT_PICKER_LETTER_SELECTED : FONT_PICKER_LETTER_NOT_SELECTED, ch, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        }
        // draw the string entered (so far)
        dc.drawText(110, 164, FONT_PICKER_VALUE, inputStr, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(110, 174, FONT_PICKER_VALUE, newStr, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);

        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        // draw the blue rectangle around the selected letter
        dc.setPenWidth(1);
        dc.drawRectangle(PICKER_X,DEVICE_HEIGHT/2-pickerFontHeight/2,PICKER_WIDTH,pickerFontHeight+2);
        dc.drawRectangle(PICKER_X-1,DEVICE_HEIGHT/2-pickerFontHeight/2-1,PICKER_WIDTH+2,pickerFontHeight+2);
    }
    
    
    function splitString(dc, FONT_PICKER_VALUE, inputStr, margin){

var width = dc.getWidth() - margin * 2;
var strLen = inputStr.length();
var firstChar = 0;
var lastChar = 0;
var newStr = "";

if(strLen == 0){return "";}

for(var i = 0; i <= strLen; i++) {
var char = inputStr.substring(i, i + 1);
if(char.equals(" ") || i == strLen){
if(dc.getTextWidthInPixels(inputStr.substring(firstChar, i), FONT_PICKER_VALUE) < width){
lastChar = i;
}
else {
newStr += inputStr.substring(firstChar, lastChar) + "\n";
firstChar = lastChar + 1;
}
}
}
newStr += inputStr.substring(firstChar, strLen);
return newStr;
}


    function setCharIdx(idx) {
        charIdx = idx;
        if (charIdx < 0) {
            charIdx = charIdx + input_chars.length();
        }
    }

    function charSelected() {
        // are we adding something from the list of valid letters?
        if (input_chars.length() >= INPUT_LETTERS.length() && charIdx < INPUT_LETTERS.length()) {
            inputStr = inputStr + input_chars.substring(charIdx,charIdx+1);
        } else if (input_chars.substring(charIdx,charIdx+1).equals("<")) {
            inputStr = inputStr.substring(0,inputStr.length()-1);
            // if we aren't at the maximum number of characters, then set the input characters to all
            //   and set the highlighted character to the back/delete char
            if (inputStr.length() < 30) {
                input_chars = INPUT_LETTERS+INPUT_CONTROLS;
                charIdx = INPUT_LETTERS.length(); // the character after the letters is the back/delete char
            }
        }
        // if we're now at the maximum number of characters, change the input characters to
        
        if (inputStr.length() > 30) {
            input_chars = INPUT_CONTROLS;
            charIdx = 1;
        }
    }

}


class TextPickerDelegate extends Ui.BehaviorDelegate {
    // millisec between updates when long pressing up/down on picker
    static const LONG_PRESS_UPDATE_FREQUENCY = 250;

    var picker;
    var longPressTimer;

    function initialize(the_picker) {
        picker = the_picker;
        BehaviorDelegate.initialize();
    }

    function onKey(event) {
        var key = event.getKey();
        if (key == Ui.KEY_ENTER || key == Ui.KEY_START) {
            return onSelect();
        } else if (key == Ui.KEY_ESC || key == Ui.KEY_LAP) {
            return onBack();
        } else if (key == Ui.KEY_UP || key == Ui.KEY_MODE) {
            return onPreviousPage();
        } else if (key == Ui.KEY_DOWN || key == Ui.KEY_CLOCK) {
            return onNextPage();
        }
        return false;
    }

    // handle long press activity (used to scroll up or down through the list of letters)
    function onKeyPressed(event) {
        var key = event.getKey();
        if (key == Ui.KEY_UP || key == Ui.KEY_MODE) {
            longPressTimer = new Timer.Timer();
            longPressTimer.start( method(:onPreviousPage), LONG_PRESS_UPDATE_FREQUENCY, true );
            return true;
        } else if (key == Ui.KEY_DOWN || key == Ui.KEY_CLOCK) {
            longPressTimer = new Timer.Timer();
            longPressTimer.start( method(:onNextPage), LONG_PRESS_UPDATE_FREQUENCY, true );
            return true;
        }
        return false;
    }
    
    function onHold(clickEvent) {
        var coord = clickEvent.getCoordinates();
    	var x = coord[0];
    	var y = coord[1];
    	var t = null;
        if(x > 60 && x < 180 && y > 0 && y < 60 && t==null) {
            longPressTimer = new Timer.Timer();
            t="yes"
            longPressTimer.start( method(:onPreviousPage), LONG_PRESS_UPDATE_FREQUENCY, true );
            return true;
        } else if (x > 60 && x < 180 && y > 180 && y < 240 && t==null) {
            t="yes"
            longPressTimer = new Timer.Timer();
            longPressTimer.start( method(:onNextPage), LONG_PRESS_UPDATE_FREQUENCY, true );
            return true;
        }
            else if (t!=null) {
            longPressTimer.stop();
            longPressTimer = null;
            return true;
        }
        return false;
    }

    function onKeyReleased(event) {
        var key = event.getKey();
        if (key == Ui.KEY_UP || key == Ui.KEY_MODE || key == Ui.KEY_DOWN || key == Ui.KEY_CLOCK) {
            longPressTimer.stop();
            longPressTimer = null;
            return true;
        }
        return false;
    }
  


    function onSelect() {
    System.println(type);
    
        if (picker.input_chars.substring(picker.charIdx,picker.charIdx+1).equals("*")) {
            // don't let the user select OK if there aren't enough characters...
            if (picker.inputStr.length() < 1) {
                return true; 
            }
         

            // we're selecting 'OK' so set the picker to null (to eliminate potential circ ref)
       
             System.println(inputStr + "," + newStr);
            

            // *** TODO ***
            // The developer (you) must do something here, both in terms of the program
            // flow (ie. pop and/ or push a new view) and in terms of the text entered
            Ui.pushView(new TimelineSnapshotView(), new TimelineSnapshotDelegate(), WatchUi.SLIDE_UP);

        } else {
            picker.charSelected();
            Ui.requestUpdate();
        }
        return true;
            
          
    } 

    function onBack() {
        Ui.popView(Ui.SLIDE_RIGHT);
        picker = null;
        return true;
    }

    function onNextPage() {
        picker.setCharIdx((picker.charIdx+1) % picker.input_chars.length());
        Ui.requestUpdate();
        return true;
    }

    function onPreviousPage() {
        picker.setCharIdx((picker.charIdx-1) % picker.input_chars.length());
        Ui.requestUpdate();
        return true;
    }
}