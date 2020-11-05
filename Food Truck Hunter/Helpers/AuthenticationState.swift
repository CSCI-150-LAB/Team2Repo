import SwiftUI
import Firebase
import Combine

class AuthenticationState: ObservableObject {
    var didChange = PassthroughSubject<AuthenticationState, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    let dispatch = DispatchGroup()
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user) \(auth).")
                var userData: [String: Any] = ["Empty": "Empty"]
                self.fetchUser { (data) in          // Check whether if it's a customer or vendor signing in, do a switch statement
                    userData = data
                    self.session = User(
                        uid: user.uid,
                        email: user.email,
                        displayName: user.displayName,
                        favorites: userData["favorites"] as? [AnyObject],
                        first_name: userData["first_name"] as? String,
                        id: userData["id"] as? Int,
                        last_name: userData["last_name"] as? String,
                        phone_number: userData["phone_number"] as? String,
                        profile_img: userData["profile_img"] as? String,
                        review_count: userData["review_count"] as? Int,
                        status: userData["status"] as? String,
                        type: userData["type"] as? String
                    )
                }
            } else {
                self.session = nil
            }
        }
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func fetchUser(completion: @escaping ([String: Any]) -> Void) {
        let db = Firestore.firestore()
        var data: [String: Any] = ["": 0]

        db.collection("Users").whereField("id", isEqualTo: 15004034).getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            else {
                DispatchQueue.main.async {
                    data = querySnapshot!.documents[0].data()
                    completion(data)
                }
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
