//
//  DeviceRowView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct DeviceRowView: View {
    // MARK: - Properties
    let device: WTDevice
    
    // MARK: - View
    var body: some View {
        HStack {
            Text(device.name)
            Spacer()
            
            switch device.type {
            case .sensor(let value):
                Text("Value: \(value)")
            case .onOff(let isOn):
                Text(isOn ? "On": "Off")
            }
            
            if let assignedPerson = device.person {
                Text("Assigned to: \(assignedPerson.name)")
            }
        }
    }
}

#Preview {
    DeviceRowView(device: WTDevice(name: "Air Conditioner", type: .onOff(isOn: false), interface: "AC Interface"))
}
