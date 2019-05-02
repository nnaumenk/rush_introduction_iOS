//
//  SecondViewController.swift
//  introductionIOS
//
//  Created by Nazar NAUMENKO on 4/24/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import UIKit
import MapKit

extension SecondViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location Updated")
        let location = locations[0]
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.map.setRegion(region, animated: true)
    }
    
    @IBAction func buttoneLocatePressed(_ sender: UIButton) {
        map.showsUserLocation = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        let location = map.userLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.map.setRegion(region, animated: true)
        print("button")
    }
}

extension SecondViewController: MKMapViewDelegate {
    func addMarker(index: Int){
        let marker = MKPointAnnotation()
        let place = DataController.places[index]
        marker.title = place.title
        marker.subtitle = place.subtitle
        marker.coordinate = CLLocationCoordinate2D(latitude: place.x, longitude: place.y)
        map.addAnnotation(marker)
        map.selectAnnotation(marker, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {return nil}
        let colors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.magenta, UIColor.cyan, UIColor.purple, UIColor.orange]
        let annotationView = MKPinAnnotationView()
        let random = Int(arc4random_uniform(8))
        annotationView.pinTintColor = colors[random]
        annotationView.canShowCallout = true
        //map.selectAnnotation(annotation, animated: true)
        
        annotationView.rightCalloutAccessoryView = UIButton()
        return annotationView
    }
    
    @IBAction func mapModeChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index{
        case 0: map.mapType = MKMapType.standard
        case 1: map.mapType = MKMapType.satellite
        case 2: map.mapType = MKMapType.hybrid
        default: break
        }
    }
}

class SecondViewController: UIViewController{

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        let index : Int!
        
        if (self.parent?.childViewControllers[0] is SecondViewController)
        {
            index = 0
            addMarker(index: index)
            let place = DataController.places[index]
            let center = CLLocationCoordinate2D(latitude: place.x, longitude: place.y)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
            return
        }
        index = DataController.currentIndex
        addMarker(index: index)
        let place = DataController.places[index]
        let center = CLLocationCoordinate2D(latitude: place.x, longitude: place.y)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.map.setRegion(region, animated: true)
        let array = DataController.places
        self.title = array[index].title
    }
    
    override func viewDidLoad() {
        
        map.delegate = self
        super.viewDidLoad()
        map.mapType = MKMapType.satellite
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
        map.showsUserLocation = false
    }
}

