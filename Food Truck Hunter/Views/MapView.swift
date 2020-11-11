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
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
//    var locationManager = CLLocationManager()
    
//    func setupManager() {
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
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
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // this is our unique identifier for view reuse
               let identifier = "Placemark"

               // attempt to find a cell we can recycle
               var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

               if annotationView == nil {
                   // we didn't find one; make a new one
                   annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

                   // allow this to show pop up information
                   annotationView?.canShowCallout = true

                   // attach an information button to the view
                   annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               } else {
                   // we have a view to reuse, so give it the new annotation
                   annotationView?.annotation = annotation
               }

               // whether it's a new view or a recycled one, send it back
               return annotationView
        }
    }
}




// struct MapView: UIViewRepresentable {
//    var locationManager = CLLocationManager()
//    var annotations = [MKPointAnnotation] ()
//    func setupManager() {
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//    }
//
//    func makeUIView(context: Context) -> MKMapView {
//        setupManager()
//        let mapView = MKMapView(frame: UIScreen.main.bounds)
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
//        return mapView
//    }
//
//    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
//        {
//            if let annotationTitle = view.annotation?.title
//            {
//                print("User tapped on annotation with title: \(annotationTitle!)")
//            }
//        }
//        
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        print("Update")
//        uiView.removeAnnotations(uiView.annotations)
//        
//      }
//    
//}
