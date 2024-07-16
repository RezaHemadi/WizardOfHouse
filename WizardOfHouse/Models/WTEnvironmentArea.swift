//
//  WTEnvironmentArea.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

enum WTEnvironmentArea: String, CaseIterable, Identifiable {
    case small
    case medium
    case large
    
    var id: String {
        self.rawValue
    }
}
