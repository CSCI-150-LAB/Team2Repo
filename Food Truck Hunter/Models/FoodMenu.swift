//
//  FoodMenu.swift
//  Food Truck Hunter
//
//  Created by Oleksandr Babich on 11/13/20.
//

import Foundation
import FirebaseFirestoreSwift

struct FoodMenu: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var price: Float
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
    }
}
