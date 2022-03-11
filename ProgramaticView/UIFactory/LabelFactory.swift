//
//  LabelFactory.swift
//  ProgramaticView
//
//  Created by Admin on 14/01/22.
//

import Foundation
import UIKit

class LabelFactory: UILabel {
    
    var alignment: NSTextAlignment
    var textStyle: Style.TextStyle
    
    var cText: StringConstants?
    var cNumberOfLines: Int
    var cLineBreakMode: NSLineBreakMode
    var cAlpha: CGFloat
    var cAdjustFontSize: Bool
    var cMinimumFontScale: CGFloat
    
    init(
        textStyle: Style.TextStyle,
        text: StringConstants? = nil,
        alignment: NSTextAlignment = .left,
        cNumberOfLines: Int = 1,
        cLineBreakMode: NSLineBreakMode = .byTruncatingTail,
        cAlpha: CGFloat = 1.0,
        cAdjustFontSize: Bool = true,
        cMinimumFontScale:CGFloat = 0.5
    ) {
        self.textStyle = textStyle
        self.cText = text
        self.alignment = alignment
        self.cNumberOfLines = cNumberOfLines
        self.cLineBreakMode = cLineBreakMode
        self.cAlpha = cAlpha
        self.cAdjustFontSize = cAdjustFontSize
        self.cMinimumFontScale = cMinimumFontScale
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setUp() {
        text = cText?.value
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = false
        Style.myApp.apply(textStyle: textStyle, to: self)
    }
    
}
