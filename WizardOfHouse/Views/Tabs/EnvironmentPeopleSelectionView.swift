//
//  EnvironmentPeopleSelectionView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentPeopleSelectionView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    let onCompletion: DismissAction?
    @State private var environment: WTEnvironment
    @State private var selectedPpl: Set<WTPerson>
    
    // MARK: - Methods
    private func create() {
        let newEnvironment = WTEnvironment(description: environment.description,
                                           area: environment.area,
                                           people: selectedPpl)
        wizardService.environments.append(newEnvironment)
        onCompletion?()
    }
    
    // MARK: - Initialization
    init(wizardService: WizardService, environment: WTEnvironment, onCompletion: DismissAction?) {
        self.onCompletion = onCompletion
        self._wizardService = .init(wrappedValue: wizardService)
        self._environment = .init(initialValue: environment)
        self._selectedPpl = .init(initialValue: Set<WTPerson>())
    }
    
    // MARK: - View
    var body: some View {
        List(wizardService.people) { person in
            PersonSelectionRow(person: person, selected: selectedPpl.contains(person))
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedPpl.contains(person) {
                        selectedPpl.remove(person)
                    } else {
                        selectedPpl.insert(person)
                    }
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Create") {
                    create()
                }
            }
        }
        .navigationTitle("Add People")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return NavigationStack {
        EnvironmentPeopleSelectionView(wizardService: dependencyContainer.wizardService,
                                       environment: WTEnvironment(description: "description goes here", area: .medium, people: []),
                                       onCompletion: nil)
    }
}
