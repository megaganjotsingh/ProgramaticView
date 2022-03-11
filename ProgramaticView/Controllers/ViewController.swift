//
//  ViewController.swift
//  ProgramaticView
//
//  Created by Admin on 14/01/22.
//

import UIKit

class ViewController: BaseVC {
    
    lazy var titleLabel = LabelFactory(textStyle: .heading, text: .newToThisApp, alignment: .center)

    lazy var descLabel = LabelFactory(textStyle: .subHeading,  text: .newToThisApp, alignment: .center)
    
    lazy var textfield = UITextField()
    
    lazy var rememberLabel = LabelFactory(textStyle: .body, text: .newToThisApp)
    lazy var switchh = UISwitch()
    
    lazy var submitButton = ButtonFactory(title: .submit)
    
    lazy var newToLabel = LabelFactory(textStyle: .subtitle, text: .newToThisApp, alignment: .center)
    
    lazy var signUpButton = ButtonFactory(title: .signUp)
    
    lazy var stack = UIStackView()
    
    lazy var tfStack = UIStackView()
    
    lazy var signUpStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        setUpViews()
        addViews()
        
        setUpConstraints()
        setUpTextfield()
        setUpSubmitButton()
        setUpSignUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden = true
    }
    
}

private extension ViewController {
    
    func addViews() {
        view.addSubview(stack)
        textfield.placeholder = "Phone Number"
    }
    
    func setUpViews() {
        stack = [
            titleLabel,
            UIView.spacer(height: 30),
            descLabel
        ].asStackView(axis: .vertical, spacing: 8)
        
    }
    
    func setUpConstraints() {
        stack
            .alignEdgesWithSuperview([.left, .right, .safeAreaTop], constants: [20, 20, 30])
    }
    
    func setUpTextfield() {
        tfStack = [
            textfield,
            [
                rememberLabel,
                switchh
            ].asStackView(spacing: 8)
        ].asStackView(axis: .vertical, spacing: 20, alignment: .center)
        
        view.addSubview(tfStack)
        textfield
            .height(constant: 50)
        tfStack
            .toBottomOf(stack, constant: 80)
            .alignEdgesWithSuperview([.right, .left], constant: 20)
    }
    
    func setUpSubmitButton() {
        view.addSubview(submitButton)
            
        submitButton
            .toBottomOf(tfStack, constant: 80)
            .alignEdgesWithSuperview([.right, .left], constant: 20)
            .height(constant: 50)
            .circled()
    }
    
    func setUpSignUpButton() {
        signUpStack = [
            newToLabel,
            signUpButton
        ].asStackView(axis: .vertical, spacing: 4)
        
        view.addSubview(signUpStack)
            
        signUpButton
            .height(constant: 55)
            .circled()
        
        signUpStack
            .toBottomOf(submitButton, constant: 30)
            .alignEdgesWithSuperview([.right, .left], constant: 20)
        
        signUpButton.addTarget(self, action: #selector(onClickSignUpButton(_:)), for: .touchUpInside)
    }
    
    @objc
    func onClickSignUpButton(_ sender: UIButton) {
        print("Sign up taped")
    }
    
}
