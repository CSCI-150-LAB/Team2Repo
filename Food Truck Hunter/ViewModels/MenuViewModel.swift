//
//  MenuViewModel.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/13/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MenuViewModel: ObservableObject {
    @Published var items = [FoodMenu] ()
    
    private var db = Firestore.firestore()
    
//    func addItem(item: FoodMenu) {
//        do {
//            let _ = try db.collection("foodM").addDocument(from: item)
//        }
//        catch {
//            print(error)
//        }
//    }
    
    func fetchData() {
        db.collection("foodM").addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("No Food items")
                return
            }
            
            
            self.items = documents.compactMap { (queryDocumentSnapshot) -> FoodMenu? in
                return try? queryDocumentSnapshot.data(as: FoodMenu.self)
                
//                let data = queryDocumentSnapshot.data()
//
//                let title = data["title"] as? String ?? ""
//                let price = data["price"] as? Int ?? 0
//
//                return FoodMenu(title: title, price: price)
            }
        }
    }
    
}
