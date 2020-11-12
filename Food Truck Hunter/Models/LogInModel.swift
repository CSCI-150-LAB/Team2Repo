import Foundation
import SwiftUI

// Delete this file

struct LoginModel : Decodable {
    var email : String
    var password : String
    var emailHintLabel : String = ""
    var passwordHintLabel : String = ""
}
