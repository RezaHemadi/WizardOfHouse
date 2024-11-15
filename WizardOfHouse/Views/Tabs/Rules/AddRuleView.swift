//
//  AddRuleView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct AddRuleView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @StateObject var wizardService: WizardService
    @State private var ruleDescription: String = ""
    @FocusState private var descriptionFocused: Bool
    
    // MARK: - Helper Methods
    private func addRule() {
        let rule = WTRule(description: ruleDescription)
        wizardService.rules.append(rule)
        ruleDescription = ""
        dismiss()
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                TextField("Description", text: $ruleDescription)
                    .focused($descriptionFocused)
                    .foregroundStyle(.white)
                    .listRowBackground(Color.white.opacity(0.3))
                    .onAppear {
                        descriptionFocused = true
                    }
                
                Button("Add Rule") {
                    addRule()
                }
                .foregroundStyle(Color(hex: "F3C677"))
                .listRowBackground(Color.white.opacity(0.3))
            }
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(Color(hex: "F9564F"))
            }
            .navigationTitle("Add New Rule")
            .scrollContentBackground(.hidden)
            .background(Color(hex: "972F6E"))
        }
    }
}

#Preview {
    AddRuleView(wizardService: .Sample)
}
