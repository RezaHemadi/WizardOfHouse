//
//  ContentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    let eventsService: EventsService
    @State private var tab: WTTab = .devices
    
    // MARK: - View
    var body: some View {
        TabView(selection: $tab) {
            DevicesView(wizardService: wizardService)
                .tabItem {
                    Label("Devices", systemImage: "thermometer.transmission")
                }
            
            PeopleView(wizardService: wizardService)
                .tabItem {
                    Label("People", systemImage: "person.2")
                }
            
            EventsView(wizardService: wizardService, eventsService: eventsService)
                .tabItem {
                    Label("Events", systemImage: "list.bullet.rectangle.portrait")
                }
            
            RulesView(wizardService: wizardService)
                .tabItem {
                    Label("Rules", systemImage: "list.bullet.rectangle")
                }
            
            EnvironmentsView(wizardService: wizardService)
                .tabItem {
                    Label("Environment", systemImage: "building.2")
                }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return ContentView(wizardService: dependencyContainer.wizardService,
                       eventsService: dependencyContainer.eventsService)
}
