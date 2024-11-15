//
//  AddNewEnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

enum EnvironmentPath: Hashable {
    case root
    case peopleSelection
}

struct AddNewEnvironmentView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @Environment(\.dismiss) private var dismiss
    @State private var area: WTEnvironmentArea = .small
    @State private var description: String = ""
    @State private var path = NavigationPath()
    
    var environment: WTEnvironment {
        WTEnvironment(description: description, area: area, people: [])
    }
    
    // MARK: View
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                TextField("Description", text: $description)
                    .foregroundStyle(.white)
                    .listRowBackground(Color.white.opacity(0.3))
                
                Picker("Area", selection: $area) {
                    ForEach(WTEnvironmentArea.allCases) { enArea in
                        Text(enArea.rawValue.capitalized)
                            .tag(enArea)
                    }
                }
                .foregroundStyle(.white)
                .listRowBackground(Color.white.opacity(0.3))
            }
            .navigationTitle("Add New Environment")
            .scrollContentBackground(.hidden)
            .background(Color(hex: "972F6E"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .foregroundStyle(Color(hex: "F9564F"))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(value: EnvironmentPath.peopleSelection) {
                        Text("Next")
                            .foregroundStyle(Color(hex: "F3C677"))
                    }
                }
            }
            .navigationDestination(for: EnvironmentPath.self) { environmentPath in
                switch environmentPath {
                case .root:
                    AddNewEnvironmentView(wizardService: wizardService)
                case .peopleSelection:
                    EnvironmentPeopleSelectionView(wizardService: wizardService,
                                                   environment: environment,
                                                   path: $path,
                                                   onCompletion: dismiss)
                }
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return AddNewEnvironmentView(wizardService: dependencyContainer.wizardService)
}
