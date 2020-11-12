import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

struct TruckModel: Identifiable {
    var closing_hour: String
    var cuisine: [String]
    var email: String
    var id: Int
    var location: GeoPoint
    var name: String
    var owner_fullname: String
    var owner_id: Int
    var phone_number: String
    var rating: Float
    var total_reviews: Int
    var menu_ref: String
}
