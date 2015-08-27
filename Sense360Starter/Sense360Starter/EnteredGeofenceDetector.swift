//
//  EnteredGeofenceDetector.swift
//  Sense360Starter
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

import UIKit
import SenseSdk

class EnteredGeofenceDetector: TriggerFiredDelegate {
    
    func geofenceDetectionStart() {
        let errorPointer = SenseSdkErrorPointer.create()
        
        // Create two geofences
        let hq = CustomGeofence(latitude: 37.124, longitude: -127.456, radius: 50, customIdentifier: "Sense 360 Headquarters")
        let lunchSpot = CustomGeofence(latitude: 37.124, longitude: -127.456, radius: 50, customIdentifier: "A&B Bar and Grill")
        
        // Fire on both hq and lunchSpot
        let trigger: Trigger? = FireTrigger.whenEntersGeofences("ArrivedAtGeofence", geofences: [hq, lunchSpot])
        
        if let geofenceTrigger = trigger {
            // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" method below
            SenseSdk.register(trigger: geofenceTrigger, delegate: self)
        }
    }
    
    
    @objc func triggerFired(args: TriggerFiredArgs) {
        
        // Your user has entered a geofence!
        
        NSLog("Recipe \(args.trigger.name) fired at \(args.timestamp).");
        for place in args.places {

            //This is where YOU write your custom code.
            //As an example, we are sending a local notification that describes the transition type and place.
            //For more information go to: http://sense360.com/docs.html#handling-a-recipe-firing
            let transitionDesc = args.trigger.transitionType.description
            NotificationSender.send("\(transitionDesc) \(place.description)")
            
        }
    }
}
