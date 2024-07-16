//
//  WTTab.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

enum WTTab: String, CaseIterable, Identifiable {
    case devices = "Devices"
    case people = "People"
    case events = "Events"
    case rules = "Rules"
    case environment = "Environment"
    
    // Identifiable
    var id: String {
        self.rawValue
    }
}
