//
//  EnvironmentPeopleSelectionView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentPeopleSelectionView: View {
    // MARK: - Properties
    @Environment(\.appState) var appState
    @Environment(\.dismiss) var dismiss
    @State private var environment: WTEnvironment
    @State private var selectedPpl: Set<WTPerson>
    
    // MARK: - Methods
    private func create() {
        let newEnvironment = WTEnvironment(description: environment.description,
                                           area: environment.area,
                                           people: selectedPpl)
        appState.environments.append(newEnvironment)
        dismiss()
    }
    
    // MARK: - Initialization
    init(environment: WTEnvironment) {
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
        EnvironmentPeopleSelectionView(environment: WTEnvironment(description: "description goes here", area: .medium, people: []))
    }
}
