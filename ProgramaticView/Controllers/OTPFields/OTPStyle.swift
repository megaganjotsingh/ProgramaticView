//
//  OTPStyle.swift
//  ProgramaticView
//
//  Created by Admin on 24/03/22.
//

import Foundation
import UIKit

struct OTPStyle {
    
    enum Style {
        case square
        case bevel
        
        var cornerRadius: CGFloat {
            switch self {
            case .bevel: return 10
            case .square: return 0
            }
        }
    }
    
    var style: Style = .bevel
    var font = UIFont.systemFont(ofSize: 17)
    var activeBorderColor = UIColor.blue
    var inactiveBorderColor = UIColor.gray
    var activeBackgroundColor = UIColor.blue.withAlphaComponent(0.4)
    var inactiveBackgroundColor = UIColor.clear
    var borderWidth: CGFloat = 2
    var totalFields = 4
    var spacing: CGFloat = 8
}
