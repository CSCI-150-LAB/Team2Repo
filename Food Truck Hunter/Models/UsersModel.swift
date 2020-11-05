import Foundation
import SwiftUI

struct UserModel : Identifiable, Decodable {
    let email : String?
    let favorites : [FavoriteVendors]
    let first_name : String
    let id : Int
    let last_name : String
    let phone_number : String
    let profile_img : String
    let review_count : Int
    let status : String
    let type : String
    
//    init(email: String!, first_name: String!, id: Int!, last_name: String!, phone_number: String!, type: String!) {
//        self.email = email
//        self.first_name = first_name
//        self.id = id
//        self.last_name = last_name
//        self.phone_number = phone_number
//        self.type = type
//    }
}
