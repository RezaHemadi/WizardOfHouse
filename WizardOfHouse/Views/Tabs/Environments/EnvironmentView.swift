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
    @StateObject var wizardService: WizardService
    @Binding var environment: WTEnvironment
    @State private var description: String
    @State private var area: WTEnvironmentArea
    @State private var selectedPpl: Set<WTPerson>
    @Binding var path: NavigationPath
    
    // MARK: - Initialization
    init(wizardService: WizardService, environment: Binding<WTEnvironment>, path: Binding<NavigationPath>) {
        self._wizardService = .init(wrappedValue: wizardService)
        self._environment = environment
        self.description = environment.wrappedValue.description
        self.area = environment.wrappedValue.area
        self.selectedPpl = environment.wrappedValue.people
        self._path = path
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
                .foregroundStyle(.white)
                .listRowBackground(Color.white.opacity(0.3))
            
            Picker("Area", selection: $area) {
                ForEach(WTEnvironmentArea.allCases) { enArea in
                    Text(enArea.rawValue.capitalized)
                        .foregroundStyle(Color(hex: "0C0A3E"))
                        .tag(enArea)
                }
            }
            .foregroundStyle(.white)
            .listRowBackground(Color.white.opacity(0.3))
            
            Section("Assigned People") {
                ForEach(wizardService.people) { person in
                    PersonSelectionRow(person: person, selected: selectedPpl.contains(person))
                        .listRowBackground(Color.white.opacity(0.3))
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
            .foregroundStyle(Color.white)
        }
        .scrollContentBackground(.hidden)
        .background(Color(hex: "892774"))
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    save()
                }
                .foregroundStyle(Color(hex: "F3C677"))
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(hex: "F9564F"))
                }
            }
        }
    }
}

#Preview {
    EnvironmentView(wizardService: .Sample,
                    environment: .constant(WTEnvironment(description: "description goes here", area: .medium, people: [])), path: .constant(NavigationPath()))
}
