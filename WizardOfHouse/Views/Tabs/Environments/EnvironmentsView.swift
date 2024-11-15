//
//  EnvironmentView.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import SwiftUI

enum EnvironmentsPath: Hashable, Equatable {
    case root
    case environment(Binding<WTEnvironment>)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .root:
            hasher.combine("root")
        case .environment(let binding):
            hasher.combine(binding.wrappedValue)
        }
    }
    
    static func ==(lhs: EnvironmentsPath, rhs: EnvironmentsPath) -> Bool {
        switch lhs {
        case .root:
            switch rhs {
            case .root:
                return true
            case .environment:
                return false
            }
        case .environment(let lhsBinding):
            switch rhs {
            case .root:
                return false
            case .environment(let rhsBinding):
                return lhsBinding.wrappedValue == rhsBinding.wrappedValue
            }
        }
    }
}

struct EnvironmentsView: View {
    // MARK: - Properties
    @StateObject var wizardService: WizardService
    @State private var showAddEnvironment: Bool = false
    @State private var path = NavigationPath()
    
    // MARK: - View
    var body: some View {
        NavigationStack(path: $path) {
            List($wizardService.environments, id: \.self) { $environment in
                NavigationLink(value: EnvironmentsPath.environment($environment)) {
                    Text($environment.wrappedValue.description)
                        .foregroundStyle(Color(hex: "0C0A3E"))
                }
            }
            .navigationTitle("Environments")
            .scrollContentBackground(.hidden)
            .background(Color(hex: "892774"))
            .toolbar {
                Button {
                    showAddEnvironment = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color(hex: "F3C677"))
                }
            }
            .sheet(isPresented: $showAddEnvironment) {
                AddNewEnvironmentView(wizardService: wizardService)
            }
            .navigationDestination(for: EnvironmentsPath.self) { environmentsPath in
                switch environmentsPath {
                case .root:
                    EnvironmentsView(wizardService: wizardService)
                case .environment(let environment):
                    EnvironmentView(wizardService: wizardService, environment: environment, path: $path)
                }
            }
        }
    }
}

#Preview {
    let dependencyContainer = DIContainer()
    return EnvironmentsView(wizardService: dependencyContainer.wizardService)
}
