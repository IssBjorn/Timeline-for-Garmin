//v3
using Toybox.WatchUi;
using Toybox.Graphics;

(:glance)
class glanceView extends WatchUi.GlanceView {
    var updateTimer;
    var scrollableText;
    var currentPos = 0;
  var next = Application.Storage.getValue("next");
var textWidth = null;
    var screenWidth, screenHeight;
    function initialize() {
        View.initialize();
 
        var settings = System.getDeviceSettings();
       
 
        updateTimer = new Timer.Timer();
 
        // scroll across the full screen wdith
       
 
        // scroll across approximately half the screen width
       
         
            //scrollableWidth
    }
    
    function onLayout(dc) {
     screenWidth = dc.getWidth();
        screenHeight = dc.getHeight();
   
       
    }
 
    // this example only works properly with rectangular and round devices
    function getWidth(y) {
        if (screenHeight > screenWidth) {
            return screenWidth;
        } else { // semiround and round
            // this isn't quite right for semiround watches

            var radius = screenWidth / 2;
            //var angle = 2 * Math.toDegrees(Math.acos(1 - (y.toFloat() / radius))); // Angle = 2 * arccos(1 - height(y) / radius)
            //return (2 * radius * Math.sin(Math.toRadians(angle) / 2)).toNumber();
            return (2 * radius * Math.sin(Math.toRadians(2 * Math.toDegrees(Math.acos(1 - (y.toFloat() / radius)))) / 2)).toNumber();
        }
    }
 
    function triggerUpdate() {
        WatchUi.requestUpdate();
    }
 
    // Update the view
  
    

       
    
 
    function onUpdate(dc) {
    
    
    var x = screenWidth/3;
    var y = screenHeight/4;
    
  
    var fontHeight = null;
        if ( textWidth != null && currentPos < 0 - textWidth){
    currentPos = screenWidth;}
        if (fontHeight == null) {
            fontHeight = dc.getFontHeight(Graphics.FONT_TINY);
        }
 
        dc.setClip(x - 20, 0, screenWidth, screenHeight); //only available in CIQ 2.3.0 and higher
       if (next != null){
        if (next[next.size() - 1].find("reminder") != null) {
       if (textWidth == null) {
            textWidth = dc.getTextWidthInPixels(next[next.size() - 1].substring(10, next[next.size() - 1].length()),  Graphics.FONT_TINY);
        }
       dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
      dc.drawText(x + currentPos, y, Graphics.FONT_TINY, next[next.size() - 1].substring(17, next[next.size() - 1].length()), Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
       }
       else if (next[next.size() - 1].find("timer") != null) {
       if (textWidth == null) {
            textWidth = dc.getTextWidthInPixels(next[next.size() - 1].substring(10, next[next.size() - 1].length()),  Graphics.FONT_TINY);
        }
       dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
       dc.drawText(x + currentPos, y, Graphics.FONT_TINY, next[next.size() - 1].substring(10, next[next.size() - 1].length()), Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
       } 
       
       
   
 
 
        // scroll by 2 pixels. (1 is smoother, but a bit too slow)
       currentPos = currentPos - 2;
        //if (currentPos < textWidth) {
            //currentPos = scrollableWidth-1;
            System.println(currentPos);
        //}
        }
        if (next == null){
      dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
       dc.drawText(x + currentPos, y, Graphics.FONT_TINY, "NO PINS", Graphics.TEXT_JUSTIFY_LEFT|Graphics.TEXT_JUSTIFY_VCENTER);
 
        dc.clearClip();  //only available in CIQ 2.3.0 and higher
 
        // draw rectangle to demonstrate bounds of scrolling region
     
    }
 
        // 50 ms is the minimum timer interval for most (all?) devices
        updateTimer.start(method(:triggerUpdate), 50 /* ms */, false);
    }
}
 
// this example only works with left justified and vertically centred text
// TODO: support non-vertically centred text
// TODO: support shortening text with ellipses ("...")

 