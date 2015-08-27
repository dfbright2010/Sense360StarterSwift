//
//  EnteredRestaurantDetector.swift
//  Sense360Starter
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

import UIKit
import SenseSdk

class EnteredRestaurantDetector: TriggerFiredDelegate {

    func restaurantDetectionStart() {
        let errorPointer = SenseSdkErrorPointer.create()
        // Fire when the user enters a restaurant
        let trigger = FireTrigger.whenEntersPoi("ArrivedAtRestaurant", type: .Restaurant, errorPtr: errorPointer)
        
        if let restaurantTrigger = trigger {
            // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" method below
            SenseSdk.register(trigger: restaurantTrigger, delegate: self)
        }
        
        if errorPointer.error != nil {
            NSLog("Error!: \(errorPointer.error.message)")
        }
    }
    
    @objc func triggerFired(args: TriggerFiredArgs) {
        
        // Your user has entered a restaurant!
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


