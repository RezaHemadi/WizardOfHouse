//
//  DevicesView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct DevicesView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @State private var showAddDevice: Bool = false
    
    // MARK: Helper Methods
    private func deleteDevice(_ indexSet: IndexSet) {
        wizardService.devices.remove(atOffsets: indexSet)
    }
    
    init(wizardService: WizardService) {
        self._wizardService = .init(wrappedValue: wizardService)
        
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List {
                ForEach(wizardService.devices) { device in
                    NavigationLink {
                        DeviceDetailView(device: device)
                    } label: {
                        DeviceRowView(device: device)
                    }
                }
                .onDelete(perform: deleteDevice)
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: "892774"))
            .navigationTitle("Devices")
            .toolbar {
                Button {
                    showAddDevice = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color(hex: "F3C677"))
                }
            }
            .sheet(isPresented: $showAddDevice) {
                AddDeviceView(wizardService: wizardService)
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    DevicesView(wizardService: dependencyContainer.wizardService)
}
