//
//  MobileDeviceFingerprintTests.swift
//  MobileDeviceFingerprintTests
//  The tests must be run using the simulator: iPhone 6s Plus (9.1)
//
//  Created by Anderson Ito on 11/19/15.
//  Copyright © 2015 PayU BCash. All rights reserved.
//

import XCTest
@testable import MobileDeviceFingerprint

class MobileDeviceFingerprintTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRegisterUUID() {
        let localService = MobileDeviceFingerprint()
        localService.registerUUID()
        print(localService.getDeviceId())
    }
    
    func testGetDeviceId() {
        let service = MobileDeviceFingerprint()
        service.registerUUID()
        XCTAssertEqual("93BF0097-8051-4CEF-AA35-2F970A090C80", service.getDeviceId())
    }
    
    func testGetDeviceName() {
        let service = MobileDeviceFingerprint()
        service.registerUUID()
        XCTAssertEqual("iPhone Simulator", service.getDeviceName())
    }
    
    func testGetOSName() {
        let service = MobileDeviceFingerprint()
         XCTAssertEqual("iPhone OS", service.getOSName())
    }
    
    func testGetOSVersion() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("9.3", service.getOSVersion())
    }
    
    func testGetCarrier() {
        let service = MobileDeviceFingerprint()
        // a operadora no simulador vem sempre em branco por ser um simulador
        XCTAssertEqual("", service.getCarrier())
    }
    
    func testGetModel() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("Simulator", service.getModel())
    }
    
    func testGetManufacturer() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("Apple", service.getManufacturer())
    }
    
    func testGetSSID() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("Unavailable", service.getSsidWifi())
    }
    
    func testGetDeviceFingerprint() {
        self.measureBlock {
            let service = MobileDeviceFingerprint()
            XCTAssertEqual("{\"plataforma\":\"IOS\",\"fabricante\":\"Apple\",\"deviceID\":\"93BF0097-8051-4CEF-AA35-2F970A090C80\",\"modelo\":\"Simulator\",\"operadora\":\"\",\"os\":\"iPhone OS\",\"osVersion\":\"9.3\",\"deviceName\":\"iPhone Simulator\",\"ssidWifi\":\"Unavailable\",\"ddd\":\"\",\"telefone\":\"\",\"latitude\":\"\",\"longitude\":\"\"}", service.getDeviceFingerprint())
        }
    }
    
    func testGetAreaCode() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("", service.getAreaCode())
    }
    
    func testGetPhone() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("", service.getPhoneNumber())
    }
    
    func testGetLatitude() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("", service.getLatitude())
    }
    
    func testGetLongitude() {
        let service = MobileDeviceFingerprint()
        XCTAssertEqual("", service.getLongitude())
    }
    
}
