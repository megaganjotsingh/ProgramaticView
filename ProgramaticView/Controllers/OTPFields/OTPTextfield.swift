//
//  OTPTextfield.swift
//  ProgramaticView
//
//  Created by Admin on 24/03/22.
//

import Foundation
import UIKit

class OTPTextfield: UITextField {
    
//    lazy var textfield: UITextField = {
//        let tf = UITextField()
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
    
    enum Selection {
        case selected
        case unselected
        
        var borderColor: CGColor {
            switch self {
            case .selected:
                return OTPStyle().activeBorderColor.cgColor
            case .unselected:
                return OTPStyle().inactiveBorderColor.cgColor
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .selected:
                return OTPStyle().activeBackgroundColor
            case .unselected:
                return OTPStyle().inactiveBackgroundColor
            }
        }
    }
    
    var style: OTPStyle
//    var selection: Selection
    
    init(style: OTPStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        keyboardType = .asciiCapableNumberPad
        backgroundColor = .systemPink
        makeBorder()
        
//        addSubview(textfield)
//        textfield.alignEdgesWithSuperview([.left, .right, .top, .bottom], constants: [12, 12, 0, 0])
    }
    
    func makeBorder() {
        borderStyle = .none
        layer.cornerRadius = style.style.cornerRadius
        layer.borderWidth = style.borderWidth
        setBorderColor(for: .unselected)
    }
    
    func setBorderColor(for selection: Selection) {
        layer.borderColor = selection.borderColor
        backgroundColor = selection.backgroundColor
    }
    
}
