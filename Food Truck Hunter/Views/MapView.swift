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
    @Binding var annotationTapAction: Bool
    
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
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotationTitle = view.annotation?.title
                    {
                        print("User selected annotation with title: \(annotationTitle!)")
                        parent.annotationTapAction.toggle()
                    }
        
        }
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            if let annotationTitle = view.annotation?.title
                {
                    print("User deselected annotation with title: \(annotationTitle!)")
                    parent.annotationTapAction.toggle()
                }
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
