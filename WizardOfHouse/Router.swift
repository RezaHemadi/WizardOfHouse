//
//  Router.swift
//  WizardOfHouse
//
//  Created by Reza on 7/16/24.
//

import Foundation
import SwiftUI

@Observable class Router {
    var tab: WTTab = .devices
    var path = NavigationPath()
}

struct RouterEnvironmentKey: EnvironmentKey {
    static var defaultValue = Router()
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterEnvironmentKey.self] }
        set { self[RouterEnvironmentKey.self] = newValue }
    }
}
