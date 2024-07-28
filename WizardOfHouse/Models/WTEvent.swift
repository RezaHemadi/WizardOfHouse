//
//  WTEvent.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

struct WTEvent: Identifiable {
    var id = UUID()
    var description: String
    var timestamp: Date
}

extension WTEvent {
    static let SampleEvents: [WTEvent] = [
        WTEvent(description: "Party", timestamp: Date.now)
    ]
}
