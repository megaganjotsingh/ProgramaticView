//
//  OTPFieldsView.swift
//  ProgramaticView
//
//  Created by Admin on 24/03/22.
//

import Foundation
import UIKit

protocol OTPFieldsViewDelegate {
    func hasEnteredAllOTP(_ hasEntered: Bool)
    func enteredOTP(_ otp: String)
}

class OTPFieldsView: UIView {
    
    var delegate: OTPFieldsViewDelegate?
    var textfields: [OTPTextfield] = []
    var style: OTPStyle
    
    var selectedTextfield: OTPTextfield?
    
    init(frame: CGRect, style: OTPStyle) {
        self.style = style
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        self.style = OTPStyle()
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        for i in 0...style.totalFields-1 {
            let textfield = OTPTextfield(style: style)
            textfield.tag = i
            textfield.isUserInteractionEnabled = false
            textfield.delegate = self
            textfields.append(textfield)
        }
        setupTextfields()
    }
    
    func setupTextfields() {
        let stackView = (textfields as [UIView]).asStackView(axis: .horizontal, distribution: .fillEqually, spacing: style.spacing)
        addSubview(stackView)
        stackView.alignAllEdgesWithSuperview()
        textfields[0].isUserInteractionEnabled = true
        textfields[0].becomeFirstResponder()
    }
    
    func moveToNextTextfield(with tag: Int) {
        textfields[tag-1].resignFirstResponder()
        if tag < style.totalFields {
            textfields[tag-1].isUserInteractionEnabled = false
        }
        if tag < style.totalFields {
            textfields[tag].isUserInteractionEnabled = true
            textfields[tag].becomeFirstResponder()
        }
    }
        
    func moveToPreviousTextfield(with tag: Int) {
        textfields[tag+1].resignFirstResponder()
        textfields[tag+1].isUserInteractionEnabled = false
        if tag > 0 {
            textfields[tag].isUserInteractionEnabled = true
            textfields[tag].becomeFirstResponder()
        } else if tag < 1 {
            textfields[0].isUserInteractionEnabled = true
            textfields[0].becomeFirstResponder()
        }
    }
}

extension OTPFieldsView: UITextFieldDelegate {
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tag = textField.tag
        if string == "" {
            // delete happens
            textField.text = ""
            if tag >= 1 {
                moveToPreviousTextfield(with: tag-1)
            }
            return false
        } else if !string.isEmpty , let _ = textField.text {
            // move forward
            textField.text = string
            moveToNextTextfield(with: tag+1)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextfield = textfields[textField.tag]
        selectedTextfield?.setBorderColor(for: .selected)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedTextfield?.setBorderColor(for: .unselected)
        let otp = getEnteredOTP()
        delegate?.enteredOTP(otp)
        let hasEnteredAllOTP = otp.count == style.totalFields
        delegate?.hasEnteredAllOTP(hasEnteredAllOTP)
    }
    
    private func getEnteredOTP() -> String {
        let otp = textfields.map { $0.text ?? "" }.joined()
        return otp
    }
    
}
