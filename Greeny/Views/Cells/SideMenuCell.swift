//
//  SideMenuCell.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/21/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    let ICON_SIZE: CGFloat = 28
    let LABEL_COLOR: UIColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.6)
    
    lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "ic_settings")
        iv.image = iv.image!.withRenderingMode(.alwaysTemplate)
        iv.tintColor = LABEL_COLOR
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Update profile"
        label.textColor = LABEL_COLOR
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconView)
        setupIconView()
        
        addSubview(titleLabel)
        setupTitleLabel()
    }
    
    func setupIconView() {
        iconView.anchorWithConstraints(topAnchor: topAnchor,
                                       topConstant: 12,
                                       leftAnchor: leftAnchor,
                                       leftConstant: 16,
                                       centerYAnchor: centerYAnchor,
                                       widthConstant: ICON_SIZE,
                                       heightConstant: ICON_SIZE)
    }
    
    func setupTitleLabel() {
        titleLabel.anchorWithConstraints(leftAnchor: iconView.rightAnchor,
                                         leftConstant: 8,
                                         centerYAnchor: iconView.centerYAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

