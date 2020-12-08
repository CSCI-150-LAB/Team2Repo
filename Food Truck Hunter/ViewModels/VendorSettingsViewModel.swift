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
    
    
    @Published var closingTime = Date() {
        didSet{
            updateClosingTime()
        }
    }
    @Published var toggleValue: Bool = false {
        didSet {
            if truck.open_status != toggleValue {
                updateState()
            }
        }
    }
    
   
    
    let dispatchGroup = DispatchGroup()
    var isDoneLoading: Bool = false
    
    func getTruck(truckDocID: String) {
        self.fetchTruckData(truckDocID) { (data) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.truck = Truck(
                    closing_hour: data["closing_hour"] as? String ?? "",
                    cuisine: data["cuisine"] as? [String] ?? [""],
                    email: data["email"] as? String ?? "",
                    location: data["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0),
                    menu_ref: data["menu_ref"] as? String ?? "",
                    open_status: data["open_status"] as? Bool ?? false,
                    owner_name: data["owner_name"] as? String ?? "",
                    owner_id: data["owner_id"] as? Int ?? 0,
                    phone_number: data["phone_number"] as? String ?? "",
                    rating: data["rating"] as? Float ?? 0.0,
                    total_reviews: data["total_reviews"] as? Int ?? 0,
                    truck_id: data["truck_id"] as? Int ?? 0,
                    truck_name: data["truck_name"] as? String ?? ""
                )
                self.setTime()
                print(self.closingTime)
                self.toggleValue = self.truck.open_status
                self.isDoneLoading.toggle()
            }
        }
    }
    
    
    func fetchTruckData(_ truckDocID: String, completion: @escaping ([String: Any]) -> Void) {
        self.dispatchGroup.enter()
        self.truckRef = truckDocID
        let db = Firestore.firestore()
        let docRef = db.collection("Trucks").document(truckDocID)

        docRef.getDocument() { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
//                let data: [String: Any] = document.data() ?? ["":""]
//                print("self.truck = \(self.truck)")
                self.dispatchGroup.leave()
                completion(document.data() ?? ["":""])

            } else {
                print("Document does not exist.")
                self.dispatchGroup.leave()
                completion(document?.data() ?? ["":""])
            }
        }
    }

    func setTime() {
        
        var truckClosingHour = self.truck.closing_hour
        
        
        let indexItem = truckClosingHour.index(truckClosingHour.startIndex, offsetBy: 2)
        truckClosingHour.insert(":", at: indexItem)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        
        self.closingTime = dateFormatter.date(from: truckClosingHour) ?? Date()
    }
    func updateTruckName(truckName: String, uid: String){
        let db = Firestore.firestore()
        self.truck.truck_name = truckName
        db.collection("Trucks").document(uid).setData(["truck_name": truckName],merge:true)
        db.collection("Trucks").document(self.truckRef).setData(["truck_name": truckName],merge:true)
               
        }
    
    func updateState(){
        let db = Firestore.firestore()
        self.truck.open_status = self.toggleValue
        db.collection("Trucks").document(self.truckRef).setData(["open_status": self.truck.open_status],merge:true)
    }
    
   
    func updateLocation() {
        let db = Firestore.firestore()
        if let location = locationManager.lastLocation {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            let point = GeoPoint(latitude: lat, longitude: long)
            self.truck.location = point
            db.collection("Trucks").document(self.truckRef).setData(["location": point],merge:true)
            print("Location Updated")
        }
       
    }
    
    func updateClosingTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        var truckClosingHour = self.truck.closing_hour
        
        let indexItem = truckClosingHour.index(truckClosingHour.startIndex, offsetBy: 2)
        truckClosingHour.insert(":", at: indexItem)
        
        var newTime = dateFormatter.string(from: self.closingTime)
        
        if newTime != truckClosingHour{
            let db = Firestore.firestore()
            let nindexItem = newTime.index(newTime.startIndex, offsetBy: 2)
            newTime.remove(at: nindexItem)
            self.truck.closing_hour = newTime
            db.collection("Trucks").document(self.truckRef).setData(["closing_hour": newTime],merge:true)
            
        }
        
        else{
            print("time same")
        }
    }
    
   
}
