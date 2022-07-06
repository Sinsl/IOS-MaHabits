//
//  ExtensionAppColor.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import Foundation
import UIKit

public enum NameColor {
    case grey, purple, blue, green, fiolet, orange, tapBarGrey, navBarGrey
}

public func AppColor(color: NameColor) -> UIColor {
    switch color {
    case .grey:
        return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    case .purple:
        return UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
    case .blue:
        return UIColor(red: 41/255, green: 109/255, blue: 255/255, alpha: 1)
    case .green:
        return UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1)
    case .fiolet:
        return UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1)
    case .orange:
        return UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
    case .tapBarGrey:
        return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    case .navBarGrey:
        return UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
//    default:
//        return .systemGray2
    }
   
    
}
