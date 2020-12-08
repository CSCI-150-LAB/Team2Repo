import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class FavoriteListViewModel: ObservableObject {
    @Published var truck = Truck()
    let dispatchGroup = DispatchGroup()
    var cancallable: Cancellable?   // To be remove
    var isDoneLoading: Bool = false
    
    func getTruck(truckDocID: String) {
        self.fetchTruckData(truckDocID) { (data) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.truck = Truck(
                    closing_hour: data["closing_hour"] as? String ?? "",
                    cuisine: data["cuisine"] as? [String] ?? [""],
                    email: data["email"] as? String ?? "",
                    location: data["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0),
                    menu_ref: data["menu_ref"] as? String ?? "",
                    open_status: data["open_status"] as? Bool ?? false,
                    owner_name: data["owner_name"] as? String ?? "",
                    owner_id: data["owner_id"] as? Int ?? 0,
                    phone_number: data["phone_number"] as? String ?? "",
                    rating: data["rating"] as? Float ?? 0.0,
                    total_reviews: data["total_reviews"] as? Int ?? 0,
                    truck_id: data["truck_id"] as? Int ?? 0,
                    truck_name: data["truck_name"] as? String ?? ""
                    
                )
                self.isDoneLoading.toggle()
            }
        }
    }
    
    func fetchTruckData(_ truckDocID: String, completion: @escaping ([String: Any]) -> Void) {
        self.dispatchGroup.enter()
        let db = Firestore.firestore()
        let docRef = db.collection("Trucks").document(truckDocID)
        
        docRef.getDocument() { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
//                let data: [String: Any] = document.data() ?? ["":""]
//                print("self.truck = \(self.truck)")
                self.dispatchGroup.leave()
                completion(document.data() ?? ["":""])
                
            } else {
                print("Document does not exist.")
                self.dispatchGroup.leave()
                completion(document?.data() ?? ["":""])
            }
        }
    }
    
    // Remove function below
    func doNotLoad() {
        if self.cancallable != nil  {
            self.cancallable!.cancel()
        } else {
            print("First time loading this view.")
        }
    }
}
