import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class UsersViewModel: ObservableObject {
    
    @Published private(set) var usr : UserModel
//    @Published private(set) var callBackModel : CallBackModel
    
    init(usr : UserModel) {
        self.usr = usr
    }
    
    func buttonisPressed() {

    }

    func createAccount(email: String, firstName: String, lastName: String, password: String, type: String) -> Bool {
        let db = Firestore.firestore()
        let dispatch = DispatchGroup()
        var successfulAccountCreate : Bool = false
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // An error occurred
            guard error == nil else {
    //            buttonDisable.toggle()
    //            isLoading.toggle()
    //            buttonLabel = "Create an account"
    //
    //            self.invalidEmailHintLabel = String(describing: error!.localizedDescription)
    //            print("Unsuccessfully created an account:\n\(String(describing: error?.localizedDescription))")
                return
            }
            
            // Successfully created account
            dispatch.enter()
            var ref: DocumentReference? = nil
            ref = db.collection("Users").addDocument(data: [
                "email" : email,
                "first_name" : firstName,
                "last_name" : lastName,
                "phone": "",
                "type" : type
            ]) {
                error in
                if let error = error {
                    print("Something happened: \(error)")
                }
                else {
                    successfulAccountCreate = true
                    print("Added document \(ref!.documentID)")
                }
            }
            
            dispatch.leave()
        }
        return successfulAccountCreate
    }

    func getUser(email: String) {
        let db = Firestore.firestore()
        let dispatch = DispatchGroup()
        
        dispatch.enter()
        db.collection("Users").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(String(describing: err))")
                }
                else {
                    for document in querySnapshot!.documents {
//                        self.usr.default_location = document.data()["default_location"] as! String
                        print("\(document.documentID) => \(String(describing: document.data()["first_name"]))")
                    }
                }
                    
            }
        dispatch.leave()
    }

//    func signIn(email: String, password: String) -> CallBackModel {
//        let id = ID()
//        callBackModel.id = Int(id.generate(alphabet: .numeric, size: 5))
//        if (!email.isEmpty && !password.isEmpty) {
//            if FormUtilities.validateEmail(email) {
//                callBackModel.value = ""
//                callBackModel.message = ""
//                self.invalidEmailHintLabel = ""
//
//                // MARK: Firebase Auth
//                Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
//                    // Unsuccessful
//                    guard error == nil else {
//                        print("Cannot sign in")
//                        self.invalidCredentialHintLabel = "Email or password is incorrect."
//                        return
//                    }
//
//                    // Successfully logged in
//                    // Reset all fields
//                    self.email = ""
//                    self.password = ""
//                    self.successful_login = 1
//                    self.invalidCredentialHintLabel = ""
//                    print("Successfully signed in")
//                })
//            }
//            else {
//                self.invalidCredentialHintLabel = ""
//                self.invalidEmailHintLabel = FormUtilities.validateEmailErrorMsg(email)
//            }
//        }
//        else {
//            self.invalidEmailHintLabel = FormUtilities.isEmptyErrorMsg(email, "email")
//            self.invalidCredentialHintLabel = FormUtilities.isEmptyErrorMsg(password, "password")
//        }
//        
//        var successfulLogin : Bool = false
//        
//        // MARK: Firebase Auth
//        Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
//
//            guard error == nil else {
//                return  // Unsuccessful login
//            }
//            
//            // Successfully logged in
//            successfulLogin = true
//        })
//        
//        return callBackModel
//    }
}
