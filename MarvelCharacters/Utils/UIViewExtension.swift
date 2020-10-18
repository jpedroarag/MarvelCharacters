//
//  UIViewExtension.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 17/10/20.
//

import UIKit

extension UIView {
    
    func round(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
}

extension UIView {
    
    @discardableResult
    func enableAutolayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func left(in view: UIView, offset: CGFloat = 0) -> Self {
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    func right(in view: UIView, offset: CGFloat = 0) -> Self {
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    func top(in view: UIView, offset: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    func bottom(in view: UIView, offset: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    func filled(in view: UIView, paddings: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: view.topAnchor, constant: paddings).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: paddings).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: paddings).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: paddings).isActive = true
        return self
    }

    @discardableResult
    func centerX(in view: UIView) -> Self {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return self
    }

    @discardableResult
    func centerY(in view: UIView) -> Self {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    func width(_ anchor: NSLayoutDimension , multiplier: CGFloat = 1) -> Self {
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    func height(_ anchor: NSLayoutDimension , multiplier: CGFloat = 1) -> Self {
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    func width(_ value: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }

    @discardableResult
    func height(_ value: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    
}
