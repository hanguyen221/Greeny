//
//  SettingsCell.swift
//  Greeny
//
//  Created by Ha Nguyen on 5/16/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var controller: SettingsController?
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 0, g: 0, b: 0, a: 0.7)
        label.text = "Username"
        return label
    }()
    
    lazy var contentTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = controller
        tf.textColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        return tf
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileLabel)
        setupProfileLabel()
        
        addSubview(contentTextField)
        setupContentTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProfileLabel() {
        profileLabel.anchorWithConstraints(leftAnchor: self.leftAnchor,
                                           leftConstant: 16,
                                           centerYAnchor: self.centerYAnchor)
    }
    
    func setupContentTextField() {
        contentTextField.anchorWithConstraints(rightAnchor: self.rightAnchor,
                                               rightConstant: 16,
                                               centerYAnchor: self.centerYAnchor)
    }
    
}
