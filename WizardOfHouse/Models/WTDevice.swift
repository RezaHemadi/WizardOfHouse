//
//  WTDevice.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

struct WTDevice: Identifiable {
    // MARK: - Properties
    var id = UUID()
    var name: String
    var type: WTDeviceType
    var interface: String
    /// The person whom this device is assigned to
    var person: WTPerson?
}

extension WTDevice {
    static let SampleDevices: [WTDevice] = [
        WTDevice(name: "Air Conditioner", type: .onOff(isOn: false), interface: "AC Interface"),
        WTDevice(name: "Garage Door", type: .onOff(isOn: false), interface: "Remote Control"),
        WTDevice(name: "Bedroom Light", type: .onOff(isOn: true), interface: "Switch"),
        WTDevice(name: "Oven", type: .sensor(value: "54F"), interface: "Manual")
    ]
}
