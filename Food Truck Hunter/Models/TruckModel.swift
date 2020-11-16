import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

struct Truck: Decodable {
    var closing_hour: String = ""
    var cuisine: [String] = [""]
    var email: String = ""
    var location: [String: Double] = ["":0.0]
    var menu_ref: String = ""
    var owner_name: String = ""
    var owner_id: Int = 0
    var phone_number: String = ""
    var rating: Float = 0.0
    var total_reviews: Int = 0
    var truck_id: Int = 0
    var truck_name: String = ""
    
//    init(
//        closing_hour: String? = "",
//        cuisine: [String]? = [],
//        email: String?  = "",
//        location: [String: Double]? = ["":0.0],
//        menu_ref: String? = "",
//        owner_name: String? = "",
//        owner_id: Int? = 0,
//        phone_number: String = "",
//        rating: Float = 0.0,
//        total_reviews: Int = 0,
//        truck_id: Int = 0,
//        truck_name: String = ""
//    ) {
//        self.closing_hour = closing_hour
//        self.cuisine = cuisine
//        self.email = email
//        self.location = location
//        self.menu_ref = menu_ref
//        self.owner_name = owner_name
//        self.owner_id = owner_id
//        self.truck_id = truck_id
//        self.truck_name = truck_name
//        self.phone_number = phone_number
//        self.rating = rating
//        self.total_reviews = total_reviews
//    }
}



