//
//  SideMenuCell.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/21/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Update profile"
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        titleLabel.anchorWithConstraints(topAnchor: topAnchor,
                                         topConstant: 8,
                                         leftAnchor: leftAnchor,
                                         leftConstant: 16,
                                         centerYAnchor: centerYAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

