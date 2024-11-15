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
                ForEach(wizardService.people) { person in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(person.name.capitalized)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            if let age = person.age {
                                Text(String(age))
                                    .font(.footnote)
                                    .foregroundStyle(Color(hex: "EFD9CE"))
                            }
                        }
                        Text(person.bio)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(Color.white.opacity(0.3))
                }
                .onDelete(perform: deletePerson)
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: "892774"))
            .navigationTitle("People")
            .toolbar {
                Button {
                    showAddPerson = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color(hex: "F3C677"))
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
