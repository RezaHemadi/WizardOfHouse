//
//  AppState.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var devices: [WTDevice] = []
    @Published var people: [WTPerson] = []
    @Published var environments: [WTEnvironment] = []
    @Published var rules: [WTRule] = []
    @Published var events: [WTEvent] = []
    
    init(devices: [WTDevice], people: [WTPerson], environments: [WTEnvironment], rules: [WTRule], events: [WTEvent]) {
        self.devices = devices
        self.people = people
        self.environments = environments
        self.rules = rules
        self.events = events
    }
    
    init() {}
}

extension AppState {
    static let Sample: AppState = AppState(devices: WTDevice.SampleDevices,
                                           people: WTPerson.SamplePpl,
                                           environments: [],
                                           rules: WTRule.SampleRules,
                                           events: WTEvent.SampleEvents)
}

struct AppStateEnvironmentKey: EnvironmentKey {
    static var defaultValue: AppState = AppState.Sample
}

extension EnvironmentValues {
    var appState: AppState {
        get { self[AppStateEnvironmentKey.self] }
        set { self[AppStateEnvironmentKey.self] = newValue }
    }
}
