import Foundation
import SwiftUI

struct FormModel : Decodable {
    var firstName : String?
    var lastName : String?
    var vendorName : String?
    var phoneNumber : String?
    var email : String?
    var password : String?
    var type : String?
    var retypedPassword : String?
    var firstNameHintLabel : String = ""
    var lastNameHintLabel : String = ""
    var truckNameHintLabel : String = ""
    var phoneHintLabel : String = ""
    var emailHintLabel : String = ""
    var passwordHintLabel : String = ""
    var passwordRetypedHintLabel : String = ""
    
    init(firstName : String = "", lastName : String = "", vendorName : String = "", phoneNumber : String = "", email : String = "", password : String = "", type : String = "", retypedPassword : String = "", firstNameHintLabel : String = "", lastNameHintLabel : String = "", truckNameHintLabel : String = "", phoneHintLabel : String = "", emailHintLabel : String = "", passwordHintLabel : String = "", passwordRetypedHintLabel : String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.vendorName = vendorName
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.type = type
        self.retypedPassword = retypedPassword
        self.firstNameHintLabel = firstNameHintLabel
        self.lastNameHintLabel = lastNameHintLabel
        self.truckNameHintLabel = truckNameHintLabel
        self.phoneHintLabel = phoneHintLabel
        self.emailHintLabel = emailHintLabel
        self.passwordHintLabel = passwordHintLabel
        self.passwordRetypedHintLabel = passwordRetypedHintLabel
    }
}
