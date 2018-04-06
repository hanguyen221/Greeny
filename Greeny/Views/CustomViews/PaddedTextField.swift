//
//  PaddedTextField.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/23/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 16, y: bounds.origin.y, width: bounds.width - 32, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 16, y: bounds.origin.y, width: bounds.width - 32, height: bounds.height)
    }
}
