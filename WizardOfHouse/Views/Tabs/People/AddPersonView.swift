//
//  AddPersonView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct AddPersonView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var occupation: String = ""
    @State private var activities: [String] = []
    @State private var goals: [String] = []
    @State private var age: Int?
    
    // MARK: - Helper Methods
    private func addPerson() {
        let newPerson = WTPerson(name: name, bio: bio, age: age, activities: activities, goals: goals)
        wizardService.people.append(newPerson)
        dismiss()
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .foregroundStyle(.white)
                    .listRowBackground(Color.white.opacity(0.3))
                
                TextField("Bio", text: $bio)
                    .foregroundStyle(.white)
                    .listRowBackground(Color.white.opacity(0.3))
                
                TextField("Occupation", text: $occupation)
                    .foregroundStyle(.white)
                    .listRowBackground(Color.white.opacity(0.3))
                
                Picker("Age", selection: $age) {
                    ForEach(8..<120) { value in
                        Text(String(describing: value))
                            .tag(value)
                    }
                }
                .foregroundStyle(.white)
                .listRowBackground(Color.white.opacity(0.3))
                
                Section("Activities") {
                    ForEach($activities, id: \.self) { activity in
                        HStack {
                            TextField("new activity", text: activity)
                            
                            
                            Spacer()
                            
                            Button {
                                if let index = activities.firstIndex(where: {$0 == activity.wrappedValue}) {
                                    activities.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "minus")
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.3))
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            activities.append("")
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.3))
                }
                .foregroundStyle(.white)
                
                Section("Goals") {
                    ForEach($goals, id: \.self) { goal in
                        HStack {
                            TextField("new goal", text: goal)
                            Spacer()
                            Button {
                                if let index = goals.firstIndex(where: {$0 == goal.wrappedValue }) {
                                    goals.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "minus")
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.3))
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            goals.append("")
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.3))
                }
                .foregroundStyle(.white)
                
                Button("Add Person") {
                    addPerson()
                }
                .foregroundStyle(Color(hex: "F3C677"))
                .listRowBackground(Color.white.opacity(0.3))
            }
            .navigationTitle("New Person")
            .scrollContentBackground(.hidden)
            .background(Color(hex: "972F6E"))
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(Color(hex: "F9564F"))
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return AddPersonView(wizardService: dependencyContainer.wizardService)
}
