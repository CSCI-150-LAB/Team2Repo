import Foundation
import SwiftUI

struct VendorModel : Identifiable, Decodable {
    var business_license: String
    var email: String
    var first_name: String
    var id: Int
    var last_name: String
    var phone_number: String
    var profile_img: String
    var truck_id: Int
    var truck_name: String
    var type: String
}
