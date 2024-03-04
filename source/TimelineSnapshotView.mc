import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Timer;
import Toybox.Application;
import Toybox.Background;
import Toybox.Lang;
var now = System.getClockTime();
var next = Application.Storage.getValue("next");
var add = 0;
var t1 = null;
var t2 = null;
var TimeDate = null;
var read = null;
var dateTimeString = "";
var repeat = null;
var timer;
var curr = null;
var arr2 = null;
var arr = null;
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
var nex = null;
var date = null;
var Pebble = null;
var old = null;
var animation = null;
var points = [];
var closestWake = null;
var len = null;
   (:typecheck(disableBackgroundCheck))
class TimelineSnapshotView extends WatchUi.View {

var toDraw = [:dog,:bear,:event];



    public
    function initialize() {
        View.initialize();




    }

    function onLayout(dc) {



        Pebble = WatchUi.loadResource(Rez.Fonts.pebble);


        if (timer == null) {
            timer = new Timer.Timer();
            timer.start(method(: timerCallback), 500, true);
        }
    }



    function timerCallback() as Void {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {

        var snaph = dc.getHeight() / 2;
        var snapw = dc.getWidth() / 2;
        View.onUpdate(dc);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        
 


        if (animation <= 1) {
            points = [
                [snapw - 2, snaph - 2],
                [snapw + 2, snaph - 2],
                [snapw + 2, snaph + 2],
                [snapw - 2, snaph + 2]
            ];
        }
        if (animation <= 2 && animation > 1) {
            points = [
                [snapw - 40, snaph + 40],
                [snapw - 60, snaph + 65],
                [snapw - 20, snaph - 20],
                [snapw + 70, snaph - 50],
                [snapw + 30, snaph + 80]
            ];
        }
        if (animation == 3) {
            points = [
                [0, 0],
                [snapw * 2, 0],
                [snapw * 2, snaph * 2],
                [0, snaph * 2]
            ];
        }
        if (points.size() > 0) {
            dc.fillPolygon(points);
        }

        if (animation != 4) {
            animation = animation + 1;
        }
        if (animation == 4) {
            if (next == null) {
                TimelineSnapshotView.CalculateTimes();
            }
        
            
        

var BMindex = null;
            next = Application.Storage.getValue("next");
            if (next != null && next.size() > 0) {
                
                if (next[next.size() - 1].find("reminder") != null) {
                BMindex = 1;
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
                    dc.drawText(snapw, snaph + 30, Pebble, next[next.size() - 1].substring(26, next[next.size() - 1].length()), Graphics.TEXT_JUSTIFY_CENTER);
                } else if (next[next.size() - 1].find("timer") != null) {
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
                    BMindex = 0;
                    dc.drawText(snapw, snaph + 30, Pebble, next[next.size() - 1].substring(16, next[next.size() - 1].length()), Graphics.TEXT_JUSTIFY_CENTER);
                }
                else if (next[next.size() - 1].find("event") != null) {
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
                    BMindex = 2;
                    dc.drawText(snapw, snaph + 30, Pebble, next[next.size() - 1].substring(16, next[next.size() - 1].length()), Graphics.TEXT_JUSTIFY_CENTER);
                }



if (WatchUi has :getSubscreen){
var draw = WatchUi.loadResource(Rez.Drawables[toDraw[BMindex]]);
dc.drawBitmap((snapw*2)-60, ((snapw*2)-(snapw*2))+6, draw);
}
else {
var draw = WatchUi.loadResource(Rez.Drawables[toDraw[BMindex]]);
dc.drawBitmap(snapw - 25, 20, draw);}
             }   


            


            if (next == null) {
                dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
                dc.drawText(snapw, snaph + 30, Pebble, "NO PINS", Graphics.TEXT_JUSTIFY_CENTER);


            }
            else {
          
            TimelineSnapshotView.setBGEvent();
    }
            
            }
        

       
    }

    function CalculateTimes() {
  if (animation == 4) {
    var pinarray = Application.Storage.getValue("pins");

    if (pinarray != null) {
      read = pinarray;
    }
    if (len == null && read != null && read.size() >= 1) {
      len = read.size() - 1;
    }

    if (PictureTime != null) {
      if (arr == null) {
        arr = new[0];
      }
      if (arr2 == null) {
        arr2 = new[0];
      }

      if (read != null) {
        if (pins != null && pins.size() >= 1) {
          {
            dateTimeString = read[add].toString();
            var TDayOfWeek = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

            TDayOfWeek = Lang.format("$1$", [TDayOfWeek.day.format("%02u")]);
            var nDayOfWeek = TDayOfWeek.toNumber();
            annum = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
            annum = Lang.format("$1$", [annum.year.format("%04u")]);
            var MonthOfYear = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
            MonthOfYear =
                Lang.format("$1$", [MonthOfYear.month.format("%02u")]);

            var nMonthOfYear = MonthOfYear.toNumber();
            if (dateTimeString.find("reminder") != null ||
                dateTimeString.find("event") != null) {
              var yrstr = null;
              var mnstr = null;
              var rptyear = dateTimeString.substring(0, 4);
              var rptMonth = dateTimeString.substring(5, 7);
              if (rptyear.find("RPT ") != null) {
                System.println("rptyear");
                if (rptMonth.toNumber() >= nMonthOfYear &&
                    dateTimeString.substring(8, 10).toNumber() >= nDayOfWeek) {
                  yrstr = annum;
                } else {
                  yrstr = annum.toNumber() + 1;
                }
              } else {
                yrstr = dateTimeString.substring(0, 4);
              }
              if (rptMonth.find("RP") != null) {
                mnstr = nMonthOfYear;
              } else {
                mnstr = dateTimeString.substring(5, 7);
              }
              System.println(yrstr);
              var options = {
                                    :year => yrstr.toNumber(),
                                    :month => mnstr.toNumber(),
                                    :day => dateTimeString.substring(8, 10).toNumber(),
                                    :hour => dateTimeString.substring(11, 13).toNumber(),
                                    :minute => dateTimeString.substring(14, 16).toNumber(),
                                    :second => dateTimeString.substring(14, 16).toNumber()
                                };
              date = options;
            }

            if (dateTimeString.find("timer") != null) {
              var dayGiven = dateTimeString.substring(0, 4);
              var weekday = null;
              if (dayGiven != null) {
                if (dayGiven.find("RPT") != null) {
                  weekday = TDayOfWeek.toNumber();
                }
                if (dayGiven.find("MON") != null) {
                  weekday = 2;
                } else if (dayGiven.find("TUE") != null) {
                  weekday = 3;
                } else if (dayGiven.find("WED") != null) {
                  weekday = 4;
                } else if (dayGiven.find("THU") != null) {
                  weekday = 5;
                } else if (dayGiven.find("FRI") != null) {
                  weekday = 6;
                } else if (dayGiven.find("SAT") != null) {
                  weekday = 7;
                } else if (dayGiven.find("SUN") != null) {
                  weekday = 1;
                }

                var NdD = nextWeekday(weekday);

                NdD = NdD.day.format("%02d");

                NdD = NdD.toNumber();

                if (nDayOfWeek > NdD && nMonthOfYear == 12) {
                  annum = (annum + 1);
                }

                max = getMonthLength(nMonthOfYear);
                if (NdD > max) {
                  NdD = (NdD - max);
                }

                if (NdD < nDayOfWeek) {
                  nMonthOfYear = (nMonthOfYear + 1);
                }
                var options = {


                                        :year => annum.toNumber(),
                                        :month => nMonthOfYear.toNumber(),
                                        :day => NdD.toNumber(),
                                        :hour => dateTimeString.substring(4, 6).toNumber(),
                                        :minute => dateTimeString.substring(7, 9).toNumber(),
                                        :second => dateTimeString.substring(7, 9).toNumber()
                                    };
                date = options;
              }
            }

            if (date != null) {
              TimeDate = Gregorian.moment(date);

              if (TimeDate != null && dateTimeString.length() > 1 &&
                  pinarray.size() > 0) {
                t1 = TimeDate.value();

                if ((arr2.size() - 1) < len) {
                  arr.add(t1);
                  arr2.add(read[add]);
                }
              }
              if (add == len) {
                var number = Time.now().value();
                old = Application.Storage.getValue("old");

                if (old == null) {
                  old = [];
                }
                if (arr.size() >= 1) {
                  var len2 = arr.size();
                  curr = arr[0];

                  if (arr2.size() - 1 == len) {
                    for (var j = 0; j < len2; j += 1) {
                      var time1 = (number - arr[j]).abs();
                      var time2 = (number - curr).abs();

                      if (arr[j] >= number) {
                        if (time1 < time2 || time1 == time2) {
                          curr = arr[j].abs();
                          var string = arr2[j];
                          nex = string;

                          var toChange = Application.Storage.getValue("pins");
                          var order = Application.Storage.getValue("next");
                          System.println(order);
                          if (order == null) {
                            order = [];
                          }

                          for (var k = 0; k < toChange.size(); k++) {
                            var Stringify = toChange[k];
                            var found = Stringify.find(nex);
                            if (found != null) {
                              order.add(toChange[k]);

                              toChange.remove(toChange[k]);
                            }
                          }

                          Application.Storage.setValue("pins", toChange);
                          pins = Application.Storage.getValue("pins");
                          Application.Storage.setValue("next", order);
                        }
                      } else if (arr[j] < number &&
                                 arr2[j].find("reminder") != null) {
                        var infind = old.indexOf(arr2[j]);
                        if (infind == -1) {
                          old.add(arr2[j]);
                          Application.Storage.setValue("old", old);
                          pins.remove(arr2[j]);
                          Application.Storage.setValue("pins", pins);
                        }
                      }
                    }

                    add = 0;
                    len = null;
					 
                  }
                }
              } else {
                add = add + 1;
                System.println(add);
              }
            }
          }
        }
      }
    }
  }
  System.println("done");
    
    }
  



    function nextWeekday(weekday) {

        var nowMoment = Time.now();
        var nowInfo = Gregorian.info(nowMoment, Time.FORMAT_SHORT);

        if (weekday < nowInfo.day_of_week || (weekday == nowInfo.day_of_week && dateTimeString.substring(4, 6).toNumber() < nowInfo.hour && dateTimeString.substring(7, 9).toNumber() < nowInfo.min)) {
            weekday += 7;
        }
        var deltaWeekday = weekday - nowInfo.day_of_week;

        var weekdayMoment = nowMoment.add(new Time.Duration(deltaWeekday * Gregorian.SECONDS_PER_DAY));
        var weekdayInfo = Gregorian.info(weekdayMoment, Time.FORMAT_SHORT);

        return weekdayInfo;
    }

    function getMonthLength(nMonthOfYear) {
        var filter = [1, 3, 5, 7, 8, 10, 12];

        if (nMonthOfYear == 2) {
            var result = (ChosenYear / 4);
            result = result.toString();
            if (result.find(".") == null) {
                result = (ChosenYear / 100);
                result = result.toString();
                if (result.find(".") != null) {

                    max = 29;
                } else {

                    result = (ChosenYear / 400);
                    result = result.toString();
                    if (result.find(".") != null) {

                        max = 29;
                    } else {

                        max = 28;
                    }

                }

            } else {

                max = 28;
            }
        } else if (nMonthOfYear != 2) {
            if (filter.indexOf(nMonthOfYear) != -1) {

                max = 31;
            } else {

                max = 30;
            }
        }
        return max;

    }

    function addPin() {




        if (pins == null) {
            pins = [];
        }



        if (inputStr != null && inputStr.length() >= 1) {
            var p = inputStr;
            pins.add(p);
            if (next != null) {
                for (var l = 0; l < next.size(); l++) {
                    if (pins.indexOf(next[l]) == -1) {
                        pins.add(next[l]);
                    }
                }
                Application.Storage.setValue("next", []);
      
                Application.Storage.deleteValue("next");
                Application.Storage.setValue("TE", []);
                Application.Storage.deleteValue("TE");
                nex = null;
                dateTimeString = "";
            }

        }



        if (inputStr != null && inputStr.length() < 1 && pins != null) {
            if (next != null) {
                for (var l = 0; l < next.size(); l++) {
                    if (pins.indexOf(next[l]) == -1) {
                        pins.add(next[l]);
                    }
                }
                Application.Storage.setValue("next", []);
                  
                Application.Storage.deleteValue("next");
              

                nex = null;
                dateTimeString = "";
            }

        }

        inputStr = "";
        newStr = "";

        Application.Storage.setValue("pins", pins);




        PictureTime = 1;

    }
    
    
     


   function setBGEvent() {
    
     
           if (next != null) {
              var str = null;
               if (next[next.size() - 1].find("timer") == null) {
                    var options = {
                       :year => next[next.size() - 1].substring(0, 4).toNumber(),
                       :month => next[next.size() - 1].substring(5, 7).toNumber(),
                        :day => next[next.size() - 1].substring(8, 10).toNumber(),
                        :hour => next[next.size() - 1].substring(11, 13).toNumber(),
                        :minute => next[next.size() - 1].substring(14, 16).toNumber(),
                        :second => next[next.size() - 1].substring(14, 16).toNumber()
                    };
                   closestWake = options;
                   str = next[next.size() - 1].substring(26, next[next.size() - 1].length());
                } else if (next[next.size() - 1].find("timer") != null) {
                    var dayGiven = next[next.size() - 1].substring(0, 4);

                    var weekday = null;

                    if (dayGiven != null) {

                       if (dayGiven.find("MON") != null) {

                            weekday = 2;
                       } else if (dayGiven.find("TUE") != null) {
                            weekday = 3;
                        } else if (dayGiven.find("WED") != null) {
                            weekday = 4;
                        } else if (dayGiven.find("THU") != null) {
                            weekday = 5;
                        } else if (dayGiven.find("FRI") != null) {
                           weekday = 6;
                        } else if (dayGiven.find("SAT") != null) {
                            weekday = 7;
                        } else if (dayGiven.find("SUN") != null) {
                           weekday = 1;
                        }

                       var MonthOfYear = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
                        var TDayOfWeek = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
                        annum = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

                        TDayOfWeek = Lang.format("$1$", [
                            TDayOfWeek.day.format("%02u")
                        ]);

                        MonthOfYear = Lang.format("$1$", [
                            MonthOfYear.month.format("%02u")
                        ]);
                        annum = Lang.format("$1$", [
                            annum.year.format("%04u")
                        ]);
                        var nDayOfWeek = TDayOfWeek.toNumber();
                        var nMonthOfYear = MonthOfYear.toNumber();



                        var NdD = TimelineSnapshotView.nextWeekday(weekday);

                        NdD = NdD.day.format("%02d");

                        NdD = NdD.toNumber();

                        if (nDayOfWeek > NdD && nMonthOfYear == 12) {
                          annum = (annum + 1);
                        }

                        max = TimelineSnapshotView.getMonthLength(nMonthOfYear);
                       if (NdD > max) {
                            NdD = (NdD - max);
                        }

                       if (NdD < nDayOfWeek) {
                            nMonthOfYear = (nMonthOfYear + 1);
                        }
                        var options = {


                            :year => annum.toNumber(),
                            :month => nMonthOfYear.toNumber(),
                            :day => NdD.toNumber(),
                            :hour => next[next.size() - 1].substring(4, 6).toNumber(),
                            :minute => next[next.size() - 1].substring(7, 9).toNumber(),
                            :second => next[next.size() - 1].substring(7, 9).toNumber()
                        };
                        closestWake = options;
                        str = next[next.size() - 1].substring(16, next[next.size() - 1].length());
                       
                    }
                }
                
               closestWake = Gregorian.moment(closestWake);
           //TimeDate = Gregorian.utcInfo(closestWake, Time.FORMAT_MEDIUM);
             if(Background.getTemporalEventRegisteredTime() != null) {
              Background.deleteTemporalEvent();
              System.println("delete");}
          Background.registerForTemporalEvent(closestWake);
             Application.Storage.setValue("Str",str);
            //TimeDate = Gregorian.moment(closestWake);
            // System.println(TimeDate);
          
       
   
       System.println("bg");
        
    
   }


       }
    



    function onShow() {
        animation = 1;
        annum = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        annum = Lang.format("$1$", [
            annum.year.format("%04u")
        ]);
        TimelineSnapshotView.addPin();
        TimelineSnapshotView.CalculateTimes();
    }


    function onHide() {
        PictureTime = null;
    }


}