import Foundation
import SwiftUI

struct LoginModel : Decodable {
    var email : String
    var password : String
    var emailHintLabel : String = ""
    var passwordHintLabel : String = ""
}
