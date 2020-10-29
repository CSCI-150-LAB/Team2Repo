import Foundation
import SwiftUI
import Firebase

class ForgotPasswordViewModel : ObservableObject {
    @Published private var formModel : FormModel
    public var email : String
    
    init(formModel : FormModel, email : String = "") {
        self.formModel = formModel
        self.email = email
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getEmailHintLabel() -> String {
        return self.formModel.emailHintLabel
    }
    
    func setEmail(_ email : String) {
        self.email = email
    }
    
    func setEmailHintLabel(_ message : String) {
        self.formModel.emailHintLabel = message
    }
    
    func resetForm() {
        self.setEmail("")
        self.setEmailHintLabel("")
    }
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: self.getEmail()) { error in
            guard error == nil else {
                print("No account associated with \(self.getEmail())\n")
                self.setEmailHintLabel("No account associated with this email address.")
                return
            }

            print("Sent link to \(self.getEmail()).")
            self.resetForm()
        }
    }
}
