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
                        .foregroundStyle(Color(hex: "0C0A3E"))
                    
                    Text(event.timestamp, style: .date)
                        .foregroundStyle(Color(hex: "0C0A3E"))
                }
            }
            .navigationTitle("Events")
            .scrollContentBackground(.hidden)
            .background(Color(hex: "892774"))
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Fetch Events") {
                        fetchEvents()
                    }
                    .foregroundStyle(Color(hex: "F3C677"))
                    
                    Button("Call Smart Home") {
                        callSmartHome()
                    }
                    .foregroundStyle(Color(hex: "F3C677"))
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
