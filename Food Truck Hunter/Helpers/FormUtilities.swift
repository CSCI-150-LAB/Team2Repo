import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn

class FormUtilities {
    
    static func validateEmail(_ email : String, _ hintMessage : inout String) -> Bool {
        let regexPattern = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        let evaluateResult = emailTest.evaluate(with: email)
        let isEmailEmpty = email.isEmpty
        hintMessage = isEmailEmpty ? "Please enter an email address." : (emailTest.evaluate(with: email) ? "" : "Email address is invalid.")
        return !isEmailEmpty && evaluateResult
    }
    
    static func validatePassword(_ password : String, _ hintMessage : inout String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "((?=.*\\d)(?=.*[A-Z])(?=.*\\W).{8,})")
        let evaluateResult = passwordTest.evaluate(with: password)
        let isPasswordEmpty = password.isEmpty
        hintMessage = isPasswordEmpty ? "Please enter a password." : (evaluateResult ? "" : "• Must be at least 8 characters long.\n• Must contain at least an upper case, a lower case, a digit, and a special character.")
        return !isPasswordEmpty && evaluateResult
    }
    
    static func validatePasswords(_ password : String, _ retypedPassword : String, _ hintMessage : inout String) -> Bool {
        let evaluteResult = password == retypedPassword
        let isRetypedPasswordEmpty = retypedPassword.isEmpty
        hintMessage = isRetypedPasswordEmpty ? "Please retype the password." : (evaluteResult ? "" : "Password does not match.")
        return !isRetypedPasswordEmpty && evaluteResult
    }

}
