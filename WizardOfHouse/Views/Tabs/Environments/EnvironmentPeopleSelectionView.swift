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
    @Binding var path: NavigationPath
    
    // MARK: - Methods
    private func create() {
        let newEnvironment = WTEnvironment(description: environment.description,
                                           area: environment.area,
                                           people: selectedPpl)
        wizardService.environments.append(newEnvironment)
        onCompletion?()
    }
    
    // MARK: - Initialization
    init(wizardService: WizardService, environment: WTEnvironment, path: Binding<NavigationPath>, onCompletion: DismissAction?) {
        self.onCompletion = onCompletion
        self._wizardService = .init(wrappedValue: wizardService)
        self._environment = .init(initialValue: environment)
        self._selectedPpl = .init(initialValue: Set<WTPerson>())
        self._path = path
    }
    
    // MARK: - View
    var body: some View {
        List(wizardService.people) { person in
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Create") {
                    create()
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
        .navigationTitle("Add People")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .scrollContentBackground(.hidden)
        .background(Color(hex: "972F6E"))
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return NavigationStack {
        EnvironmentPeopleSelectionView(wizardService: dependencyContainer.wizardService,
                                       environment: WTEnvironment(description: "description goes here", area: .medium, people: []),
                                       path: .constant(NavigationPath()),
                                       onCompletion: nil)
    }
}
