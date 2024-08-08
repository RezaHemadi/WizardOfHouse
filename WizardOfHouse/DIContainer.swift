//
//  DIContainer.swift
//  WizardOfHouse
//
//  Created by Reza on 7/28/24.
//

import Foundation
import SwiftUI

class DIContainer {
    // MARK: - Properties
    let wizardService: WizardService
    let gptClient: GPTClient
    let eventsService: EventsService
    
    // MARK: - Initialization
    init() {
        wizardService = WizardService()
        gptClient = GPTClient()
        eventsService = EventsService(gptClient: gptClient, wizardService: wizardService)
    }
}
