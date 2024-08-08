//
//  RulesView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct RulesView: View {
    // MARK: Properties
    @StateObject var wizardService: WizardService
    @State private var showAddRule: Bool = false
    
    // MARK: - Helper Methods
    private func deleteRule(_ indexSet: IndexSet) {
        wizardService.rules.remove(atOffsets: indexSet)
    }
    
    // MARK: View
    var body: some View {
        NavigationStack {
            List {
                ForEach(wizardService.rules) { rule in
                    Text(rule.description)
                }
                .onDelete(perform: deleteRule)
            }
            .navigationTitle("Rules")
            .toolbar {
                Button {
                    showAddRule.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddRule) {
                AddRuleView(wizardService: wizardService)
            }
        }
    }
}

#Preview {
    RulesView(wizardService: .Sample)
}
