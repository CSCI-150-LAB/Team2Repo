import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class SignInViewModel: AuthenticationState {
    
    @Published private var formModel: FormModel
    
    public var email: String
    public var password: String
    
    init(formModel: FormModel, email: String = "", password: String = "") {
        self.formModel = formModel
        self.email = email
        self.password = password
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getEmailHintLabel() -> String {
        return self.formModel.emailHintLabel
    }
    
    func getPasswordHintLabel() -> String {
        return self.formModel.passwordHintLabel
    }
    
    func setEmail(_ email: String) {
        self.formModel.email = email
    }
    
    func setPassword(_ password: String) {
        self.formModel.password = password
    }
    
    func setEmailHintLabel(_ message: String) {
        self.formModel.emailHintLabel = message
    }
    
    func setPasswordHintLabel(_ message: String) {
        self.formModel.passwordHintLabel = message
    }
    
//    func fetchUser() {
//        let db = Firestore.firestore()
//        db.collection("Users").whereField("id", isEqualTo: 15004034).getDocuments() {(querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            }
//            else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//    }
    
//    func logIn() {
//
//        if validateInputFields() {
//            Auth.auth().signIn(withEmail: self.getEmail(), password: self.getPassword(), completion: {result, error in
//                // Unsuccessful
//                guard error == nil else {
//                    print("Cannot sign in")
//                    self.setPasswordHintLabel("Email or password is incorrect.")
//                    return
//                }
//
//                // Successfully logged in
////                self.setDidSignIn()
//                self.setPasswordHintLabel("")
//                self.resetForm()
//                print("Successfully signed in")
//            })
//        }
//    }
    
    func signInAction() {
        self.signIn(email: self.getEmail(), password: self.getPassword()) { (result, error) in
            if error != nil {
//                self.setPasswordHintLabel(String(describing: error?.localizedDescription))
                self.setPasswordHintLabel("Email or password is incorrect.")
                print(self.getPasswordHintLabel())
            } else {
                self.resetForm()
            }
        }
    }
    
    func resetForm() {
        self.setEmail("")
        self.setPassword("")
        self.setPasswordHintLabel("")
    }
}
