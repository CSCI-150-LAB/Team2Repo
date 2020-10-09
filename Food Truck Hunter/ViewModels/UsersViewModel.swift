import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn

final class UsersViewModel: ObservableObject {
    
//    struct User: Identifiable, Codable {
//        var default_location: String?
//        var email: String?
//        var firstName: String?
//        var id: Int?
//        var lastName: String?
//        var phoneNumber: Int?
//        var type: String?
//
//        init(default_location: String?, email: String?, first_name: String?, id: Int?, last_name: String?, phone_number: Int?, type: String?) {
//            self.default_location = default_location
//            self.email = email
//            self.firstName = first_name
//            self.id = id
//            self.lastName = last_name
//            self.phoneNumber = phone_number
//            self.type = type
//        }
//    }
    let usr : User
    @Published var msg = "Initialized"
    @Published var users = [ User ]()
    
    init(usr : User) {
        self.usr = usr
    }
    
    func getData() {
        let db = Firestore.firestore()
        let dispatch = DispatchGroup()
        
        dispatch.enter()
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.users.append(User(default_location: (document.data()["default_location"] as! String), email: (document.data()["email"] as! String), first_name: (document.data()["first_name"] as! String), id: (document.data()["id"] as? Int), last_name: (document.data()["last_name"] as! String), phone_number: (document.data()["phone_number"] as! String), type: (document.data()["type"] as! String)))
                    print("user: \(self.users.count)")
                }
            }
            dispatch.leave()
            self.msg = ""
        }
        dispatch.notify(queue: .main, execute: {
            print("number of users: \(self.users.count)")
        })
    }
    
    func createUser() {
        var defaultLocation : String = ""
        var email : String = ""
        var firstName : String = ""
        var lastName : String = ""
        var type : String = ""
        
        defaultLocation = "Fresno, CA"
        email = "vangs07@fresnostate.edu"
        firstName = "Sue"
        lastName = "Vang"
        type = "user"
        
        let db = Firestore.firestore()
        let dispatch = DispatchGroup()
        
        dispatch.enter()
        
        var ref: DocumentReference? = nil
        ref = db.collection("Users").addDocument(data: [
            "default_location" : defaultLocation,
            "first_name" : firstName,
            "last_name" : lastName,
            "email" : email,
            "type" : type
        ]) {
            error in
            if let error = error {
                print("Something happened: \(error)")
            }
            else {
                print("Added document \(ref!.documentID)")
            }
        }
        
        dispatch.leave()
    }
}
