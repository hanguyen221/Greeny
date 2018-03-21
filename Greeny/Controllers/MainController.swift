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
import Alamofire
import SwiftyJSON


class MainController: BaseController {
    
    let treeLocations: [(String, Double, Double)] = [
        ("Cây 1", 21.006274, 105.842803),
        ("Cây 2", 21.006985, 105.844005),
        ("Cây 3", 21.005678, 105.8411293),
        ("Cây 4", 21.005693, 105.844616),
        ("Cây 5", 21.003419, 105.843736),
        ("Cây 6", 21.004141, 105.843951),
        ("Cây 7", 21.005112, 105.843629),
        ("Cây 8", 21.005112, 105.845174),
        ("Cây 9", 21.004742, 105.841955),
        ("Cây 10", 21.004531, 105.843050)
    ]
    
    let waterLocations: [(String, Double, Double)] = [
        ("Nguồn 1", 21.004017, 105.842283),
        ("Nguồn 2", 21.006141, 105.843774)
    ]
    
    let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_hamburger")?.alpha(0.8), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_next")?.alpha(0.8), for: .normal)
//        button.tintColor = .white
        button.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        return button
    }()
    
    let prevButton: UIButton = {
        let button = UIButton(type: .custom)
        var img = UIImage(named: "ic_prev")?.alpha(0.8)
        img = Utils.resizeImage(image: img!, targetSize: CGSize(width: (img?.size.width)! * 0.7, height: (img?.size.height)! * 0.7))
        button.setImage(img, for: .normal)
        button.contentMode = .scaleAspectFit
        button.setBackgroundColor(color: UIColor.init(r: 255, g: 255, b: 255, a: 0.4), forState: .normal)
        button.setBackgroundColor(color: UIColor.init(r: 255, g: 255, b: 255, a: 0.95), forState: .highlighted)
        button.tintColor = .white
//        button.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: waterLocations[0].1, longitude: waterLocations[0].2, zoom: 17)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        setupMarkers(with: mapView)
        initDirections(mapView: mapView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(hamburgerButton)
        view.addSubview(nextButton)
        view.addSubview(prevButton)
        setupHamburgerButton()
        setupNextButton()
        setupPrevButton()
    }
    
    func setupHamburgerButton() {
        hamburgerButton.anchorWithConstraints(topAnchor: view.topAnchor,
                                              topConstant: 24,
                                              leftAnchor: view.leftAnchor,
                                              leftConstant: 16,
                                              widthConstant: 32,
                                              heightConstant: 32)
    }
    
    func setupNextButton() {
        nextButton.anchorWithConstraints(bottomAnchor: view.bottomAnchor,
                                         bottomConstant: 16,
                                         rightAnchor: view.rightAnchor,
                                         rightConstant: 16,
                                         widthConstant: 48,
                                         heightConstant: 48)
    }
    
    func setupPrevButton() {
        prevButton.anchorWithConstraints(bottomAnchor: view.bottomAnchor,
                                         bottomConstant: 16,
                                         rightAnchor: nextButton.leftAnchor,
                                         rightConstant: 16,
                                         widthConstant: 48,
                                         heightConstant: 48)
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
    
    func setupMarkers(with mapView: GMSMapView) {
        for tree in treeLocations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(tree.1, tree.2)
            marker.title = tree.0
            marker.icon = UIImage(named: "ic_tree_green")
            marker.map = mapView
        }
        
        for (index,water) in waterLocations.enumerated() {
            let marker = GMSMarker()
            
            marker.position = CLLocationCoordinate2DMake(water.1, water.2)
            marker.title = water.0
            marker.icon = UIImage(named: "ic_water_resource")
            
            marker.map = mapView
            if index == 0 {
                mapView.selectedMarker = marker
            }
        }
    }
    
    func drawDirection(mapView: GMSMapView, start: CLLocation, destination: CLLocation) {
        let origin = "\(start.coordinate.latitude),\(start.coordinate.longitude)"
        let destination = "\(destination.coordinate.latitude),\(destination.coordinate.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking"
        var line: GMSPolyline = GMSPolyline()
        Alamofire.request(url).responseJSON { response in
            let json = try! JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            for route in routes {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                line = GMSPolyline(path: path)
                line.path = path
                line.strokeWidth = 3
                line.strokeColor = UIColor.blue
                line.map = mapView
            }
        }
    }
    
    func initDirections(mapView: GMSMapView) {
//        for i in 0 ..< treeLocations.count - 1 {
//            let start = CLLocation(latitude: treeLocations[i].1, longitude: treeLocations[i].2)
//            let end = CLLocation(latitude: treeLocations[i + 1].1, longitude: treeLocations[i + 1].2)
//            drawDirection(mapView: mapView, start: start, destination: end)
//        }
        let firstTreeLocation = CLLocation(latitude: treeLocations[0].1, longitude: treeLocations[0].2)
        let firstWaterLocation = CLLocation(latitude: waterLocations[0].1, longitude: waterLocations[0].2)
        drawDirection(mapView: mapView, start: firstTreeLocation, destination: firstWaterLocation)
        
    }
    
    
    
}
