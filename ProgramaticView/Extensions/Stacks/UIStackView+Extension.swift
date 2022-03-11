//
//  UIStackView+Extension.swift
//  ProgramaticView
//
//  Created by Admin on 14/01/22.
//

import Foundation
import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ views: [UIView]) {
        for each in views {
            addArrangedSubview(each)
        }
    }

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }

}

extension Array where Iterator.Element == UIView {
    
    public func asStackView(axis: NSLayoutConstraint.Axis = .horizontal, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0, contentHuggingPriority: UILayoutPriority? = nil, perpendicularContentHuggingPriority: UILayoutPriority? = nil, alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: self)
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if let contentHuggingPriority = contentHuggingPriority {
            switch axis {
            case .horizontal:
                stackView.setContentHuggingPriority(contentHuggingPriority, for: .horizontal)
            case .vertical:
                stackView.setContentHuggingPriority(contentHuggingPriority, for: .vertical)
            default:
                break
            }
        }
        if let perpendicularContentHuggingPriority = perpendicularContentHuggingPriority {
            switch axis {
            case .horizontal:
                stackView.setContentHuggingPriority(perpendicularContentHuggingPriority, for: .vertical)
            case .vertical:
                stackView.setContentHuggingPriority(perpendicularContentHuggingPriority, for: .horizontal)
            default:
                break
            }
        }
        return stackView
    }
    
}

