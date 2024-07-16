//
//  EnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentsView: View {
    // MARK: - Properties
    @Environment(\.appState) var appState
    @State private var showAddEnvironment: Bool = false
    
    // MARK: Helper Methods
    private func deleteDevice(_ indexSet: IndexSet) {
        appState.devices.remove(atOffsets: indexSet)
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List {
                ForEach(appState.environments) { environment in
                    NavigationLink {
                        EnvironmentView(environment: environment)
                    } label: {
                        Text(environment.description)
                    }
                }
                .onDelete(perform: deleteDevice)
            }
            .navigationTitle("Environments")
            .toolbar {
                Button {
                    showAddEnvironment = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddEnvironment) {
                AddNewEnvironmentView()
            }
        }
    }
}

#Preview {
    EnvironmentsView()
}
