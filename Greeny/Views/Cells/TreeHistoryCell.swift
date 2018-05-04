//
//  TreeHistoryCell.swift
//  Greeny
//
//  Created by Tung Nguyen on 5/4/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class TreeHistoryCell: UITableViewCell {

    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var treeLabel: UILabel!
    @IBOutlet var waterAmountLabel: UILabel!
    
    var historyModel: TreeHistoryModel? {
        didSet {
            dateTimeLabel.text = historyModel?.date
            treeLabel.text = historyModel?.tree.name
            waterAmountLabel.text = "\(historyModel?.water ?? 1) lít"
        }
    }
}
