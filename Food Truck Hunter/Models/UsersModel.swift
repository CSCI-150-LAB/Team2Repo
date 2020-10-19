import Foundation
import SwiftUI

struct UserModel : Identifiable, Decodable {
    let email : String
    let favorites : [String]
    let first_name : String
    let id : Int
    let last_name : String
    let phone_number : String
    let profile_img : String
    let review_count : Int
    let status : String
    let type : String
    
//    init(default_location: String!, email: String!, first_name: String!, id: Int!, last_name: String!, phone_number: String!, type: String!) {
//        self.default_location = default_location
//        self.email = email
//        self.first_name = first_name
//        self.id = id
//        self.last_name = last_name
//        self.phone_number = phone_number
//        self.type = type
//    }
}
