//
//  SideMenuRootController.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/20/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class SideMenuRootController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    let sideMenuOptions: [SideMenuOption] = [
        SideMenuOption(icon: UIImage(named: "ic_edit")!, label: "Cập nhật thông tin"),
        SideMenuOption(icon: UIImage(named: "ic_calendar")!, label: "Đăng kí lịch nghỉ"),
        SideMenuOption(icon: UIImage(named: "ic_settings")!, label: "Cài đặt"),
        SideMenuOption(icon: UIImage(named: "ic_logout")!, label: "Đăng xuất")
    ]
    
    let AVATAR_SIZE: CGFloat = 36
    
    let cellId = "cellId"
    
    let profileView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_avatar")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = AVATAR_SIZE / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ha Nguyen"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "hanguyen@gmail.com"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.54)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(profileView)
        setupProfileView()
        
        profileView.addSubview(avatarView)
        setupAvatarView()
        
        profileView.addSubview(nameLabel)
        setupNameLabel()
        
        profileView.addSubview(idLabel)
        setupIdLabel()
        
        view.addSubview(tableView)
        setupTableView()
    }
    
    func setupProfileView() {
        profileView.anchorWithConstraints(topAnchor: view.topAnchor,
                                          leftAnchor: view.leftAnchor,
                                          rightAnchor: view.rightAnchor)
    }
    
    func setupAvatarView() {
        avatarView.anchorWithConstraints(topAnchor: profileView.topAnchor,
                                         topConstant: 32,
                                         leftAnchor: profileView.leftAnchor,
                                         leftConstant: 16,
                                         centerYAnchor: profileView.centerYAnchor,
                                         widthConstant: AVATAR_SIZE,
                                         heightConstant: AVATAR_SIZE)
    }
    
    func setupNameLabel() {
        nameLabel.anchorWithConstraints(leftAnchor: avatarView.rightAnchor,
                                        leftConstant: 8,
                                        centerYAnchor: avatarView.centerYAnchor,
                                        centerYConstant: -8)
    }
    
    func setupIdLabel() {
        idLabel.anchorWithConstraints(leftAnchor: nameLabel.leftAnchor,
                                      centerYAnchor: avatarView.centerYAnchor,
                                      centerYConstant: 8)
    }
    
    func setupTableView() {
        tableView.anchorWithConstraints(topAnchor: profileView.bottomAnchor,
                                        leftAnchor: view.leftAnchor,
                                        bottomAnchor: view.bottomAnchor,
                                        rightAnchor: view.rightAnchor)
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SideMenuCell
        let option = sideMenuOptions[indexPath.row]
        cell.iconView.image = option.icon
        cell.titleLabel.text = option.label
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 3) {
            present(LoginController(), animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.item
        if index == 0 {
            gotoScheduleRegisterController()
        } else if index == 1 {
            gotoWaterHistoryController()
        }
        
    }
    
    func gotoScheduleRegisterController() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ScheduleRegisterController") as! ScheduleRegisterController
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        controller.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func gotoWaterHistoryController() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WaterHistoryController") as! WaterHistoryController
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        controller.navigationItem.backBarButtonItem = backButton
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}





