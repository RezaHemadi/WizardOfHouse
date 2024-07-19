//
//  AddPersonView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct AddPersonView: View {
    // MARK: - Properties
    var appState: AppState
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var bio: String = ""
    
    // MARK: - Helper Methods
    private func addPerson() {
        let newPerson = WTPerson(name: name, bio: bio)
        appState.people.append(newPerson)
        dismiss()
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Bio", text: $bio)
                Button("Add Person") {
                    addPerson()
                }
            }
            .navigationTitle("New Person")
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddPersonView(appState: AppState())
}
