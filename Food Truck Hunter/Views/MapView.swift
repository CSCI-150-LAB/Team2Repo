//
//  MapView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 10/20/20.
//

import SwiftUI
import MapKit
import FirebaseFirestore
struct MapView: UIViewRepresentable {
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    Firestore.firestore().collection("Trucks").getDocuments { (snapshot, error) in
        if let snapshot = snapshot {
            for document in snapshot.documents {
                if let geopoints = document.get("location") {
                    let point = geopoints as! GeoPoint
                    let lat = point.latitude
                    let lon = point.longitude
                    let cllPoint = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    
                    let annotation = MKPointAnnotation()
                    if let truckName = document.get("name"){
                        let name = truckName as! String
                        annotation.title = name
                    }
                    else {
                        annotation.title = "Truck"
                    }
                    annotation.coordinate = cllPoint
                    mapView.addAnnotation(annotation)
                }
                                
                        
                    
            }
        }
    }
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
    
}
