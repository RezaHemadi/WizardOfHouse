//
//  EnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

struct EnvironmentView: View {
    // MARK: - Properties
    let environment: WTEnvironment
    
    // MARK: - View
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    EnvironmentView(environment: WTEnvironment(description: "description goes here", area: .medium, people: []))
}
