import SwiftUI
import Foundation
import CoreLocation

struct FavoriteVendors: Hashable, Codable, Identifiable {
    var id : Int
    var name : String
    
    init?(data : [String: Any]) {
        guard let id = data["truck_id"] as? Int,
              let name = data["truck_name"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
}
