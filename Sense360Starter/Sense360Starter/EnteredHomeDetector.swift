//
//  EnteredHomeDetector.swift
//  Sense360Starter
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

import UIKit
import SenseSdk

class EnteredHomeDetector: TriggerFiredDelegate {
   
    func homeDetectionStart() {
        let errorPointer = SenseSdkErrorPointer.create()
        // Fire when the user enters home
        let trigger = FireTrigger.whenEntersPersonalizedPlace("ArrivedAtHome", type: .Home, errorPtr: errorPointer)
        
        if let homeTrigger = trigger {
            // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" method below
            SenseSdk.register(trigger: homeTrigger, delegate: self)
        }
        
        if errorPointer.error != nil {
            NSLog("Error!: \(errorPointer.error.message)")
        }

    }
    
    @objc func triggerFired(args: TriggerFiredArgs) {
        
        // Your user has entered at home!
        
        NSLog("Trigger \(args.trigger.name) fired at \(args.timestamp).");
        for place in args.places {
            NSLog(place.description)
            
            //This is where YOU write your custom code.
            //As an example, we are sending a local notification that describes the transition type and place.
            //For more information go to: http://sense360.com/docs.html#handling-a-recipe-firing
            let transitionDesc = args.trigger.transitionType.description
            NotificationSender.send("\(transitionDesc) \(place.description)")
            
        }
    }
}