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

class VendorSettingsViewModel: ObservableObject
{
    var truckRef = ""
    @Published var truckName = "My Truck"
    
    var openState: Bool = false
    @Published var toggleValue: Bool = false {
        didSet {
            if openState != toggleValue {
                updateState()
            }
        }
    }

    
    func fetchTruck(truckDocID:String){
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
                }
            }
        }
        self.toggleValue = openState
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
    
   
}
