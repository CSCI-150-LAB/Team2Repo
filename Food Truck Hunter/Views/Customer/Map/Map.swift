//
//  MapView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 10/20/20.
//

import SwiftUI
import MapKit
import FirebaseFirestore

struct Map: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [TruckPin]
    @Binding var annotationTapAction: Bool
    @Binding var selectedPin: TruckPin?
    var locationManager = CLLocationManager()
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView() // frame: UIScreen.main.bounds
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
        if annotations.count != view.annotations.count {
                view.removeAnnotations(view.annotations)
                view.addAnnotations(annotations)
            }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: Map

        init(_ parent: Map) {
            self.parent = parent
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if !(annotation is TruckPin){
                return nil
            }
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "reuseIdentifier")

            if view == nil {
                view = MKMarkerAnnotationView(annotation: nil, reuseIdentifier: "reuseIdentifier")
            }
            //let pinImage = UIImage("map-icon").resizable().frame(width: 32.0, height: 32.0)
            //view!.image = pinImage
            view?.annotation = annotation
            view?.displayPriority = .required
            return view
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let pin = view.annotation as? TruckPin else {
                return
            }
            
            mapView.showsUserLocation = false
            mapView.centerCoordinate = pin.coordinate
            print("User selected annotation with title: \(pin.title ?? "unknown")")
            print(pin.truckID)
            parent.annotationTapAction = true
            parent.selectedPin = pin
            
        }
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            guard let pin = view.annotation as? TruckPin else {
                return
            }
            print("User deselected annotation with title: \(pin.title ?? "unknown")")
            parent.annotationTapAction = false
            parent.selectedPin = nil
            mapView.showsUserLocation = true
        }
        
        
    }
}



class TruckPin: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let action: (() -> Void)?
    let truckID: String
    init(coordinate: CLLocationCoordinate2D,
         title: String? = nil,
         subtitle: String? = nil,
         action: (() -> Void)? = nil, truckID: String = "Truck") {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.action = action
        self.truckID = truckID
    }

}

