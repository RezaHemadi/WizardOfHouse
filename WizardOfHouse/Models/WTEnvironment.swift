//
//  WTEnvironment.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

struct WTEnvironment: Identifiable, Hashable {
    // MARK: Properties
    let id = UUID()
    var description: String
    var area: WTEnvironmentArea
    var people: Set<WTPerson>
}

