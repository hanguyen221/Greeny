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
    
    let treeLocations: [(String, Double, Double, String)] = [
        ("Cây 1", 21.006274, 105.842803, "Can 1 lit nuoc"),
        ("Cây 2", 21.006985, 105.844005, "Can 6 lit nuoc"),
        ("Cây 3", 21.005678, 105.8411293, "Can 3 lit nuoc"),
        ("Cây 4", 21.005693, 105.844616, "Can 1 lit nuoc"),
        ("Cây 5", 21.003419, 105.843736, "Can 1 lit nuoc"),
        ("Cây 6", 21.004141, 105.843951, "Can 5 lit nuoc"),
        ("Cây 7", 21.005112, 105.843629, "Can 2 lit nuoc"),
        ("Cây 8", 21.005112, 105.845174, "Can 3 lit nuoc"),
        ("Cây 9", 21.004742, 105.841955, "Can 4 lit nuoc"),
        ("Cây 10", 21.004531, 105.843050, "Can 1 lit nuoc")
    ]
    
    let waterLocations: [(String, Double, Double)] = [
        ("Nguồn 1", 21.004017, 105.842283),
        ("Nguồn 2", 21.006141, 105.843774)
    ]
    
    // n0->4->5->9->8->n0->2->0->n1->6->7->3->n1->1
    let paths: [(Int, Int, Int)] = [
        (1, 0, 4),
        (0, 4, 5),
        (0, 5, 9),
        (0, 9, 8),
        (2, 8, 0),
        (1, 0, 2),
        (0, 2, 0),
        (2, 0, 1),
        (1, 1, 6),
        (0, 6, 7),
        (0, 7, 3),
        (2, 3, 1),
        (1, 1, 1)
    ]
    
    var currentIndex = 0
    
    var line: GMSPolyline = GMSPolyline()
    
    var treeMarkers = [GMSMarker]()
    var waterMarkers = [GMSMarker]()
    
    let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_hamburger")?.alpha(0.8), for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        var img = UIImage(named: "ic_next")?.alpha(0.8)
        img = Utils.resizeImage(image: img!, targetSize: CGSize(width: (img?.size.width)! * 0.7, height: (img?.size.height)! * 0.7))
        button.setImage(img, for: .normal)
        styleButton(button: button)
        button.addTarget(self, action: #selector(nextPath), for: .touchUpInside)
        return button
    }()
    
    lazy var prevButton: UIButton = {
        let button = UIButton(type: .custom)
        var img = UIImage(named: "ic_prev")?.alpha(0.8)
        img = Utils.resizeImage(image: img!, targetSize: CGSize(width: (img?.size.width)! * 0.7, height: (img?.size.height)! * 0.7))
        button.setImage(img, for: .normal)
        styleButton(button: button)
        button.addTarget(self, action: #selector(prevPath), for: .touchUpInside)
        return button
    }()
    
    func styleButton(button: UIButton) {
        button.contentMode = .scaleAspectFit
        button.setBackgroundColor(color: UIColor.init(r: 255, g: 255, b: 255, a: 1), forState: .normal)
        button.setBackgroundColor(color: UIColor.init(r: 255, g: 255, b: 255, a: 0.7), forState: .highlighted)
        button.tintColor = .white
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
    }
    
    var mapView: GMSMapView?
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: waterLocations[0].1, longitude: waterLocations[0].2, zoom: 17)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        setupMarkers(with: mapView!)
        initDirections(mapView: mapView!)
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
    
    @objc func nextPath() {
        if currentIndex < paths.count - 1 {
            currentIndex += 1
        }
        drawPath(mapView: mapView!, index: currentIndex)
    }
    
    @objc func prevPath() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
        drawPath(mapView: mapView!, index: currentIndex)
    }
    
    func setupMarkers(with mapView: GMSMapView) {
        for tree in treeLocations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(tree.1, tree.2)
            marker.title = tree.0
            marker.icon = UIImage(named: "ic_tree_green")
            marker.snippet = tree.3
            marker.map = mapView
            treeMarkers.append(marker)
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
            waterMarkers.append(marker)
        }
    }
    
    func drawDirection(mapView: GMSMapView, start: CLLocation, destination: CLLocation) {
        let origin = "\(start.coordinate.latitude),\(start.coordinate.longitude)"
        let destination = "\(destination.coordinate.latitude),\(destination.coordinate.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking"
        Alamofire.request(url).responseJSON { response in
            self.line.map = nil
            let json = try! JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            for route in routes {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                self.line = GMSPolyline(path: path)
                self.line.path = path
                self.line.strokeWidth = 3
                self.line.strokeColor = UIColor.blue
                self.line.map = mapView
            }
        }
    }
    
    func drawPath(mapView: GMSMapView, index: Int) {
        let path = paths[index]
        if path.0 == 0 {
            drawDirection(mapView: mapView, startTreeIndex: path.1, endTreeIndex: path.2)
        } else if path.0 == 1 {
            drawDirectionWaterToTree(mapView: mapView, waterIndex: path.1, treeIndex: path.2)
        } else {
            drawDirectionTreeToWater(mapView: mapView, treeIndex: path.1, waterIndex: path.2)
        }
    }
    
    func initDirections(mapView: GMSMapView) {
        drawPath(mapView: mapView, index: 0)
    }
    
    func drawDirection(mapView: GMSMapView, startTreeIndex: Int, endTreeIndex: Int) {
        let firstTreeLocation = CLLocation(latitude: treeLocations[startTreeIndex].1, longitude: treeLocations[startTreeIndex].2)
        let secondTreeLocation = CLLocation(latitude: treeLocations[endTreeIndex].1, longitude: treeLocations[endTreeIndex].2)
        drawDirection(mapView: mapView, start: firstTreeLocation, destination: secondTreeLocation)
        mapView.selectedMarker = treeMarkers[endTreeIndex]
        let camera = GMSCameraPosition.camera(withLatitude: treeLocations[endTreeIndex].1, longitude:  treeLocations[endTreeIndex].2 , zoom: 17)
        mapView.animate(to: camera)
    }
    
    func drawDirectionTreeToWater(mapView: GMSMapView, treeIndex: Int, waterIndex: Int) {
        let treeLocation = CLLocation(latitude: treeLocations[treeIndex].1, longitude: treeLocations[treeIndex].2)
        let waterLocation = CLLocation(latitude: waterLocations[waterIndex].1, longitude: waterLocations[waterIndex].2)
        drawDirection(mapView: mapView, start: treeLocation, destination: waterLocation)
        mapView.selectedMarker = waterMarkers[waterIndex]
        let camera = GMSCameraPosition.camera(withLatitude: waterLocations[waterIndex].1, longitude:  waterLocations[waterIndex].2, zoom: 17)
        mapView.animate(to: camera)
    }
    
    func drawDirectionWaterToTree(mapView: GMSMapView, waterIndex: Int, treeIndex: Int) {
        let treeLocation = CLLocation(latitude: treeLocations[treeIndex].1, longitude: treeLocations[treeIndex].2)
        let waterLocation = CLLocation(latitude: waterLocations[waterIndex].1, longitude: waterLocations[waterIndex].2)
        drawDirection(mapView: mapView, start: waterLocation, destination: treeLocation)
        mapView.selectedMarker = treeMarkers[treeIndex]
        let camera = GMSCameraPosition.camera(withLatitude: treeLocations[treeIndex].1, longitude: treeLocations[treeIndex].2, zoom: 17)
        mapView.animate(to: camera)
    }
    
}
