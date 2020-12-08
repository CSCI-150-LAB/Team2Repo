import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class FavoriteListViewModel: ObservableObject {
    @Published var truck = Truck()
    let dispatchGroup = DispatchGroup()
    var cancallable: Cancellable?   // To be remove
    var isDoneLoading: Bool = false
    var  isUsersFavorite = false
    var uid = ""
    var truckRef = ""
    var favorites:[[String: Any]] = []
    @Published var toggleValue: Bool = false {
        didSet {
            if toggleValue != isUsersFavorite{
                updateFav()
            }
        }
    }
    
    
    func getTruck(truckDocID: String) {
        self.truckRef = truckDocID
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
                print(self.truck.truck_name)
                self.isDoneLoading.toggle()
            }
        }
    }
    
    
    func fetchTruckData(_ truckDocID: String, completion: @escaping ([String: Any]) -> Void) {
        self.dispatchGroup.enter()
        let db = Firestore.firestore()
        let docRef = db.collection("Trucks").document(truckDocID)
        print(truckDocID)
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
    
    func fetchFav(uid: String, truckDocID: String) {
        
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(uid)
        self.uid = uid
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let favorites = document.get("favorites"){
                    let favs = favorites as! [[String:Any]]
                    self.favorites = favs
                    for fav in favs{
                        
                        if let truckRef = fav["truck_ref"]{
                            if truckRef as! String == truckDocID {
                                self.isUsersFavorite = true
                                self.toggleValue = self.isUsersFavorite
                            }
                            
                        }
                    }
                }
            }
            else {
                print("Document does not exist")
            }
        }
        
    }
    
    func updateFav(){
        let db = Firestore.firestore()
        if !self.toggleValue {
            
            for i in 0...(self.favorites.count-1){
              
                
                if self.favorites[i]["truck_ref"] as! String == self.truckRef{
                  
                   let indexItem = self.favorites.index(self.favorites.startIndex, offsetBy: i)
                    self.favorites.remove(at: indexItem)
                    print(self.favorites)
                    break
                }
            }
        }
        else {
            let newVal: [String:Any] = ["truck_id": self.truck.truck_id, "truck_name" : self.truck.truck_name, "truck_ref" : self.truckRef]
            self.favorites.append(newVal)
        }
        
        db.collection("Users").document(self.uid).setData(["favorites": self.favorites],merge:true)
        self.isUsersFavorite = self.toggleValue
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
