import Foundation
import Firebase

class CustomerAccount: ObservableObject {
    @Published var user: User = User(uid: "", email: "", displayName: "", first_name: "", id: 0, last_name: "", phone_number: "", type: "")
    let dispatchGroup = DispatchGroup()
    var userUID: String = ""
    var email: String = ""
    var displayName: String = ""
    
    private var didChange: Bool = false
    
    init(_ userUID: String, _ email: String, _ displayName: String) {
        self.userUID = userUID
        self.email = email
        self.displayName = displayName
        self.getUserData()
    }
    
    func getUserData() {
        self.fetchUserData() { (data) in
            if (data.count != 1) {
                switch data["type"] as! String {
                case "vendor":
                    self.user = User(
                        uid: self.userUID,
                        email: self.email,
                        displayName: self.displayName,
                        first_name: data["first_name"] as? String,
                        id: data["id"] as? Int,
                        last_name: data["last_name"] as? String,
                        phone_number: data["phone_number"] as? String,
                        profile_img: data["profile_img"] as? String,
                        truck_id: data["truck_id"] as? Int,
                        truck_name: data["truck_name"] as? String,
                        truck_ref: data["truck_ref"] as? String,
                        type: data["type"] as? String
                    )
                case "customer":
                    self.user = User(
                        uid: self.userUID,
                        email: self.email,
                        displayName: self.displayName,
                        favorites: data["favorites"] as? [[String:Any]],
                        first_name: data["first_name"] as? String,
                        id: data["id"] as? Int,
                        last_name: data["last_name"] as? String,
                        phone_number: data["phone_number"] as? String,
                        profile_img: data["profile_img"] as? String,
                        total_review: data["total_review"] as? Int,
                        status: data["status"] as? String,
                        type: data["type"] as? String
                    )
                default:
                    self.user = User(uid: "", email: "", displayName: "", first_name: "", id: 0, last_name: "", phone_number: "", type: "")
                }
            }
        }
    }

    func fetchUserData(completion: @escaping ([String: Any]) -> Void) {
        self.dispatchGroup.enter()
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(self.userUID)
        
        docRef.getDocument() { (document, error) in
            if let document = document, document.exists {
                self.dispatchGroup.leave()
                completion(document.data() ?? ["":""])
                
            } else {
                print("Document does not exist.")
                self.dispatchGroup.leave()
                completion(document?.data() ?? ["":""])
            }
        }
    }
    
    func getDidChange() -> Bool {
        return self.didChange
    }
    
    func toggleDidChange() {
        self.didChange.toggle()
    }
}
