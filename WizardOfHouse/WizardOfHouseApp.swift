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
                .onAppear {
                    UITabBar.appearance().backgroundColor = UIColor(red: 179.0/255.0,
                                                                    green: 63.0/255.0,
                                                                    blue: 98.0/255,
                                                                    alpha: 1.0)
                    UITabBar.appearance().unselectedItemTintColor = UIColor.white
                    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.UIColorFromRGB(0xEFD9CE)]
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.UIColorFromRGB(0xEFD9CE)]
                }
        }
    }
}
