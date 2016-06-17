//
//  DeviceFingerprint.swift
//  MobileDeviceFingerprint
//
//  Created by Anderson Ito on 11/19/15.
//  Copyright © 2015 PayU BCash. All rights reserved.
//

import Foundation
import CoreTelephony
import SystemConfiguration.CaptiveNetwork

public class MobileDeviceFingerprint {
    // MARK: Attributes
    var operadora : String = ""
    let fabricante : String = "Apple"
    var modelo : String = ""
    var deviceID : String = ""
    var osName : String = ""
    var osVersion : String = ""
    var deviceName : String = ""
    var areaCode : String = ""
    var phoneNumber : String = ""
    var ssidWifi : String = ""
    var latitude : String = ""
    var longitude : String = ""
    
    // MARK: Public methods
    public init() {
        operadora = retrieveCarrier() == nil ? "carrierNotDetected" : retrieveCarrier()
        modelo = retrieveDeviceModel() == nil ? "deviceModelNotDetected": retrieveDeviceModel()
        deviceID = retrieveUUID() == nil ? "uuidNotDetected" : retrieveUUID()
        osName = retrieveOperatingSystemName()
        osVersion = retrieveOperatingSystemVersion()
        deviceName = retrieveDeviceName()
        ssidWifi = retrieveSsidWifi()
    }
    
    public func registerUUID() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.objectForKey(FingerprintUserDefaults.DeviceFingerprintAttribute.rawValue) == nil {
            let UUID = NSUUID().UUIDString
            userDefaults.setObject(UUID, forKey: FingerprintUserDefaults.DeviceFingerprintAttribute.rawValue)
            userDefaults.synchronize()
        }
    }
    
    public func setLatitude(latitude : String) {
        self.latitude = latitude;
    }
    
    public func getLatitude() -> String {
        return latitude
    }
    
    public func setLongitude(longitude : String) {
        self.longitude = longitude
    }
    
    public func getLongitude() -> String {
        return longitude
    }
    
    public func setAreaCode(areaCode : String) {
        self.areaCode = areaCode
    }
    
    public func getAreaCode() -> String {
        return areaCode
    }
    
    public func setPhoneNumber(number : String) {
        phoneNumber = number
    }
    
    public func getPhoneNumber() -> String {
        return phoneNumber
    }
    
    public func getCarrier() -> String {
        return operadora
    }
    
    public func getModel() -> String {
        return modelo
    }
    
    public func getManufacturer() -> String {
        return fabricante
    }
    
    public func getDeviceId() -> String {
        return deviceID
    }
    
    public func getOSName() -> String {
        return osName
    }
    
    public func getOSVersion() -> String {
        return osVersion
    }
    
    public func getDeviceName() -> String {
        return deviceName
    }
    
    public func getSsidWifi() -> String {
        return ssidWifi
    }
    
    public func getDeviceFingerprint() -> String {
        let result = "{" + "\"plataforma\":\"IOS\"," + "\"fabricante\":\"" + fabricante + "\"," + "\"deviceID\":\"" + deviceID + "\"," + "\"modelo\":\"" + modelo + "\"," + "\"operadora\":\"" + operadora + "\"," + "\"os\":\"" + osName + "\"," + "\"osVersion\":\"" + osVersion + "\"," + "\"deviceName\":\"" + deviceName + "\",\"ssidWifi\":\"" + ssidWifi + "\",\"ddd\":\"" + areaCode + "\",\"telefone\":\"" + phoneNumber + "\",\"latitude\":\"" + latitude + "\",\"longitude\":\"" + longitude + "\"}"
        return result
    }
    
    
    // MARK: Internal functions
    internal func retrieveDeviceModel() -> String! {
        return hardwareDescription()
    }
    
    internal func retrieveCarrier() -> String! {
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        if carrier == nil || carrier?.carrierName == nil {
            return ""
        }
        return carrier?.carrierName
    }
    
    internal func retrieveUUID() -> String! {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.objectForKey(FingerprintUserDefaults.DeviceFingerprintAttribute.rawValue) == nil {
            return ""
        }
        return userDefaults.stringForKey(FingerprintUserDefaults.DeviceFingerprintAttribute.rawValue)
    }
    
    internal func retrieveOperatingSystemName() -> String {
        return UIDevice.currentDevice().systemName
    }
    
    internal func retrieveOperatingSystemVersion() -> String {
        return UIDevice.currentDevice().systemVersion
    }
    
    internal func retrieveDeviceName() -> String {
        return UIDevice.currentDevice().name
    }
    
    internal func retrieveSsidWifi() -> String {
        var ssidWifi = ""
        
        if #available(iOS 8.1, *) {
            if #available (iOS 9.2, *) {
                ssidWifi = "Unavailable"
                return ssidWifi
            }
            
            if let interfaces:CFArray! = CNCopySupportedInterfaces() {
                if(interfaces != nil) {
                    for i in 0..<CFArrayGetCount(interfaces){
                        let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                        let rec = unsafeBitCast(interfaceName, AnyObject.self)
                        let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                        if unsafeInterfaceData != nil {
                            let interfaceData = unsafeInterfaceData! as Dictionary!
                            ssidWifi = interfaceData["SSID"] as! String
                        }
                    }
                }
            }
        }
        
        return ssidWifi
    }
}