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
    var occupation: String?
    var age: Int?
    var activities: [String]
    var goals: [String]
}


extension WTPerson {
    static let SamplePpl: [WTPerson] = [
        WTPerson(name: "Reza Hemadi", bio: "iOS Developer", occupation: "Developer", age: 33, activities: ["gaming", "movies", "music", "jogging"], goals: []),
        WTPerson(name: "Amir Asadi", bio: "HCI Reasercher", occupation: "Developer", age: 33, activities: ["gaming", "movies", "music", "running"], goals: []),
        WTPerson(name: "Mostafa Rezaei", bio: "DevOps", occupation: "server admin", age: 33, activities: ["gaming", "cooking"], goals: []),
        WTPerson(name: "John Appleseed", bio: "Stock Person", occupation: "", age: 23, activities: [], goals: []),
        WTPerson(name: "Amanda Byness", bio: "Acress", occupation: "actress", age: 30, activities: [], goals: []),
        WTPerson(name: "James Cameron", bio: "Director", occupation: "director", age: 56, activities: [], goals: ["make Titanic II"])
    ]
}
