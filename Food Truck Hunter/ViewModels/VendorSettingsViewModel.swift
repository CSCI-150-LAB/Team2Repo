//
//  VendorSettingsViewModel.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 12/7/20.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import CoreLocation


class VendorSettingsViewModel: ObservableObject
{
    @Published var truck = Truck()
    var truckRef = ""
    @Published var truckName = "My Truck"
    var locationManager = LocationManager()
    var openState: Bool = false
    @Published var closingTime = Date()
    @Published var toggleValue: Bool = false {
        didSet {
            if openState != toggleValue {
                updateState()
            }
        }
    }

    let dispatchGroup = DispatchGroup()
    
//    func getTruck(truckDocID: String) {
//        self.fetchTruckData(truckDocID) { (data) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.truck = Truck(
//                    closing_hour: data["closing_hour"] as? String ?? "",
//                    cuisine: data["cuisine"] as? [String] ?? [""],
//                    email: data["email"] as? String ?? "",
//                    location: ["":0.0],
//                    menu_ref: data["menu_ref"] as? String ?? "",
//                    owner_name: data["owner_name"] as? String ?? "",
//                    owner_id: data["owner_id"] as? Int ?? 0,
//                    phone_number: data["phone_number"] as? String ?? "",
//                    rating: data["rating"] as? Float ?? 0.0,
//                    total_reviews: data["total_reviews"] as? Int ?? 0,
//                    truck_id: data["truck_id"] as? Int ?? 0,
//                    truck_name: data["truck_name"] as? String ?? ""
//                )
//                //self.isDoneLoading.toggle()
//            }
//        }
//    }
//    
//    func fetchTruckData(_ truckDocID: String, completion: @escaping ([String: Any]) -> Void) {
//        self.dispatchGroup.enter()
//        let db = Firestore.firestore()
//        let docRef = db.collection("Trucks").document(truckDocID)
//        
//        docRef.getDocument() { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
////                let data: [String: Any] = document.data() ?? ["":""]
////                print("self.truck = \(self.truck)")
//                self.dispatchGroup.leave()
//                completion(document.data() ?? ["":""])
//                
//            } else {
//                print("Document does not exist.")
//                self.dispatchGroup.leave()
//                completion(document?.data() ?? ["":""])
//            }
//        }
//    }
    
    func fetchTruck(truckDocID:String) {
        
        let db = Firestore.firestore()
        self.truckRef = truckDocID
   
        let docRef = db.collection("Trucks").document(truckDocID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let name = document.get("truck_name"){
                    self.truckName = name as! String
                }
                
                if let open = document.get("open_status"){
                    self.openState = open as! Bool
                    self.toggleValue = self.openState
                }
                
                if let closing = document.get("closing_hour"){
                    let ct = closing as! Timestamp
                    //self.closingTime = Date(timeIntervalSince1970: TimeInterval(ct.seconds))
                    print("fetch")
                    print(ct)
                }
                
               
            }
        }
        
        
        
    }
    
    
    func updateTruckName(truckName: String, uid: String){
        let db = Firestore.firestore()
        self.truckName = truckName
        db.collection("Trucks").document(uid).setData(["truck_name": truckName],merge:true)
        db.collection("Trucks").document(self.truckRef).setData(["truck_name": truckName],merge:true)
               
        }
    
    func updateState(){
        let db = Firestore.firestore()
        self.openState = self.toggleValue
        db.collection("Trucks").document(self.truckRef).setData(["open_status": self.openState],merge:true)
    }
    
   
    func updateLocation() {
        let db = Firestore.firestore()
        if let location = locationManager.lastLocation {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            let point = GeoPoint(latitude: lat, longitude: long)
            db.collection("Trucks").document(self.truckRef).setData(["location": point],merge:true)
            print("Location Updated")
        }
       
    }
    
  
    
   
}
