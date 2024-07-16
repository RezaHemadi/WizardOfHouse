//
//  AppState.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation
import SwiftUI

@Observable class AppState {
    var devices: [WTDevice] = []
    var people: [WTPerson] = []
    var environments: [WTEnvironment] = []
    var rules: [WTRule] = []
    var events: [WTEvent] = []
    
    init(devices: [WTDevice], people: [WTPerson], environments: [WTEnvironment], rules: [WTRule], events: [WTEvent]) {
        self.devices = devices
        self.people = people
        self.environments = environments
        self.rules = rules
        self.events = events
    }
    
    init() {}
}

struct AppStateEnvironmentKey: EnvironmentKey {
    static var defaultValue: AppState = .Sample
}

extension EnvironmentValues {
    var appState: AppState {
        get { self[AppStateEnvironmentKey.self] }
        set { self[AppStateEnvironmentKey.self] = newValue }
    }
}

extension AppState {
    static let Sample: AppState = AppState(devices: WTDevice.SampleDevices,
                                           people: WTPerson.SamplePpl,
                                           environments: [],
                                           rules: WTRule.SampleRules,
                                           events: WTEvent.SampleEvents)
}
