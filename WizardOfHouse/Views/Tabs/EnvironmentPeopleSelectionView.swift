//
//  EnvironmentPeopleSelectionView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentPeopleSelectionView: View {
    // MARK: - Properties
    var appState: AppState
    let onCompletion: DismissAction?
    @State private var environment: WTEnvironment
    @State private var selectedPpl: Set<WTPerson>
    
    // MARK: - Methods
    private func create() {
        let newEnvironment = WTEnvironment(description: environment.description,
                                           area: environment.area,
                                           people: selectedPpl)
        appState.environments.append(newEnvironment)
        onCompletion?()
    }
    
    // MARK: - Initialization
    init(appState: AppState, environment: WTEnvironment, onCompletion: DismissAction?) {
        self.onCompletion = onCompletion
        self.appState = appState
        self._environment = .init(initialValue: environment)
        self._selectedPpl = .init(initialValue: Set<WTPerson>())
    }
    
    // MARK: - View
    var body: some View {
        List(appState.people) { person in
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
    NavigationStack {
        EnvironmentPeopleSelectionView(appState: AppState(), environment: WTEnvironment(description: "description goes here", area: .medium, people: []), onCompletion: nil)
    }
}
