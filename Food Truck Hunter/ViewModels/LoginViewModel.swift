import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class LoginViewModel : ObservableObject {
    
    @Published private var loginModel : FormModel
    
    init(loginModel : FormModel) {
        self.loginModel = loginModel
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
    
    func setPassword(_ password : String) {
        self.loginModel.password = password
    }
    
    func setEmailHintLabel(_ message : String) {
        self.loginModel.emailHintLabel = message
    }
    
    func setPasswordHintLabel(_ message : String) {
        self.loginModel.passwordHintLabel = message
    }
    
    
    func logIn(_ email : String, _ password : String, _ callback : inout Int?) {
        var signedIn : Int? = nil
        self.setEmail(email)
        self.setPassword(password)
        if validateInputFields() {
            Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
                // Unsuccessful
                guard error == nil else {
                    print("Cannot sign in")
                    self.setPasswordHintLabel("Email or password is incorrect.")
                    return
                }

                // Successfully logged in
                signedIn = 1
                self.setPasswordHintLabel("")
                self.resetForm()
                print("Successfully signed in")
            })
            callback = signedIn
        }
    }
    
    func resetForm() {
        self.loginModel.email = ""
        self.loginModel.password = ""
    }
    
    func validateInputFields() -> Bool {
        return FormUtilities.validateEmail(self.loginModel.email, &self.loginModel.emailHintLabel) && FormUtilities.validatePassword(self.loginModel.password, &self.loginModel.passwordHintLabel)
    }
}
