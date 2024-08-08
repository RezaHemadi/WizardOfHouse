//
//  AddNewEnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct AddNewEnvironmentView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @Environment(\.dismiss) private var dismiss
    @State private var area: WTEnvironmentArea = .small
    @State private var description: String = ""
    
    var environment: WTEnvironment {
        WTEnvironment(description: description, area: area, people: [])
    }
    
    // MARK: View
    var body: some View {
        NavigationStack {
            Form {
                TextField("Description", text: $description)
                
                Picker("Area", selection: $area) {
                    ForEach(WTEnvironmentArea.allCases) { enArea in
                        Text(enArea.rawValue.capitalized)
                            .tag(enArea)
                    }
                }
            }
            .navigationTitle("Add New Environment")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        EnvironmentPeopleSelectionView(wizardService: wizardService,
                                                       environment: environment,
                                                       onCompletion: dismiss)
                    } label: {
                        Text("Next")
                    }
                }
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return AddNewEnvironmentView(wizardService: dependencyContainer.wizardService)
}
