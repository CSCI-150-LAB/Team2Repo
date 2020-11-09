import Foundation
import SwiftUI
import Combine

class User : ObservableObject {
    var uid: String
    var email: String?
    var displayName: String?
    let favorites: [AnyObject]
    let first_name: String?
    let id: Int?
    let last_name: String?
    let phone_number: String?
    let profile_img: String?
    let review_count: Int?
    let status: String?
    let type: String?

    init(uid: String, email: String?, displayName: String?, favorites: [AnyObject]?, first_name: String?, id: Int?, last_name: String?, phone_number: String?, profile_img: String?, review_count: Int?, status: String?, type: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.favorites = favorites ?? []
        self.first_name = first_name
        self.id = id
        self.last_name = last_name
        self.phone_number = phone_number
        self.profile_img = profile_img
        self.review_count = review_count
        self.status = status
        self.type = type
    }
}
