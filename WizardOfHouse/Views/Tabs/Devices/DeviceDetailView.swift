//
//  DeviceDetailView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct DeviceDetailView: View {
    // MARK: - Properties
    let device: WTDevice
    private var type: String {
        switch device.type {
        case .sensor:
            "Sensor"
        case .onOff:
            "On/Off"
        }
    }
    
    // MARK: View
    var body: some View {
        Form {
            Section("Device Information") {
                Text("Name: \(device.name)")
                Text("Type: \(type)")
                
                if case .onOff(let isOn) = device.type {
                    Text("State: \(isOn ? "On" : "Off")")
                } else if case .sensor(let value) = device.type {
                    Text("Value: \(value)")
                }
                
                if let assignedPerson = device.person {
                    Text("Assigned to: \(assignedPerson.name)")
                }
            }
            
            Section("Device Interface") {
                Text(device.interface)
            }
        }
        .navigationTitle(device.name)
    }
}

#Preview {
    DeviceDetailView(device: WTDevice(name: "Air Conditioner", type: .onOff(isOn: false), interface: "AC Interface"))
}
