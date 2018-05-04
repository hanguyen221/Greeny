//
//  Extension+UIView.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/18/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

private var topConstraint: NSLayoutConstraint?
private var leftConstraint: NSLayoutConstraint?
private var bottomConstraint: NSLayoutConstraint?
private var rightConstraint: NSLayoutConstraint?
private var centerXConstraint: NSLayoutConstraint?
private var centerYConstraint: NSLayoutConstraint?
private var widthConstraint: NSLayoutConstraint?
private var heightConstraint: NSLayoutConstraint?

extension UIView {
    
    func anchorWithConstraints(topAnchor: NSLayoutYAxisAnchor? = nil,
                               topConstant: CGFloat = 0,
                               leftAnchor: NSLayoutXAxisAnchor? = nil,
                               leftConstant: CGFloat = 0,
                               bottomAnchor: NSLayoutYAxisAnchor? = nil,
                               bottomConstant: CGFloat = 0,
                               rightAnchor: NSLayoutXAxisAnchor? = nil,
                               rightConstant: CGFloat = 0,
                               centerXAnchor: NSLayoutXAxisAnchor? = nil,
                               centerXConstant: CGFloat = 0,
                               centerYAnchor: NSLayoutYAxisAnchor? = nil,
                               centerYConstant: CGFloat = 0,
                               widthConstant: CGFloat? = nil,
                               heightConstant: CGFloat? = nil) {
        
        var constraints = [NSLayoutConstraint]()
        
        if let topAnchor = topAnchor {
            topConstraint = self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant)
            constraints.append(topConstraint!)
        }
        
        if let leftAnchor = leftAnchor {
            leftConstraint = self.leftAnchor.constraint(equalTo: leftAnchor, constant: leftConstant)
            constraints.append(leftConstraint!)
        }
        
        if let bottomAnchor = bottomAnchor {
            bottomConstraint = self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomConstant)
            constraints.append(bottomConstraint!)
        }
        
        if let rightAnchor = rightAnchor {
            rightConstraint = self.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightConstant)
            constraints.append(rightConstraint!)
        }
        
        if let centerXAnchor = centerXAnchor {
            centerXConstraint = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXConstant)
            constraints.append(centerXConstraint!)
        }
        
        if let centerYAnchor = centerYAnchor {
            centerYConstraint = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYConstant)
            constraints.append(centerYConstraint!)
        }
        
        if let widthConstant = widthConstant {
            widthConstraint = self.widthAnchor.constraint(equalToConstant: widthConstant)
            constraints.append(widthConstraint!)
        }
        
        if let heightConstant = heightConstant {
            heightConstraint = self.heightAnchor.constraint(equalToConstant: heightConstant)
            constraints.append(heightConstraint!)
        }
        
        if constraints.count > 0 {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func getTopConstraint() -> NSLayoutConstraint? {
        return topConstraint
    }
    
    func getLeftConstraint() -> NSLayoutConstraint? {
        return leftConstraint
    }
    
    func getBottomConstraint() -> NSLayoutConstraint? {
        return bottomConstraint
    }
    
    func getRightConstraint() -> NSLayoutConstraint? {
        return rightConstraint
    }
    
    func getCenterXConstraint() -> NSLayoutConstraint? {
        return centerXConstraint
    }
    
    func getCenterYConstraint() -> NSLayoutConstraint? {
        return centerYConstraint
    }
    
    func getWidthConstraint() -> NSLayoutConstraint? {
        return widthConstraint
    }
    
    func getHeightConstraint() -> NSLayoutConstraint? {
        return heightConstraint
    }
    
    func setConstraintsMatchParent(_ view: UIView) {
        anchorWithConstraints(topAnchor: view.topAnchor,
                              leftAnchor: view.leftAnchor,
                              bottomAnchor: view.bottomAnchor,
                              rightAnchor: view.rightAnchor)
    }
    
}
