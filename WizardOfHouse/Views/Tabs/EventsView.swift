//
//  EventsView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EventsView: View {
    // MARK: - Properties
    @Environment(\.appState) var appState
    
    // MARK: - Helper Methods
    private func fetchEvents() {
        fatalError("To be implemented")
    }
    
    private func callSmartHome() {
        fatalError("To be implemented")
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List(appState.events) { event in
                VStack(alignment: .leading) {
                    Text(event.description)
                    Text(event.timestampe, style: .date)
                }
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Fetch Events") {
                        fetchEvents()
                    }
                    Button("Call Smart Home") {
                        callSmartHome()
                    }
                }
            }
        }
    }
}

#Preview {
    EventsView()
}
