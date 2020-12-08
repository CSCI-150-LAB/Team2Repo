import SwiftUI
import Firebase
import Combine

class AuthenticationState: ObservableObject {
    var didChange = PassthroughSubject<AuthenticationState, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    let dispatch = DispatchGroup()
    static var userData: [String: Any]?

    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user) \(auth). Document id: \(user.uid)")
                
                self.fetchUser(documentUID: user.uid) { (data) in          // Check whether if it's a customer or vendor signing in, do a switch statement
                    if (data["id"] as! Int > 0) {
                        switch data["type"] as! String {
                        case "vendor":
                            self.session = User(
                                uid: user.uid,
                                email: user.email,
                                displayName: user.displayName,
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
                            self.session = User(
                                uid: user.uid,
                                email: user.email,
                                displayName: user.displayName,
                                favorites: data["favorites"] as? [AnyObject],
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
                            self.session = nil
                        }

                    }
                    
                    // When user signs up, add the corresponding documents to each collections Trucks, Users, Menus, Reviews
                    else {
                        if (AuthenticationState.userData != nil) {
                            let db = Firestore.firestore()
                            if (AuthenticationState.userData?["type"] as! String == "vendor") {
                                var menuRef: DocumentReference? = nil
                                var truckRef: DocumentReference? = nil
                                let userFireBaseUID = user.uid
                                
                                // Create vendor's menu in Menu collection
                                // menuRef = db.collection().document().collection("items")
                                menuRef = db.collection("Menus").addDocument(data: [
                                    "menu": [], // Array of array. Each food item will look like -> ["img", "name", "price"]
                                    "truck_id": AuthenticationState.userData?["truck_id"] as! Int,
                                    "truck_name": AuthenticationState.userData?["truck_name"] as! String
                                ]) { error in
                                    if let error = error {
                                        print("Error:\n\(error)")
                                    } else {
                                        print("Menu document added...\(String(describing: menuRef?.documentID))")
                                    }
                                }
                                
                                // Create truck document in Trucks collection
                                truckRef = db.collection("Trucks").addDocument(data: [
                                    "closing_hour": Timestamp(),
                                    "cuisine": [],
                                    "email": (AuthenticationState.userData?["email"] as! String).lowercased(),
                                    "truck_id": AuthenticationState.userData?["truck_id"] as! Int,
                                    "location" : GeoPoint(latitude: 0,longitude: 0),  // Insert and default GeoPoint (0,0)
                                    "open_status" : false,
                                    "menu_ref": menuRef!.documentID,
                                    "truck_name" : (AuthenticationState.userData?["truck_name"] as! String).lowercased(),
                                    "owner_id" : AuthenticationState.userData?["id"] as! Int,
                                    "owner_name" : "\((AuthenticationState.userData?["first_name"] as! String).lowercased()) \((AuthenticationState.userData?["last_name"] as! String).lowercased())",
                                    "phone_number": AuthenticationState.userData?["phone_number"] as! String,
                                    "rating" : 0,
                                    "total_reviews" : 0
                                ]) {
                                    error in
                                    if let error = error {
                                        print("Error:\n\(error)")
                                    } else {
                                        print("\(AuthenticationState.userData?["truck_name"] as! String) added. Document reference is \(truckRef!.documentID).")
                                    }
                                }
                                
                                // Create vendor in Users collection
                                db.collection("Users").document(userFireBaseUID).setData([
                                    "business_license": "",
                                    "email": (AuthenticationState.userData?["email"] as! String).lowercased(),
                                    "first_name": (AuthenticationState.userData?["first_name"] as! String).lowercased(),
                                    "id": AuthenticationState.userData?["id"] as! Int,
                                    "last_name" : (AuthenticationState.userData?["last_name"] as! String).lowercased(),
                                    "phone_number": AuthenticationState.userData?["phone_number"] as! String,
                                    "truck_id": AuthenticationState.userData?["truck_id"] as! Int,
                                    "truck_name": (AuthenticationState.userData?["truck_name"] as! String).lowercased(),
                                    "truck_ref": truckRef!.documentID,
                                    "profile_img": "",
                                    "type" : AuthenticationState.userData?["type"] as! String
                                ])
                                
                                // Set vendor to session
                                self.session = User(
                                    uid: user.uid,
                                    email: user.email,
                                    displayName: user.displayName,
                                    first_name: (AuthenticationState.userData?["first_name"] as? String),
                                    id: (AuthenticationState.userData?["id"] as! Int),
                                    last_name: (AuthenticationState.userData?["last_name"] as! String),
                                    phone_number: (AuthenticationState.userData?["phone_number"] as! String),
                                    truck_id: (AuthenticationState.userData?["truck_id"] as! Int),
                                    truck_name: (AuthenticationState.userData?["truck_name"] as! String),
                                    truck_ref: truckRef!.documentID,
                                    type: (AuthenticationState.userData?["type"] as! String)
                                )
                            }
                            
                            // Add customer to firestore database - Working
                            if (AuthenticationState.userData?["type"] as! String == "customer") {
                                let userFireBaseUID = user.uid
                                
                                db.collection("Users").document(userFireBaseUID).setData([
                                    "id" : AuthenticationState.userData?["id"] as! Int,
                                    "email" : (AuthenticationState.userData?["email"] as! String).lowercased(),
                                    "favorites": [],
                                    "first_name" : (AuthenticationState.userData?["first_name"] as! String).lowercased(),
                                    "last_name" : (AuthenticationState.userData?["last_name"] as! String).lowercased(),
                                    "phone_number": "",
                                    "profile_img": "",
                                    "total_review": 0,
                                    "status": "basic",
                                    "type" : AuthenticationState.userData?["type"] as! String
                                ])
                                
                                
                                // Set costumer to session
                                self.session = User(
                                    uid: user.uid,
                                    email: user.email,
                                    displayName: user.displayName,
                                    favorites: [],
                                    first_name: (AuthenticationState.userData?["first_name"] as? String),
                                    id: (AuthenticationState.userData?["id"] as! Int),
                                    last_name: (AuthenticationState.userData?["last_name"] as! String),
                                    phone_number: "",
                                    profile_img: "",
                                    total_review: 0,
                                    status: "basic",
                                    type: (AuthenticationState.userData?["type"] as! String)
                                )
                            }
                        }
                    }

                }
            } else {
                self.session = nil
            }
            
        }
    }
    
    func signUp(email: String, password: String, userInfo: [String: Any], handler: @escaping AuthDataResultCallback) {
        AuthenticationState.userData = userInfo
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func fetchUser(documentUID: String, completion: @escaping ([String: Any]) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(documentUID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                completion(document.data() ?? ["": ""])
            } else {
                print("Document does not exist.")
                completion(["id":0])
            }
        }
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
