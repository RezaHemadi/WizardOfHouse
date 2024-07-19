//
//  DevicesView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct DevicesView: View {
    // MARK: - Properties
    @Environment(\.appState) var appState
    @State private var showAddDevice: Bool = false
    
    // MARK: Helper Methods
    private func deleteDevice(_ indexSet: IndexSet) {
        appState.devices.remove(atOffsets: indexSet)
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List {
                ForEach(appState.devices) { device in
                    NavigationLink {
                        DeviceDetailView(device: device)
                    } label: {
                        DeviceRowView(device: device)
                    }
                }
                .onDelete(perform: deleteDevice)
            }
            .navigationTitle("Devices")
            .toolbar {
                Button {
                    showAddDevice = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddDevice) {
                AddDeviceView(appState: appState)
            }
        }
    }
}

#Preview {
    DevicesView()
}
