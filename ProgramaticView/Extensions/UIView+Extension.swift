//
//  UIView+Extension.swift
//  ProgramaticView
//
//  Created by Admin on 14/01/22.
//

import Foundation
import UIKit

extension UIView {

    static func spacer(height: CGFloat = 1, backgroundColor: UIColor = .clear) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height),
        ])
        return view
    }

    static func spacerWidth(_ width: CGFloat = 1, backgroundColor: UIColor = .clear, alpha: CGFloat = 1, flexible: Bool = false) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        view.alpha = alpha

        if flexible {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: width),
            ])
        } else {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: width),
            ])
        }

        return view
    }

    func firstSubview<T>(ofType type: T.Type) -> T? {
        if let viewFound = subviews.first(where: { $0 is T }) {
            return viewFound as? T
        }
        for each in subviews {
            if let viewFound = each.firstSubview(ofType: T.self) {
                return viewFound
            }
        }
        return nil
    }
        
    func nearestAncestor<T>(ofType type: T.Type) -> T? {
        if let me = self as? T { return me }
        return superview?.nearestAncestor(ofType: type)
    }
    
}
