//
//  AppStyle.swift
//  ProgramaticView
//
//  Created by Admin on 20/01/22.
//

import Foundation
import UIKit

class Style {
    
    enum TextStyle {
        case navigationBar
        case title
        case subtitle
        case heading
        case subHeading
        case body
        case filledButton
        case buttonWithBorder
    }

    struct TextAttributes {
        let font: UIFont
        let color: UIColor
        let backgroundColor: UIColor?

        init(font: UIFont, color: UIColor, backgroundColor: UIColor? = nil) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }

    // MARK: - General Properties
    let backgroundColor: UIColor
    let preferredStatusBarStyle: UIStatusBarStyle

    let attributesForStyle: (_ style: TextStyle) -> TextAttributes

    init(backgroundColor: UIColor,
         preferredStatusBarStyle: UIStatusBarStyle = .default,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes)
    {
        self.backgroundColor = backgroundColor
        self.preferredStatusBarStyle = preferredStatusBarStyle
        self.attributesForStyle = attributesForStyle
    }

    // MARK: - Convenience Getters
    func font(for style: TextStyle) -> UIFont {
        return attributesForStyle(style).font
    }

    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }

    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
}

extension Style {
    
    static var myApp: Style {
        return Style(
            backgroundColor: .black,
            preferredStatusBarStyle: .lightContent,
            attributesForStyle: { $0.myAppAttributes }
        )
    }
    
    func apply(textStyle: TextStyle, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
    }

    func apply(textStyle: TextStyle = .filledButton, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        button.setTitleColor(attributes.color, for: .normal)
        button.titleLabel?.font = attributes.font
        button.backgroundColor = attributes.backgroundColor
    }

    func apply(textStyle: TextStyle = .navigationBar, to navigationBar: UINavigationBar) {
        let attributes = attributesForStyle(textStyle)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: attributes.font,
            NSAttributedString.Key.foregroundColor: attributes.color
        ]

        if let color = attributes.backgroundColor {
            navigationBar.barTintColor = color
        }

        navigationBar.tintColor = attributes.color
        navigationBar.barStyle = preferredStatusBarStyle == .default ? .default : .black
    }
    
}

private extension Style.TextStyle {
    
    var myAppAttributes: Style.TextAttributes {
        switch self {
        case .navigationBar:
            return Style.TextAttributes(font: .myAppTitle, color: .myAppGreen, backgroundColor: .clear)
        case .title:
            return Style.TextAttributes(font: .myAppTitle, color: .myAppGreen, backgroundColor: .clear)
        case .subtitle:
            return Style.TextAttributes(font: .myAppSubtitle, color: .myAppBlue, backgroundColor: .clear)
        case .heading:
            return Style.TextAttributes(font: .myAppHeading, color: .black, backgroundColor: .clear)
        case .subHeading:
            return Style.TextAttributes(font: .myAppSubHeading, color: .black, backgroundColor: .clear)
        case .body:
            return Style.TextAttributes(font: .myAppBody, color: .black, backgroundColor: .clear)
        case .filledButton:
            return Style.TextAttributes(font: .myAppSubtitle, color: .white, backgroundColor: .myAppRed)
        case .buttonWithBorder:
            return Style.TextAttributes(font: .myAppSubtitle, color: .myAppRed)
        }
    }
    
}

extension UIColor {
    
    static var myAppRed: UIColor {
        return UIColor(red: 1, green: 0.1, blue: 0.1, alpha: 1)
    }
    static var myAppGreen: UIColor {
        return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    static var myAppBlue: UIColor {
        return UIColor(red: 0, green: 0.2, blue: 0.9, alpha: 1)
    }
    
    static var myAppBackground: UIColor {
        return UIColor(red: 211, green: 211, blue: 211, alpha: 1)
    }
    
}

extension UIFont {
    
    static var myAppTitle: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    static var myAppSubtitle: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    static var myAppHeading: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    static var myAppSubHeading: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static var myAppBody: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
}
