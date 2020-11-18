import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class UsersViewModel: ObservableObject {
    @Published private var userModel : User
    private let db = Firestore.firestore()
    private let dispatch = DispatchGroup()
    
    public var userEmail : String
    
    init(userModel: User, userEmail : String = "") {
        self.userModel = userModel
        self.userEmail = userEmail
    }
    
    func getEmail() -> String {
        return self.userEmail
    }
    
    func getUserInfo() -> User {
        return self.userModel
    }
    
    func getUserInfoFromFirestore() {
        self.db.collection("Users").whereField("email", isEqualTo: self.getEmail()).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }

        }
    }
    
    func setUserEmail(_ email : String) {
        self.userEmail = email
    }
    
    func setUserInfo() {
        
    }
    
    
}
