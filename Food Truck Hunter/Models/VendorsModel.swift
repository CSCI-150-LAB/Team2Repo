import Foundation
import SwiftUI

struct VendorModel : Identifiable, Decodable {
    let business_license : String
    let cuisine : [String]
    let email : String
    let hours : [String]
    let id : Int
    let locations : [[Float]]
    let name : String
    let overall_rating : Int
    let owner : String
    let owner_id : Int
    let phone : String
    let total_reviews : String
}
