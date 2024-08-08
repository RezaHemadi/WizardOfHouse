//
//  AppState.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation
import SwiftUI

class WizardService: ObservableObject {
    @Published var devices: [WTDevice] = []
    @Published var people: [WTPerson] = []
    @Published var environments: [WTEnvironment] = []
    @Published var rules: [WTRule] = []
    @Published var events: [WTEvent] = []
    @Published var address: String = ""
    
    init(devices: [WTDevice], people: [WTPerson], environments: [WTEnvironment], rules: [WTRule], events: [WTEvent], address: String) {
        self.devices = devices
        self.people = people
        self.environments = environments
        self.rules = rules
        self.events = events
        self.address = address
    }
    
    init() {}
}

extension WizardService {
    static let Sample: WizardService = WizardService(devices: WTDevice.SampleDevices,
                                                     people: WTPerson.SamplePpl,
                                                     environments: [],
                                                     rules: WTRule.SampleRules,
                                                     events: WTEvent.SampleEvents,
                                                     address: "Apple Park, Cupertino, California, USA")
}
