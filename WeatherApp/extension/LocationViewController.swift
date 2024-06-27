//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Ankit_Mac on 27/06/24.
//
import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the map view
        mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        // Set a specific coordinate (example: Apple Park)
        let coordinate = CLLocationCoordinate2D(latitude: 23.045265688648584, longitude: 72.50801636749965)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // Add a long press gesture recognizer to the map
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
    }

    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: - Google Maps Integration
    
    func openGoogleMaps(latitude: Double, longitude: Double) {
        if let url = URL(string: "comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "Google Maps Not Found", message: "Please install Google Maps to use this feature.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Gesture Recognizer
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        // Open Google Maps with the selected coordinate
        openGoogleMaps(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        // Optionally, you can add an annotation to the map as well
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        print("Selected location: \(coordinate.latitude), \(coordinate.longitude)")
    }
}
