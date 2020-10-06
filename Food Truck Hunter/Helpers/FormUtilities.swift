import Foundation

class FormUtilities {
    
    static func validateEmail(_ email : String) -> Bool {
        let regexPattern = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        return emailTest.evaluate(with: email)
    }
    
    static func validateEmailErrorMsg(_ email : String) -> String {
        return validateEmail(email) ? "" : "Email address is invalid."
    }
    
    static func validatePassword(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "((?=.*\\d)(?=.*[A-Z])(?=.*\\W).{8,})")
        return passwordTest.evaluate(with: password)
    }
    
    static func validatePasswordsEquivalentErrorMsg(_ password : String, _ reenteredPassword : String) -> String {
        return ((password == reenteredPassword) ? "" : "Password does not match")
    }
    
    static func isEmptyErrorMsg(_ fieldValue : String, _ fieldType : String) -> String {
        if (fieldType == "email" && fieldValue.isEmpty) {
            return "Please enter an email address."
        }
        
        if (fieldType == "password" && fieldValue.isEmpty) {
            return "Please enter a password."
        }
        
        if (fieldType == "reenterpassword" && fieldValue.isEmpty) {
            return "Please re-enter the password."
        }
        
        return ""
    }
}
