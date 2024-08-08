//
//  EnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentsView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @State private var showAddEnvironment: Bool = false
    @State private var people: [String] = ["Reza"]
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List($wizardService.environments, id: \.self) { $environment in
                NavigationLink {
                    EnvironmentView(wizardService: wizardService, environment: $environment)
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
                AddNewEnvironmentView(wizardService: wizardService)
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return EnvironmentsView(wizardService: dependencyContainer.wizardService)
}
