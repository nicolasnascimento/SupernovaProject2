//
//  InterfaceController.swift
//  OrbOrbits WatchKit Extension
//
//  Created by Paulo Ricardo Ramos da Rosa on 5/22/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var imageGroup: WKInterfaceGroup!
    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let appGroupID = "group.com.supernova.OrbitAll"
        let data = NSUserDefaults(suiteName: appGroupID)!
        
        imageGroup.setBackgroundImageNamed("WKAppAnimation_")
        if let nsvalue = data.objectForKey("local") as? NSNumber {
            scoreLabel.setText(nsvalue.stringValue)
        }
        imageGroup.startAnimating()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
