//
//  WTRule.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

struct WTRule: Identifiable {
    var id = UUID()
    var description: String
}

extension WTRule {
    static let SampleRules: [WTRule] = [
        WTRule(description: "Turn off lights when leaving the house.")
    ]
}
