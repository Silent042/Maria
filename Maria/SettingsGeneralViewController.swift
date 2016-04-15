//
//  SettingsGeneralViewController.swift
//  Maria
//
//  Created by ShinCurry on 16/4/16.
//  Copyright © 2016年 ShinCurry. All rights reserved.
//

import Cocoa

class SettingsGeneralViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        webAppPath.stringValue = defaults.objectForKey("WebAppPath") as! String
    }
    
    let defaults = NSUserDefaults(suiteName: "group.windisco.maria")!
    
    @IBOutlet weak var webAppPath: NSTextField!
    
    @IBAction func finishEditing(sender: NSTextField) {
        defaults.setObject(sender.stringValue, forKey: "WebAppPath")
        defaults.synchronize()
    }
}


