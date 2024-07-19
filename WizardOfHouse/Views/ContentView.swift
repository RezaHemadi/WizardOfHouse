//
//  ContentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.appState) var appState
    @State private var tab: WTTab = .devices
    
    // MARK: - View
    var body: some View {
        TabView(selection: $tab) {
            DevicesView()
                .tabItem {
                    Label("Devices", systemImage: "thermometer.transmission")
                }
            
            PeopleView()
                .tabItem {
                    Label("People", systemImage: "person.2")
                }
            
            EventsView()
                .tabItem {
                    Label("Events", systemImage: "list.bullet.rectangle.portrait")
                }
            
            RulesView()
                .tabItem {
                    Label("Rules", systemImage: "list.bullet.rectangle")
                }
            
            EnvironmentsView(appState: appState)
                .tabItem {
                    Label("Environment", systemImage: "building.2")
                }
        }
    }
}

#Preview {
    ContentView()
}
