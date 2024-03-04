//
// Copyright 2017-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Application.Storage;
import Toybox.Background;
import Toybox.Lang;
import Toybox.System;

//! The Service Delegate is the main entry point for background processes.
//! Our onTemporalEvent() method will run each time our periodic event
//! is triggered by the system. This indicates a set timer has expired, and
//! we should attempt to notify the user.
(:background)
class MyServiceDelegate extends System.ServiceDelegate {

    //! Constructor
    public function initialize() {
        ServiceDelegate.initialize();
        inBackground=true;	
    }

    //! If our timer expires, it means the application timer ran out,
    //! and the main application is not open. Prompt the user to let them
    //! know the timer expired.
    
     
    
    public function onTemporalEvent() as Void {

         var label = Application.Storage.getValue("str");
      Background.requestApplicationWake("Time for: " + label);
     
        Background.exit(true);
    }
}
