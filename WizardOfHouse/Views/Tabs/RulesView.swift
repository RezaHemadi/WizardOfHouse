//
//  RulesView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct RulesView: View {
    // MARK: Properties
    @Environment(\.appState) var appState
    @State private var showAddRule: Bool = false
    
    // MARK: - Helper Methods
    private func deleteRule(_ indexSet: IndexSet) {
        appState.rules.remove(atOffsets: indexSet)
    }
    
    // MARK: View
    var body: some View {
        NavigationStack {
            List {
                ForEach(appState.rules) { rule in
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
                AddRuleView()
            }
        }
    }
}

#Preview {
    RulesView()
}
