//
//  PeopleView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct PeopleView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @State private var showAddPerson: Bool = false
    
    // MARK: - Helper Methods
    private func deletePerson(_ indexSet: IndexSet) {
        wizardService.people.remove(atOffsets: indexSet)
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List {
                Section("People") {
                    ForEach(wizardService.people) { person in
                        VStack(alignment: .leading) {
                            Text(person.name.capitalized)
                                .font(.headline)
                            Text(person.bio)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: deletePerson)
                }
            }
            .navigationTitle("People")
            .toolbar {
                Button {
                    showAddPerson = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddPerson) {
                AddPersonView(wizardService: wizardService)
            }
        }
    }
}

#Preview {
    PeopleView(wizardService: .Sample)
}
