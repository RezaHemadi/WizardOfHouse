//
//  WTDeviceType.swift
//  WizardOfHouse
//
//  Created by Reza on 7/5/24.
//

import Foundation

enum WTDeviceType: Hashable {
    case sensor(value: String)
    case onOff(isOn: Bool)
}
