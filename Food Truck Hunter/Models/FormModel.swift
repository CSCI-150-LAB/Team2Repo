import Foundation
import SwiftUI

struct FormModel : Decodable {
    var firstName : String?
    var lastName : String?
    var email : String
    var password : String
    var type : String?
    var retypedPassword : String?
    var emailHintLabel : String = ""
    var passwordHintLabel : String = ""
    var passwordRetypedHintLabel : String = ""
    
    init(firstName : String = "", lastName : String = "", email : String, password : String, type : String = "", retypedPassword : String = "", emailHintLabel : String = "", passwordHintLabel : String = "", passwordRetypedHintLabel : String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.type = type
        self.retypedPassword = retypedPassword
        self.emailHintLabel = emailHintLabel
        self.passwordHintLabel = passwordHintLabel
        self.passwordRetypedHintLabel = passwordRetypedHintLabel
    }
}
