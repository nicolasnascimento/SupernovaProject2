//
//  GlanceController.swift
//  OrbOrbits WatchKit Extension
//
//  Created by Paulo Ricardo Ramos da Rosa on 5/22/15.
//  Copyright (c) 2015 NotACompany. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var scoresTable: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let appGroupID = "group.com.supernova.OrbitAll"
        let data = NSUserDefaults(suiteName: appGroupID)!
        scoresTable.setNumberOfRows(3, withRowType: "scoreRow")

        
        
        for i in 0..<3{
            var str = NSString(format:"score%d", i)
            var nameStr = NSString(format: "name%d", i)
            var value : Int = 0
            var name : String = ""
            if let nsvalue = data.objectForKey(str as String) as? NSNumber {
                value = nsvalue.integerValue
                println(value)
                var a = String(value)
            }
            if let strValue = data.objectForKey(nameStr as String) as? String {
                name = strValue
            }
            
            if let row = scoresTable.rowControllerAtIndex(i) as? scoreRow{
                row.scoreLbl.setText(String(format:"%ld", value))
                row.nameLbl.setText(name)
            }
            
//            var str = NSString(format:"name%d", i)
//            var value : String = ""
//            if let nsvalue = data.objectForKey(str as String) as? NSNumber {
//                value = nsvalue.stringValue
//                println(value)
//            }else{
//                println("NOT FOUND")
//            }
//            if let row = scoresTable.rowControllerAtIndex(i) as? scoreRow{
//                row.scoreLbl.setText(String(format:"%ld", value))
//            }
        }
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
