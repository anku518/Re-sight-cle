//
//  RecycleController.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 10/11/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

struct SearchResult {
    var isCurrentLocation : Int?
    var name: String?
    var phoneNumber: String?
    var placemark: String?
    var timeZone: String?
    var url: String?
    
    init(isCurrentLocation: Int? = nil, name: String? = nil, phoneNumber: String? = nil, placemark: String? = nil, timeZone: String? = nil, url: String? = nil) {
        self.isCurrentLocation = isCurrentLocation
        self.name = name
        self.phoneNumber = phoneNumber
        self.placemark = placemark
        self.timeZone = timeZone
        self.url = url
    }
    
}


class RecycleController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var item: String?
    
    var recycleImage: UIImage?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? RecycleLocationCell
       
        if let item = mapItems[indexPath.row].name {
            //cell?.info?.name = item
            cell?.recycleCompany.text = item
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? RecycleLocationCell
        print(indexPath.row)
        let contactController = ContactController()
        print(mapItems[indexPath.row].name)
        guard let name = mapItems[indexPath.row].name else {return}
        guard let phone = mapItems[indexPath.row].phoneNumber else {return}
        guard let url = mapItems[indexPath.row].url?.absoluteString else {return}
        guard let address = mapItems[indexPath.row].placemark.title else {return}
        contactController.recycleCompany = name
        contactController.phone = phone
        contactController.url = url
        contactController.address = address
        guard let recycleItem = item else {return}
        contactController.itemName = recycleItem
        contactController.recycleImage = recycleImage
        navigationController?.pushViewController(contactController, animated: true)
//        let navController = UINavigationController(rootViewController: contactController)
//        navController.modalPresentationStyle = .fullScreen
//
//        present(navController, animated: true)
        
    }
    
    
    var mapView: MKMapView  = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    var recycleLocationTableView = UITableView()
    
    var manager = CLLocationManager()
    
    var mapItems: [MKMapItem] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .black
        view.alpha = 0.7
        
        setUpMapView()
        
        
        //Set up Accuracy
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Set delegate
        manager.delegate = self
        
        if CLLocationManager.locationServicesEnabled(){
            //Request
            manager.requestWhenInUseAuthorization()
            
            //StartUpdating
            manager.startUpdatingLocation()
        }
        
        
        
        searchResults()
        
        //addAnnotations()

        setUpTableView()
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recycleLocationTableView.reloadData()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        //Set Span
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)

//        let pin = MKPointAnnotation()
//        pin.coordinate = location.coordinate
//        mapView.addAnnotation(pin)
        
    }
    
    
    

    func setUpMapView(){
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     mapView.heightAnchor.constraint(equalToConstant: 300)])
        
    }
    
    func searchResults(){
        
        //Setup request
        let searchRequest = MKLocalSearch.Request()
        
        //Query
        guard let search = item else {return}
        print(search)
        
        
        searchRequest.naturalLanguageQuery = "\(search) Recycling"
        
        //Search object
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        //Start Search
        activeSearch.start { response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print(response)
                
            }
            guard let items = response?.mapItems else {return}
            
            self.mapItems = items
            
            for item in items{
                let latitude = item.placemark.coordinate.latitude
                let longitude = item.placemark.coordinate.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = item.placemark.name
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.mapView.addAnnotation(annotation)
            }
            
            
            print(self.mapItems.first!.name)
            
        
           self.recycleLocationTableView.reloadData()
        }
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var annnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
//        if annnotationView == nil{
//            annnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
//            annnotationView?.canShowCallout = true
//
//        }else{
//            annnotationView?.annotation = annotation
//        }
//
//        annnotationView?.image = UIImage(named: "Icon-29")
//        return annnotationView
//    }
    
    func setUpTableView(){
        view.addSubview(recycleLocationTableView)
        recycleLocationTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([recycleLocationTableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
                                     recycleLocationTableView.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 10),
                                     recycleLocationTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                                     recycleLocationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)])
        
        recycleLocationTableView.delegate = self
        recycleLocationTableView.dataSource = self
        
        recycleLocationTableView.register(RecycleLocationCell.self, forCellReuseIdentifier: "cellID")
        recycleLocationTableView.layer.cornerRadius =  20
        
        
    }
    
}
