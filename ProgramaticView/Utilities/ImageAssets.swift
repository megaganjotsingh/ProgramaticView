//
//  ImageAssets.swift
//  ProgramaticView
//
//  Created by Admin on 20/01/22.
//

import Foundation
import UIKit


enum ImageAssets: String {
    case backIcon
    
    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
