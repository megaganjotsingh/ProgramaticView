//
//  StringConstants.swift
//  ProgramaticView
//
//  Created by Admin on 20/01/22.
//

import Foundation


enum StringConstants: String {
    case submit
    case signUp
    case newToThisApp
    case cancel
    case ok
    case appName
    
    var value: String {
        rawValue.localized
    }
}
