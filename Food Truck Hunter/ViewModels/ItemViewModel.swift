//
//  ItemViewModel.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/18/20.
//

import Foundation
import Firebase

class ItemViewModel: ObservableObject {
    
    @Published var item: FoodMenu = FoodMenu(title: "", price: 0)
    
    private var db = Firestore.firestore()
    
    func addItem(item: FoodMenu) {
            do {
                let _ = try db.collection("foodM").addDocument(from: item)
            }
            catch {
                print(error)
            }
        }
    
    func save() {
        addItem(item: item)
    }
    
}
