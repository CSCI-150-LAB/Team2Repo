import Foundation
import SwiftUI

struct CallBackModel {
    var id : Int?
    var value : Any
    var message : String
    
    init(id: Int, value: Any, message : String) {
        self.id = id
        self.value = value
        self.message = message
    }
}
