//
//  WizardOfHouseApp.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

@main
struct WizardOfHouseApp: App {
    // MARK: - Properties
    let dependencyContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView(wizardService: dependencyContainer.wizardService,
                        eventsService: dependencyContainer.eventsService)
        }
    }
}
