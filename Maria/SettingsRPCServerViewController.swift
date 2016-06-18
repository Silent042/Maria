//
//  SettingsRPCServerViewController.swift
//  Maria
//
//  Created by ShinCurry on 16/4/15.
//  Copyright © 2016年 ShinCurry. All rights reserved.
//

import Cocoa

class SettingsRPCServerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        userDefaultsInit()
    }
    
    let defaults = UserDefaults(suiteName: "group.windisco.maria")!
    
    @IBOutlet weak var isAutoConnectAria2Enabled: NSButton!
    
    @IBOutlet weak var host: NSTextField!
    @IBOutlet weak var port: NSTextField!
    
    @IBOutlet weak var basePath: NSTextField!
    @IBOutlet weak var path: NSTextField!
    
    
//    @IBOutlet weak var isSSLEnabled: NSButton!
    
    @IBOutlet weak var secret: NSSecureTextField!
    
    @IBOutlet weak var username: NSTextField!
    @IBOutlet weak var password: NSSecureTextField!
}



extension SettingsRPCServerViewController {
    
    @IBAction func finishEditing(_ sender: NSTextField) {
        var key = ""
        switch sender {
        case host:
            key = "RPCServerHost"
        case port:
            if let intValue = Int(sender.stringValue) {
                defaults.set(intValue, forKey: key)
                defaults.synchronize()
            } else {
                sender.stringValue = "\(defaults.integer(forKey: key))"
            }
            key = "RPCServerPort"
            return
        case path:
            key = "RPCServerPath"
        case secret:
            key = "RPCServerSecret"
        case username:
            key = "RPCServerUsername"
        case password:
            key = "RPCServerPassword"
        default:
            break
        }
        defaults.set(sender.stringValue, forKey: key)
        defaults.synchronize()
    }
    
    @IBAction func enableSSL(_ sender: NSButton) {
        let boolValue = sender.state == 0 ? false : true
        defaults.set(boolValue, forKey: "EnabledSSL")
        defaults.synchronize()
    }
    @IBAction func enableAutoConnectArai2(_ sender: NSButton) {
        let boolValue = sender.state == 0 ? false : true
        defaults.set(boolValue, forKey: "EnableAutoConnectAria2")
        defaults.synchronize()
    }
    
    
}

extension SettingsRPCServerViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        basePath.stringValue = "http(s)://\(host.stringValue):\(port.stringValue)"
    }
}

extension SettingsRPCServerViewController {
    func userDefaultsInit() {
        if let value = defaults.object(forKey: "RPCServerHost") as? String {
            host.stringValue = value
        }
        if let value = defaults.object(forKey: "RPCServerPort") as? String {
            port.stringValue = value
        }
        if let value = defaults.object(forKey: "RPCServerPath") as? String {
            path.stringValue = value
        }
        if let value = defaults.object(forKey: "RPCServerSecret") as? String {
            secret.stringValue = value
        }
        if let value = defaults.object(forKey: "RPCServerUsername") as? String {
            username.stringValue = value
        }
        if let value = defaults.object(forKey: "RPCServerPassword") as? String {
            password.stringValue = value
        }
        
//        isSSLEnabled.state = defaults.bool(forKey: "EnabledSSL") ? 1 : 0
        
        basePath.stringValue = "https://" + host.stringValue + ":" + port.stringValue
        
//        isAutoConnectAria2Enabled.state = defaults.bool(forKey: "EnableAutoConnectAria2") ? 1 : 0
    }
}
