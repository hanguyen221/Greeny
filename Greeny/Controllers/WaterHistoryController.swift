//
//  WaterHistoryController.swift
//  Greeny
//
//  Created by Tung Nguyen on 5/4/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import Foundation
import UIKit

class WaterHistoryController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var historyArray = [TreeHistoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        tableView.register(UINib(nibName: "TreeHistoryCell", bundle: nil), forCellReuseIdentifier: "TreeHistoryCell")
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Lịch sử tưới cây"
        initHistory()
        tableView.reloadData()
    }
    
    func initHistory() {
        let tree1 = ModelTree(type: 1, name: "Cây 1", lat: 21.006274, lng: 105.842803, totalWater: 5, currentWater: 2)
        let tree2 = ModelTree(type: 2, name: "Cây 2", lat: 21.006274, lng: 105.842803, totalWater: 5, currentWater: 2)
        let tree3 = ModelTree(type: 3, name: "Cây 3", lat: 21.006274, lng: 105.842803, totalWater: 5, currentWater: 2)
        let tree4 = ModelTree(type: 4, name: "Cây 4", lat: 21.006274, lng: 105.842803, totalWater: 5, currentWater: 2)
        historyArray.append(TreeHistoryModel(date: "14:00 12/5/2018", tree: tree1, water: 2))
        historyArray.append(TreeHistoryModel(date: "14:30 8/5/2018", tree: tree2, water: 1))
        historyArray.append(TreeHistoryModel(date: "14:20 4/5/2018", tree: tree3, water: 4))
        historyArray.append(TreeHistoryModel(date: "13:00 27/4/2018", tree: tree4, water: 1))
        historyArray.append(TreeHistoryModel(date: "14:30 24/4/2018", tree: tree2, water: 3))
        historyArray.append(TreeHistoryModel(date: "15:00 21/4/2018", tree: tree4, water: 5))
        historyArray.append(TreeHistoryModel(date: "14:20 16/4/2018", tree: tree3, water: 2))
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension WaterHistoryController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreeHistoryCell", for: indexPath) as! TreeHistoryCell
        let historyModel = historyArray[indexPath.row]
        cell.historyModel = historyModel
        return cell
    }
    
}
