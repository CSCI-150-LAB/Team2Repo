//
//  MenuViewModel.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/13/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class MenuViewModel: ObservableObject {
    @Published var items = [FoodMenu] ()
   // private var truckRefId: Int = 0;

    private var db = Firestore.firestore()
    
    func fetchData(truckref: Int) {
       // db.collection("foodM").addSnapshotListener { (QuerySnapshot, error) in
        db.collection("foodM").whereField("truck_id", isEqualTo: truckref).addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("No Food items")
                return
            }
            
          //  let documents = self.db.collection("foodM").whereField("truck_id", isEqualTo: self.truckRefId)
                        
            
            self.items = documents.compactMap { (queryDocumentSnapshot) -> FoodMenu? in
                return try? queryDocumentSnapshot.data(as: FoodMenu.self)
                
            }
        }
    }
    
}
