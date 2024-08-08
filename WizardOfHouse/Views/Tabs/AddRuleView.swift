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
                TextField("Rule Description", text: $ruleDescription)
                
                Button("Add Rule") {
                    addRule()
                }
            }
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
            .navigationTitle("Add New Rule")
        }
    }
}

#Preview {
    AddRuleView(wizardService: .Sample)
}
