import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class LoginViewModel : ObservableObject {
    
    @Published private var loginModel : FormModel
//    private var didSignIn : Bool
    
    public var email : String
    public var password : String
    
    init(loginModel : FormModel, email : String = "", password : String = "") {
        self.loginModel = loginModel
        self.email = email
        self.password = password
//        self.didSignIn = didSignIn
    }
    
//    func getDidSignIn() -> Int{
//        return self.didSignIn ? 1 : 0
//    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getEmailHintLabel() -> String {
        return self.loginModel.emailHintLabel
    }
    
    func getPasswordHintLabel() -> String {
        return self.loginModel.passwordHintLabel
    }
    
    func setEmail(_ email : String) {
        self.loginModel.email = email
    }
    
//    func setDidSignIn() {
//        self.didSignIn.toggle()
//    }
    
    func setPassword(_ password : String) {
        self.loginModel.password = password
    }
    
    func setEmailHintLabel(_ message : String) {
        self.loginModel.emailHintLabel = message
    }
    
    func setPasswordHintLabel(_ message : String) {
        self.loginModel.passwordHintLabel = message
    }
    
    func logIn() {

        if validateInputFields() {
            Auth.auth().signIn(withEmail: self.getEmail(), password: self.getPassword(), completion: {result, error in
                // Unsuccessful
                guard error == nil else {
                    print("Cannot sign in")
                    self.setPasswordHintLabel("Email or password is incorrect.")
                    return
                }

                // Successfully logged in
//                self.setDidSignIn()
                self.setPasswordHintLabel("")
                self.resetForm()
                print("Successfully signed in")
            })
        }
    }
    
    func resetForm() {
        self.loginModel.email = ""
        self.loginModel.password = ""
    }
    
    func validateInputFields() -> Bool {
        return FormUtilities.validateEmail(self.loginModel.email!, &self.loginModel.emailHintLabel) && FormUtilities.validatePassword(self.loginModel.password!, &self.loginModel.passwordHintLabel)
    }
}
