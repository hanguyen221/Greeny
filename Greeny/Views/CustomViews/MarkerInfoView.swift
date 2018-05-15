//
//  MarkerInfoView.swift
//  Greeny
//
//  Created by Tung Nguyen on 5/15/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class MarkerInfoView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet var treeNameLabel: UILabel!
    @IBOutlet var waterNeedLabel: UILabel!
    @IBOutlet var progressConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MarkerInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func configure(with tree: ModelTree) {
        
        UIView.animate(withDuration: 0.5) {
            self.treeNameLabel.text = tree.name
            self.waterNeedLabel.text = "Cần \(tree.totalWater - tree.currentWater) lít"
            if tree.totalWater == 0 {
                self.progressConstraint = self.progressConstraint.setMultiplier(multiplier: 0)
            } else {
                if tree.currentWater == tree.totalWater {
                    self.progressConstraint = self.progressConstraint.setMultiplier(multiplier: 1.0)
                } else {
                    self.progressConstraint = self.progressConstraint.setMultiplier(multiplier: CGFloat(tree.currentWater) / CGFloat(tree.totalWater))
                }
                
            }
            self.layoutIfNeeded()
        }
        
        
        
    }
    
}
