//
//  ButtonFactory.swift
//  ProgramaticView
//
//  Created by Admin on 14/01/22.
//

import Foundation
import UIKit

class ButtonFactory: UIButton {
    
    var cTitle: StringConstants?
    
    init(
        title: StringConstants?,
        alignment: NSTextAlignment = .left,
        cNumberOfLines: Int = 1,
        cLineBreakMode: NSLineBreakMode = .byTruncatingTail,
        cAlpha: CGFloat = 1.0,
        cAdjustFontSize: Bool = true,
        cMinimumFontScale: CGFloat = 0.5
    ) {
        self.cTitle = title
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setUp() {
        setTitle(cTitle?.value, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        Style.myApp.apply(to: self)
    }
}
