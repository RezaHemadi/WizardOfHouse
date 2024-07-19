//
//  EnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentsView: View {
    // MARK: - Properties
    @ObservedObject var appState: AppState
    @State private var showAddEnvironment: Bool = false
    @State private var people: [String] = ["Reza"]
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List($appState.environments, id: \.self) { $environment in
                NavigationLink {
                    EnvironmentView(environment: $environment)
                } label: {
                    Text($environment.wrappedValue.description)
                }
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
                AddNewEnvironmentView(appState: appState)
            }
        }
    }
}

#Preview {
    EnvironmentsView(appState: AppState())
}
