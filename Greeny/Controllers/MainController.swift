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

class MainController: BaseController, GMSMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    let trees: [ModelTree] = [
        ModelTree(name: "Cây 1", lat: 21.006274, lng: 105.842803, icon: UIImage(named: "ic_tree_red"), waterNeed: 1),
        ModelTree(name: "Cây 2", lat: 21.006985, lng: 105.844005, icon: UIImage(named: "tree2_red"), waterNeed: 3),
        ModelTree(name: "Cây 3", lat: 21.005678, lng: 105.8411293, icon: UIImage(named: "tree3_red"), waterNeed: 2),
        ModelTree(name: "Cây 4", lat: 21.005693, lng: 105.844616, icon: UIImage(named: "tree4_red"), waterNeed: 2),
        ModelTree(name: "Cây 5", lat: 21.003419, lng: 105.843736, icon: UIImage(named: "tree4_red"), waterNeed: 1),
        ModelTree(name: "Cây 6", lat: 21.004141, lng: 105.843951, icon: UIImage(named: "tree5_red"), waterNeed: 4),
        ModelTree(name: "Cây 7", lat: 21.005112, lng: 105.843629, icon: UIImage(named: "tree3_green"), waterNeed: 0),
        ModelTree(name: "Cây 8", lat: 21.005112, lng: 105.845174, icon: UIImage(named: "tree2_red"), needWater: false, waterNeed: 0),
        ModelTree(name: "Cây 9", lat: 21.004742, lng: 105.841955, icon: UIImage(named: "tree1_red"), waterNeed: 3),
        ModelTree(name: "Cây 10",lat: 21.004531,lng:  105.843050, icon: UIImage(named: "ic_tree_red"), waterNeed: 1)
    ]
    
    let waterLocations: [ModelWater] = [
        ModelWater(name: "Nguồn 1", lat: 21.004017, lng: 105.842283),
        ModelWater(name: "Nguồn 2", lat: 21.006141, lng: 105.843774)
    ]
    
    // n0->4->5->9->8->n0->2->0->n1->6->7->3->n1->1
    let paths: [(Int, Int, Int)] = [
        (1, 0, 8),
        (0, 8, 9),
        (0, 9, 3),
        (0, 3, 5),
//        (2, 8, 0),
//        (1, 0, 2),
//        (0, 2, 0),
//        (2, 0, 1),
//        (1, 1, 6),
//        (0, 6, 7),
//        (0, 7, 3),
//        (2, 3, 1),
//        (1, 1, 1)
    ]
    
    var currentIndex = 0
    
    var line: GMSPolyline = GMSPolyline()
    
    var treeMarkers = [GMSMarker]()
    var waterMarkers = [GMSMarker]()
    
    let hamburgerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_hamburger")?.alpha(0.9), for: .normal)
        button.tintColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
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
        button.tintColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
    }
    
    var mapView: GMSMapView?
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: waterLocations[0].lat, longitude: waterLocations[0].lng, zoom: 17)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        setupMarkers(with: mapView!)
        initDirections(mapView: mapView!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        let loginVC = LoginController()
        present(loginVC, animated: false, completion: nil)
        
        view.addSubview(hamburgerButton)
        view.addSubview(nextButton)
        view.addSubview(prevButton)
        setupHamburgerButton()
        setupNextButton()
        setupPrevButton()
        
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
        
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
            drawDirection(mapView: mapView!, pathIndex: currentIndex)
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Đã tưới xong cây của buổi này", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func prevPath() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
        drawDirection(mapView: mapView!, pathIndex: currentIndex)
    }
    
    func setupMarkers(with mapView: GMSMapView) {
        for tree in trees {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(tree.lat, tree.lng)
            marker.title = tree.name
            marker.icon = tree.icon
            marker.snippet = tree.desc
            marker.map = mapView
            treeMarkers.append(marker)
        }
        
        for (index,water) in waterLocations.enumerated() {
            let marker = GMSMarker()
            
            marker.position = CLLocationCoordinate2DMake(water.lat, water.lng)
            marker.title = water.name
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
                self.line.strokeColor = Const.BLUE
                self.line.map = mapView
            }
        }
    }
    
    func initDirections(mapView: GMSMapView) {
        drawDirection(mapView: mapView, pathIndex: 0)
    }
    
    func drawDirection(mapView: GMSMapView, pathIndex: Int) {
        let path = paths[pathIndex]
        var startObj: ModelObject?
        var endObj: ModelObject?
        if path.0 == 0 {
            startObj = trees[path.1]
            endObj = trees[path.2]
            mapView.selectedMarker = treeMarkers[path.2]
        } else if path.0 == 1 {
            startObj = waterLocations[path.1]
            endObj = trees[path.2]
            mapView.selectedMarker = treeMarkers[path.2]
        } else {
            startObj = trees[path.1]
            endObj = waterLocations[path.2]

        }
        let startLoc = CLLocation(latitude: startObj!.lat, longitude: startObj!.lng)
        let endLoc = CLLocation(latitude: endObj!.lat, longitude: endObj!.lng)
        drawDirection(mapView: mapView, start: startLoc, destination: endLoc)
        let camera = GMSCameraPosition.camera(withLatitude: endObj!.lat, longitude: endObj!.lng , zoom: 17)
        mapView.animate(to: camera)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let index = treeMarkers.index(of: marker) else {
            return false
        }
        let tree = trees[index]
        var information: String = "Cây đã đủ nước, không cần tưới"
        if (tree.needWater) {
            information = "\(tree.name) - \(tree.desc) \n Tưới cây này?"
        }
        let alert = UIAlertController(title: "Xác nhận", message: information, preferredStyle: UIAlertControllerStyle.alert)
        if (tree.needWater) {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                marker.icon = UIImage(named: "ic_tree_green")!
            }))
            alert.addAction(UIAlertAction(title: "Huỷ", style: UIAlertActionStyle.cancel, handler: nil))
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
        return true
    }
    
}








