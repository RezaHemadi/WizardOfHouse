//
//  EnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @Environment(\.appState) var appState
    @Binding var environment: WTEnvironment
    @State private var description: String
    @State private var area: WTEnvironmentArea
    @State private var selectedPpl: Set<WTPerson>
    
    // MARK: - Initialization
    init(environment: Binding<WTEnvironment>) {
        self._environment = environment
        self.description = environment.wrappedValue.description
        self.area = environment.wrappedValue.area
        self.selectedPpl = environment.wrappedValue.people
    }
    
    // MARK: - Methods
    private func save() {
        environment = WTEnvironment(description: self.description, area: self.area, people: self.selectedPpl)
        dismiss()
    }
    
    // MARK: - View
    var body: some View {
        List {
            TextField("Description", text: $description)
            
            Picker("Area", selection: $area) {
                ForEach(WTEnvironmentArea.allCases) { enArea in
                    Text(enArea.rawValue.capitalized)
                        .tag(enArea)
                }
            }
            
            Section("Assigned People") {
                ForEach(appState.people) { person in
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
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    save()
                }
            }
        }
    }
}

#Preview {
    EnvironmentView(environment: .constant(WTEnvironment(description: "description goes here", area: .medium, people: [])))
}
