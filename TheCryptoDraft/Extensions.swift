//
//  Extensions.swift
//  TheCryptoDraft
//
//  Created by admin on 2/9/18.
//  Copyright © 2018 esohjay. All rights reserved.
//

import UIKit

extension UINavigationController {
    class func setupNavigationControllerWith(title: String, navigationController: UINavigationController?) {
        if let navigationController = navigationController {
            navigationController.navigationBar.barTintColor = COLORS.TCDBlue
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.tintColor = .white
            let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]//[NSAttributedStringKey.foregroundColor:UIColor.red]
            navigationController.navigationBar.titleTextAttributes = textAttributes
            navigationController.navigationBar.topItem?.title = title
        }
    }
}

extension UIView {
    static func addConstraintsWithVisualFormat(vfl: String, views: UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary["v\(index)"] = view
        }
        NSLayoutConstraint.constraints(withVisualFormat: vfl, metrics: nil, views: viewsDictionary)
    }
    func constrainFullyToSuperView() {
        if let superExists = superview {
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: superExists.topAnchor).isActive = true
            rightAnchor.constraint(equalTo: superExists.rightAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superExists.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: superExists.leftAnchor).isActive = true
        }
    }
    
    @discardableResult
    func constrainTopTo(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = topAnchor.constraint(equalTo: anchor, constant: constant)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainRightTo(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = rightAnchor.constraint(equalTo: anchor, constant: constant)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainBottomTo(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainLeftTo(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = leftAnchor.constraint(equalTo: anchor, constant: constant)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainWidthTo(dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = widthAnchor.constraint(equalTo: dimension, multiplier: multiplier)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainHeightTo(dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = heightAnchor.constraint(equalTo: dimension , multiplier: multiplier)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainCenterXTo(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        anchor.isActive = true
        return anchor
    }
    @discardableResult
    func constrainCenterYTo(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        anchor.isActive = true
        return anchor
    }
}
