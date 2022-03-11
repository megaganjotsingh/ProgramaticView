//
//  ImageViewFactory.swift
//  ProgramaticView
//
//  Created by Admin on 09/03/22.
//

import Foundation
import UIKit

class ImageViewFactory: UIImageView {
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
