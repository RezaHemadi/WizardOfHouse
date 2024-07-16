//
//  AddDeviceView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct AddDeviceView: View {
    // MARK: - Properties
    @Environment(\.appState) var appState
    @Environment(\.dismiss) var dismiss
    var people: [WTPerson] {
        appState.people
    }
    @State private var deviceName: String  = ""
    @State private var deviceType: WTDeviceType = .onOff(isOn: false)
    @State private var isOn: Bool = false
    @State private var deviceInterface: String = ""
    @State private var selectedPerson: WTPerson?
    
    private var resolvedDeviceType: WTDeviceType {
        switch deviceType {
        case .sensor(let value):
            return WTDeviceType.sensor(value: "")
        case .onOff(let isOn):
            return WTDeviceType.onOff(isOn: isOn)
        }
    }
    
    // MARK: - Helper Methods
    private func addDevice() {
        let newDevice = WTDevice(name: deviceName,
                                 type: resolvedDeviceType,
                                 interface: deviceInterface,
                                 person: selectedPerson)
        appState.devices.append(newDevice)
        dismiss()
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                TextField("Device Name", text: $deviceName)
                Picker("Type", selection: $deviceType) {
                    Text("On/Off")
                        .tag(WTDeviceType.onOff(isOn: isOn))
                    Text("Sensor")
                        .tag(WTDeviceType.sensor(value: ""))
                }
                .pickerStyle(.segmented)
                
                switch deviceType {
                case .sensor(let value):
                    EmptyView()
                case .onOff(let isOn):
                    Toggle(isOn: $isOn) {
                        Text("Initial State")
                    }
                }
                
                Section("Device Interface") {
                    TextEditor(text: $deviceInterface)
                }
                
                Section("Assign To Person") {
                    Picker("Person", selection: $selectedPerson) {
                        Text("None")
                            .tag(nil as WTPerson?)
                        ForEach(people) { person in
                            Text(person.name)
                                .tag(person as? WTPerson?)
                        }
                    }
                }
                
                Button("Add Device") {
                    addDevice()
                }
            }
            .navigationTitle("Add Device")
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddDeviceView()
}
