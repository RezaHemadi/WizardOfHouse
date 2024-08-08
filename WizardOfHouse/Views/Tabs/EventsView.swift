//
//  EventsView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EventsView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    let eventsService: EventsService
    
    // MARK: - Helper Methods
    private func fetchEvents() {
        eventsService.fetchNewEvents()
    }
    
    private func callSmartHome() {
        eventsService.callSmartHome()
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            List(wizardService.events) { event in
                VStack(alignment: .leading) {
                    Text(event.description)
                    Text(event.timestamp, style: .date)
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
    let dependencyContainer = DIContainer()
    return EventsView(wizardService: dependencyContainer.wizardService,
                      eventsService: dependencyContainer.eventsService)
}
