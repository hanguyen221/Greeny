//
//  MainController.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/18/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit
import SideMenu
import GoogleMaps

class MainController: BaseController {
    
    let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_hamburger")?.alpha(0.8), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: 21.005673, longitude: 105.843318, zoom: 16)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(hamburgerButton)
        setupHamburgerButton()
    }
    
    func setupHamburgerButton() {
        hamburgerButton.anchorWithConstraints(topAnchor: view.topAnchor,
                                              topConstant: 24,
                                              leftAnchor: view.leftAnchor,
                                              leftConstant: 16,
                                              widthConstant: 32,
                                              heightConstant: 32)
    }
    
    @objc func showSideMenu() {
        let sideMenuNavController = UISideMenuNavigationController(rootViewController: SideMenuRootController())
        sideMenuNavController.leftSide = true
        SideMenuManager.default.menuLeftNavigationController = sideMenuNavController
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view, forMenu: sideMenuNavController.edgesForExtendedLayout)
        SideMenuManager.default.menuFadeStatusBar = true
        SideMenuManager.default.menuAnimationBackgroundColor = .clear
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
}
