//
//  UIColor+Hex.swift
//  WizardOfHouse
//
//  Created by Reza on 10/10/24.
//

import Foundation
import UIKit

extension UIColor {
    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(
            red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0),
            green: CGFloat((Float((rgbValue & 0x00ff00) >> 8)) / 255.0),
            blue: CGFloat((Float((rgbValue & 0x0000ff) >> 0)) / 255.0),
            alpha: 1.0)
    }
}
