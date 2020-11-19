//
//  MapView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 11/18/20.
//

import SwiftUI
import FirebaseFirestore
import MapKit

struct MapView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [TruckPin]()
    @State var mapMenu_shown = false
    @State var selectedPin: TruckPin?
    
    
    func getLocations() {
        Firestore.firestore().collection("Trucks").getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    if let geopoints = document.get("location") {
                        let point = geopoints as! GeoPoint
                       
                        let lat = point.latitude
                        let lon = point.longitude
                        let cllPoint = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        var name = "Truck"
                        if let truckName = document.get("name"){
                            name = truckName as! String
                            
                        }
                        
                        let annotation = TruckPin(coordinate: cllPoint, title: name, truckID: document.documentID)
                        locations.append(annotation)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Map(centerCoordinate: $centerCoordinate, annotations: locations, annotationTapAction: $mapMenu_shown, selectedPin: $selectedPin)
                        .ignoresSafeArea()
                        .onAppear(perform: getLocations)
                    DrawerView(isShown: $mapMenu_shown){
                        AnnotationMenuView(pin: $selectedPin)
                    }
            }
        }
    }
}

