//
//  HomeController.swift
//  ZonicApp
//
//  Created by MagdielG on 4/22/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import UIKit
import Firebase
import MapKit

private let reuseIdentifier = "LocationCell"

class HomeController: UIViewController {
    
    // MARK: - Properties

    private let screenSize = UIScreen.main.bounds.size
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    
    private var user:User? {
        didSet {locationInputView.user = user}
    }
    
    
    private final let locationInputViewHeight:CGFloat = 200
    
    private let signOutButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    //MARK: - View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        chekIfUserIsLoggedIn()
        enableLocationServices()
        fetchUserData()
 
        
        
        
        configureNavigationBar()
    }
    
    // MARK: - API
    
    func fetchUserData() {
        Service.shared.fetchUserData { user in
            self.user = user
        }
    }
    
    func chekIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil{
            self.navigationController?.pushViewController(LoginViewController(), animated: false)
        }else{
           configureUI()
        }
        
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            navigationController?.view.semanticContentAttribute = .forceRightToLeft
        } catch  {
            print("DEBUG: Error signOut")
        }
    }
    
    
    func configureNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    
    func configureUI() {
        configureMapView()
        
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(height: 55, width: view.frame.width - 30)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 52)
        inputActivationView.layer.cornerRadius = 27
        inputActivationView.alpha = 0
        inputActivationView.delegate = self
        
        UIView.animate(withDuration: 2) {
            self.inputActivationView.alpha = 1
        }
        
        navigationItem.hidesBackButton = true
        view.backgroundColor = .backgroundColor
        
        view.addSubview(signOutButton)
        signOutButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: 0, paddingLeft: 20)
        
        configureTableView()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
    }
    
    func configureLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5,delay: 0,usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0, options: .curveEaseInOut  ,animations: {
            self.locationInputView.alpha = 1
            self.locationInputView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 150)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight

            }
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height - 10, width: view.frame.width, height: height)
        
        view.addSubview(tableView)
    }
    
    
}
// MARK: - LocationServices
extension HomeController: CLLocationManagerDelegate{
    func enableLocationServices(){
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            print("DEBUG: Not dermined...")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth Always...")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use...")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}

//MARK: - LocationInputActivationViewDelegate

extension HomeController: LocationInputActivationViewDelegate{
    func presentLocationInputView() {
        inputActivationView.alpha = 0
        configureLocationInputView()
        
    }
}

//MARK: - LocationInputViewDelegate

extension HomeController: LocationInputViewDelegate {
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.5,delay: 0,usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0, options: .curveEaseInOut  ,animations: {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        }) { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3, animations:  {
                self.inputActivationView.alpha = 1
            })
        }
    }
    
    
}

//MARK: - UITableViewDelegate / DataSource


extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2: 5

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as!
        LocationCell
        return cel
    }
    
    
}
