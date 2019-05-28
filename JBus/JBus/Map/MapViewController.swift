//
//  MapViewController.swift
//  JBus
//
//  Created by Jizhen Wang on 5/23/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate  {
    
    // You don't need to modify the default init(nibName:bundle:) method.
    let locationManager = CLLocationManager()
    var lastLocation = CLLocation.init()
    let pinky = brains()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        startReceivingLocationChanges()
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        print("location", lastLocation.coordinate)
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        let coder = GMSGeocoder.init()
        coder.reverseGeocodeCoordinate(lastLocation.coordinate) { response , error in
            marker.title=response?.firstResult()?.locality
        }
        //
        //        marker.snippet = "test"
        marker.map = mapView
        for shuttle in pinky.getShuttles(){
            let stops = pinky.getStops(shuttle: shuttle);
            for stop in stops{
                print("123")
                let sMarker = GMSMarker();
                let latitude: CLLocationDegrees = stop.lat
                let longitude: CLLocationDegrees = stop.lon
                sMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
                sMarker.map = mapView
            }
        }
        
        
    }
    
    func startReceivingLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        //        print(locations)
        if (lastLocation != locations.last){
            lastLocation = locations.last!
            loadView()
            
        }
        return
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopUpdatingLocation()
            return
        }
        // Notify the user of any errors.
    }
    
}
