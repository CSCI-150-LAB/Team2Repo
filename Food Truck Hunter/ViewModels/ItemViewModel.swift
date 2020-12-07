//
//  ItemViewModel.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/18/20.
//

import Foundation
import Firebase

class ItemViewModel: ObservableObject {
    @Published var item: FoodMenu = FoodMenu(title: "", price: 0,truck_id:-2)
    
    private var db = Firestore.firestore()
    
    func save(fname: String, Fprice:Float,id: Int ) {
        item.price = Fprice
        item.title = fname
        item.truck_id = id
        
        db.collection("foodM").addDocument(data: [
                "title": fname,
                "price": Fprice,
            "truck_id" : id
            ])
        
    }
    
}
