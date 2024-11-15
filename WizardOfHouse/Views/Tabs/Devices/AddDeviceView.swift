//
//  AddDeviceView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct AddDeviceView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @Environment(\.dismiss) var dismiss
    var people: [WTPerson] {
        wizardService.people
    }
    @State private var deviceName: String  = ""
    @State private var deviceType: WTDeviceType = .onOff(isOn: false)
    @State private var isOn: Bool = false
    @State private var deviceInterface: String = ""
    @State private var selectedPerson: WTPerson?
    @FocusState private var deviceNameFocused: Bool
    
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
        wizardService.devices.append(newDevice)
        dismiss()
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                TextField("Device Name", text: $deviceName)
                    .foregroundStyle(.white)
                    .tint(Color.blue)
                    .listRowBackground(Color.white.opacity(0.3))
                
                Picker("Type", selection: $deviceType) {
                    Text("On/Off")
                        .tag(WTDeviceType.onOff(isOn: isOn))
                    
                    Text("Sensor")
                        .tag(WTDeviceType.sensor(value: ""))
                }
                .listRowBackground(Color.white.opacity(0.3))
                .pickerStyle(.segmented)
                
                switch deviceType {
                case .sensor(let value):
                    EmptyView()
                case .onOff(let isOn):
                    Toggle(isOn: $isOn) {
                        Text("Initial State")
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(Color.white.opacity(0.3))
                }
                
                TextField("Device Interface", text: $deviceInterface)
                    .foregroundStyle(Color.white)
                    .listRowBackground(Color.white.opacity(0.3))
                
                Section("Assign To Person") {
                    Picker("Person", selection: $selectedPerson) {
                        Text("None")
                            .foregroundStyle(Color(hex: "0C0A3E"))
                            .tag(nil as WTPerson?)
                        ForEach(people) { person in
                            Text(person.name)
                                .foregroundStyle(Color(hex: "0C0A3E"))
                                .tag(person as? WTPerson)
                        }
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(Color.white.opacity(0.3))
                }
                .foregroundStyle(Color(hex: "F3C677"))
                
                Button("Add Device") {
                    addDevice()
                }
                .foregroundStyle(Color(hex: "F3C677"))
                .listRowBackground(Color.white.opacity(0.3))
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: "972F6E"))
            .navigationTitle("Add Device")
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(Color(hex: "F9564F"))
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return AddDeviceView(wizardService: dependencyContainer.wizardService)
}
