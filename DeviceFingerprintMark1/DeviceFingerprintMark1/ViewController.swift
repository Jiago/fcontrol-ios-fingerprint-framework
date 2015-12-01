//
//  ViewController.swift
//  DeviceFingerprintMark1
//
//  Created by Anderson Ito on 11/13/15.
//  Copyright © 2015 Anderson Keiji Matsuki Ito. All rights reserved.
//

import UIKit
import CoreTelephony
import SystemConfiguration.CaptiveNetwork
import CoreLocation
import NetworkExtension
import MobileDeviceFingerprint

class ViewController: UIViewController {

    
    // MARK: Properties
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var osVersionLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var carrierLabel: UILabel!
    @IBOutlet weak var ssidLabel: UILabel!
    @IBOutlet weak var hardwareLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loadInformation(sender: AnyObject) {
        modelLabel.text = UIDevice.currentDevice().model
        osLabel.text = UIDevice.currentDevice().systemName
        osVersionLabel.text = UIDevice.currentDevice().systemVersion
        systemNameLabel.text = UIDevice.currentDevice().name
        
        let service = MobileDeviceFingerprint()
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        if carrier?.carrierName == nil {
            carrierLabel.text = service.getDeviceFingerprint()
            let debugDevice = service.getDeviceFingerprint()
            print(debugDevice)
        } else {
            carrierLabel.text = carrier?.carrierName
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.objectForKey("ApplicationUniqueIdentifier") == nil {
            uuidLabel.text = "None"
        } else {
            uuidLabel.text = userDefaults.stringForKey("ApplicationUniqueIdentifier")
        }

        ssidLabel.text = SSID()
        hardwareLabel.text = hardwareDescription()
    }
    
    
    func SSID() -> String {
        var currentSSID = "None"
        if let interfaces:CFArray! = CNCopySupportedInterfaces() {
            if(interfaces != nil) {
                for i in 0..<CFArrayGetCount(interfaces){
                    let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                    let rec = unsafeBitCast(interfaceName, AnyObject.self)
                    let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                    if unsafeInterfaceData != nil {
                        let interfaceData = unsafeInterfaceData! as Dictionary!
                        currentSSID = interfaceData["SSID"] as! String
                    }
                }
            }
        }
        return currentSSID
    }
    
    //func getWifiSSID() -> String {
    //    var ssid = "Unknown"
    //    let items = NEHotspotHelper.supportedNetworkInterfaces()
    //    for item in items {
    //        ssid = item.SSID
    //    }
    //    return ssid
    //}
}

