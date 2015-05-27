//
//  NotificationController.swift
//  OrbOrbits WatchKit Extension
//
//  Created by Paulo Ricardo Ramos da Rosa on 5/22/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak var notificationText: WKInterfaceLabel!
    @IBOutlet weak var notificationImage: WKInterfaceImage!
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        if let userInfo = localNotification.userInfo {
            if let text = userInfo["notificationText"] as? String {
                 self.notificationText.setText(text)
            }else{
                self.notificationText.setText("Your Orbits Are Missing You!")
            }
        }
        self.notificationImage.setImageNamed("animacao")
        self.notificationImage.startAnimatingWithImagesInRange(NSRange(location: 0, length: 29), duration: 1, repeatCount: 1)
        completionHandler(.Custom)
    }
    
    
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        //self.notificationText.setText(remoteNotification["notificationText"] as? String)
        if let text = remoteNotification["notificationText"] as? String {
            self.notificationText.setText(text)
        }else{
            self.notificationText.setText("Your Orbits Are Missing You!")
        }
        self.notificationImage.setImageNamed("animacao")
        self.notificationImage.startAnimatingWithImagesInRange(NSRange(location: 0, length: 30), duration: 1, repeatCount: 1)
        println(remoteNotification)
        completionHandler(.Custom)
    }
}