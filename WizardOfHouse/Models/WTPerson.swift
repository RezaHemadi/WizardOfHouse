//
//  WTPerson.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

struct WTPerson: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var bio: String
}


extension WTPerson {
    static let SamplePpl: [WTPerson] = [
        WTPerson(name: "Reza Hemadi", bio: "iOS Developer"),
        WTPerson(name: "Amir Asadi", bio: "HCI Reasercher"),
        WTPerson(name: "Mostafa Rezaei", bio: "DevOps"),
        WTPerson(name: "John Appleseed", bio: "Stock Person"),
        WTPerson(name: "Amanda Byness", bio: "Acress"),
        WTPerson(name: "James Cameron", bio: "Director")
    ]
}
