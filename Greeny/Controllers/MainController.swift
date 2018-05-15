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
    
    //MARK: - Nav's UIViews
    
    @IBOutlet var userTypeLabel: UILabel!
    @IBOutlet var currentWaterLabel: UILabel!
    
    var currentWater: Double = 10.0
    
    var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    let tree_1 = ModelTree(type: 1, name: "Cây 1", lat: 21.006274, lng: 105.842803, totalWater: 5, currentWater: 2)
    let tree_2 = ModelTree(type: 3, name: "Cây 2", lat: 21.006985, lng: 105.844005, totalWater: 5, currentWater: 5)
    let tree_3 = ModelTree(type: 4, name: "Cây 3", lat: 21.005678, lng: 105.8411293, totalWater: 6, currentWater: 1)
    let tree_4 = ModelTree(type: 0, name: "Cây 4", lat: 21.005693, lng: 105.844616, totalWater: 4, currentWater: 4)
    let tree_5 = ModelTree(type: 4, name: "Cây 5", lat: 21.003419, lng: 105.843736, totalWater: 3, currentWater: 2)
    let tree_6 = ModelTree(type: 2, name: "Cây 6", lat: 21.004141, lng: 105.843951, totalWater: 2, currentWater: 1)
    let tree_7 = ModelTree(type: 2, name: "Cây 7", lat: 21.005112, lng: 105.843629, totalWater: 2, currentWater: 2)
    let tree_8 = ModelTree(type: 1, name: "Cây 8", lat: 21.005112, lng: 105.845174, totalWater: 4, currentWater: 2)
    let tree_9 = ModelTree(type: 0, name: "Cây 9", lat: 21.004742, lng: 105.841955, totalWater: 10, currentWater: 8)
    let tree_10 = ModelTree(type: 3, name: "Cây 10", lat: 21.004531,lng:  105.843050, totalWater: 4, currentWater: 4)
    
    var trees: [ModelTree] = []
    
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
        (2, 5, 0),
        (1, 0, 2),
        (0, 2, 0),
        (2, 0, 1),
        (1, 1, 6),
        (0, 6, 7),
        (0, 7, 3),
        (2, 3, 1),
        (1, 1, 0)
    ]
    
    var currentIndex = 0
    
    var line: GMSPolyline = GMSPolyline()
    
    var treeMarkers = [GMSMarker]()
    var waterMarkers = [GMSMarker]()
    
    var markerView: MarkerInfoView?
    
    @IBOutlet weak var hamburgerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet var getWaterButton: UIButton!
    
    
    @IBOutlet var navView: UIView!
    @IBOutlet var infoView: MarkerInfoView!
    
    var timer = Timer()
    
    func styleButton(button: UIButton) {
        button.contentMode = .scaleAspectFit
        button.setBackgroundColor(color: UIColor.init(r: 255, g: 255, b: 255, a: 1), forState: .normal)
        button.setBackgroundColor(color: UIColor.init(r: 255, g: 255, b: 255, a: 0.7), forState: .highlighted)
        button.tintColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet var progressWidthConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        let loginVC = LoginController()
        present(loginVC, animated: false, completion: nil)
        
        trees.append(tree_1)
        trees.append(tree_2)
        trees.append(tree_3)
        trees.append(tree_4)
        trees.append(tree_5)
        trees.append(tree_6)
        trees.append(tree_7)
        trees.append(tree_8)
        trees.append(tree_9)
        trees.append(tree_10)
        
        view.addSubview(infoView)
        
        currentWaterLabel.text = "10/10 lít"
        
        progressWidthConstraint.constant = 97
        
        setupHamburgerButton()
        setupNextButton()
//        setupPrevButton()
        setupWaterButton()
        setupGetWaterButton()
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
        self.markerView = MarkerInfoView()
        
        let camera = GMSCameraPosition.camera(withLatitude: waterLocations[0].lat, longitude: waterLocations[0].lng, zoom: 17)
        setupMarkers(with: mapView!)
//        initDirections(mapView: mapView!)
        
        nextPath()
        
        mapView.animate(to: camera)
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupHamburgerButton() {
        hamburgerButton.tintColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
        hamburgerButton.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
    }
    
    func setupNextButton() {
        var img = UIImage(named: "ic_next")?.alpha(0.8)
        img = Utils.resizeImage(image: img!, targetSize: CGSize(width: (img?.size.width)! * 0.7, height: (img?.size.height)! * 0.7))
        nextButton.setImage(img, for: .normal)
        styleButton(button: nextButton)
        nextButton.addTarget(self, action: #selector(nextPath), for: .touchUpInside)
    }
    
    func setupPrevButton() {
        var img = UIImage(named: "ic_prev")?.alpha(0.8)
        img = Utils.resizeImage(image: img!, targetSize: CGSize(width: (img?.size.width)! * 0.7, height: (img?.size.height)! * 0.7))
        prevButton.setImage(img, for: .normal)
        styleButton(button: prevButton)
        prevButton.addTarget(self, action: #selector(prevPath), for: .touchUpInside)
    }
    
    func setupWaterButton() {
        waterButton.addTarget(self, action: #selector(water), for: .touchUpInside)
    }
    
    func setupGetWaterButton() {
        getWaterButton.addTarget(self, action: #selector(getWater), for: .touchUpInside)
    }
    
    var isWatering = false
    
    var currentTree: ModelTree?
    var currentMarker: GMSMarker?
    
    @objc func getWater() {
        let waterGetAmount = 10 - currentWater
        
        if waterGetAmount == 0 {
            alert(message: "Bình vẫn đầy. Không cần lấy thêm nước. ")
        } else {
            alert(message: "Đã lấy \(waterGetAmount) lít. Hiện có 10 lít nước.")
        }
        
        self.currentWater = 10
        self.progressWidthConstraint.constant = 97
        self.currentWaterLabel.text = "10/10 lít"
    }
    
    @objc func water() {
        
        guard currentWater > 0 else {
            self.alert(message: "Bình đã hết nước, vui lòng đi lấy thêm.")
            return
        }
        
        if let currentTree = currentTree {
            if currentWater >= (currentTree.totalWater - currentTree.currentWater) {
                self.infoView.updateMultipler(mul: 1.0)
                currentWater -= (currentTree.totalWater - currentTree.currentWater)
                currentTree.currentWater = currentTree.totalWater
                self.infoView.configure(with: currentTree)
                if currentTree.type == 0 {
                    currentMarker?.icon = UIImage(named: "ic_tree_green")
                } else {
                    currentMarker?.icon = UIImage(named: "tree\(currentTree.type)_green")
                }
                
            } else {
//                self.infoView.updateMultipler(mul: CGFloat((currentTree.currentWater + currentWater) / currentTree.totalWater))
                
                currentTree.currentWater += currentWater
                currentWater = 0
                self.infoView.configure(with: currentTree)
            }
            
            currentWaterLabel.text = "\(currentWater)/10 lít"
            UIView.animate(withDuration: 1, animations: {
                self.progressWidthConstraint.constant = CGFloat(self.currentWater * 10)
            })
            
        }
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
        if let randomNextTreeIndex = randomNextTree() {
            self.infoView.isHidden = false
            let tree = trees[randomNextTreeIndex]
            self.currentTree = tree
            self.currentMarker = treeMarkers[randomNextTreeIndex]
            infoView.configure(with: currentTree!)
            mapView.selectedMarker = treeMarkers[randomNextTreeIndex]
            let endLocation = CLLocation(latitude: tree.lat, longitude: tree.lng)
            guard let currentLocation = self.currentLocation else {return}
            drawDirection(mapView: mapView, start: currentLocation, destination: endLocation)
            showGetWaterButton(false)
        } else {
            alert(message: "Không còn cây nào chưa đủ nước")
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
//            marker.snippet = tree.desc
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
        
        guard let currentLocation = self.currentLocation else {return}
        
        drawDirection(mapView: mapView, start: currentLocation, destination: endLoc)
//        drawDirection(mapView: mapView, start: startLoc, destination: endLoc)
        
        let camera = GMSCameraPosition.camera(withLatitude: endObj!.lat, longitude: endObj!.lng , zoom: 17)
        mapView.animate(to: camera)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        guard let index = treeMarkers.index(of: marker) else {
            
            guard let waterIndex = waterMarkers.index(of: marker) else {
                return false
            }
            currentTree = nil
            currentMarker = nil
            infoView.isHidden = true
            guard let currentLocation = self.currentLocation else {return false}
            
            let water = waterLocations[waterIndex]
            let location = CLLocation(latitude: water.lat, longitude: water.lng)
            drawDirection(mapView: mapView, start: currentLocation, destination: location)
            showGetWaterButton(true)
            return false
        }
        self.currentMarker = marker
        self.currentTree = trees[index]
        let location = CLLocation(latitude: currentTree!.lat, longitude: currentTree!.lng)
        guard let currentLocation = self.currentLocation else {return false}
        drawDirection(mapView: mapView, start: currentLocation, destination: location)
        infoView.isHidden = false
        infoView.configure(with: trees[index])
        showGetWaterButton(false)
        return true
    }
    
    func randomNextTree() -> Int?{
        let treesNeedWater = trees.filter { (tree) -> Bool in
            return tree.currentWater < tree.totalWater
        }
        let random = Int(arc4random_uniform(UInt32(treesNeedWater.count)))
        let tree = treesNeedWater[random]
        for (index, t) in trees.enumerated() {
            if tree.name == t.name {
                return index
            }
        }
        return nil
    }
    
    func showGetWaterButton(_ show: Bool) {
        getWaterButton.isHidden = !show
        waterButton.isHidden = show
    }
    
}

extension MainController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.currentLocation = location
    }
    
}







