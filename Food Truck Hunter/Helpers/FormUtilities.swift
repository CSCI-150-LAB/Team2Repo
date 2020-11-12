import Foundation

class FormUtilities {
    
    static func validateEmail(_ email: String, _ hintMessage: inout String) -> Bool {
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
        hintMessage = isEmailEmpty ? "Please enter an email address." : (evaluateResult ? "" : "Email address is invalid.")
        return !isEmailEmpty && evaluateResult
    }
    
    static func validatePassword(_ password: String, _ hintMessage: inout String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "((?=.*\\d)(?=.*[A-Z])(?=.*\\W).{8,})")
        let evaluateResult = passwordTest.evaluate(with: password)
        let isPasswordEmpty = password.isEmpty
        hintMessage = isPasswordEmpty ? "Please enter a password." : (evaluateResult ? "" : "Must be at least 8 characters long. Must contain an upper case, a lower case, a digit, and a special character.")
        return !isPasswordEmpty && evaluateResult
    }
    
    static func validatePasswords(_ password: String, _ retypedPassword: String, _ hintMessage: inout String) -> Bool {
        let evaluteResult = password == retypedPassword
        let isRetypedPasswordEmpty = retypedPassword.isEmpty
        hintMessage = isRetypedPasswordEmpty ? "Please confirm the password." : (evaluteResult ? "" : "Password does not match.")
        return !isRetypedPasswordEmpty && evaluteResult
    }
    
    static func validateFirstName(_ firstName: String, _ firstNameHintMessage: inout String) -> Bool {
        let regexPattern = "^[a-zA-Z]+$"
        let firstNameTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        let evaluateFirstName = firstNameTest.evaluate(with: firstName)
        firstNameHintMessage = firstName.isEmpty ? "Please enter your first name." : (evaluateFirstName ? "" : "Numbers, special characters, or whitespaces aren't allowed.")
        
        return evaluateFirstName
    }
    
    static func validateLastName(_ lastName: String, _ lastNameHintMessage: inout String) -> Bool {
        let regexPattern = "^[a-zA-Z]+$"
        let lastNameTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        let evaluateLastName = lastNameTest.evaluate(with: lastName)
        lastNameHintMessage = lastName.isEmpty ? "Please enter your last name." : (evaluateLastName ? "" : "Numbers, special characters, or whitespaces aren't allowed.")
        
        return evaluateLastName
    }
    
    static func validateTruckName(_ truckName: String, _ truckNameHintMessage: inout String) -> Bool {
        let regexPattern = "^\\w+( \\w+)*$"
        let truckNameTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        let evaluateTruckName = truckNameTest.evaluate(with: truckName)
        truckNameHintMessage = truckName.isEmpty ? "Please enter a truck name." : (evaluateTruckName ? "" : "Can only contain letters, numebers, and whitespaces.")
        
        return evaluateTruckName
    }
    
    static func validatePhoneNumber(_ phoneNumber: String, _ phoneHintMessage: inout String) -> Bool {
        let regexPattern = "((\\+\\d)?[0-9]{10,11})|((\\+\\d)?[0-9\\s]{10,14})|((\\+?\\d\\s?)?\\(?[0-9]{3}\\)?\\s?[0-9]{3}\\s?\\-?\\s?[0-9]{4})|((\\+?\\d\\-?\\s?)?[0-9]{3}\\-[0-9]{3}\\-[0-9]{4})"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        let evaluatePhoneNumber = phoneNumberTest.evaluate(with: phoneNumber)
        phoneHintMessage = phoneNumber.isEmpty ? "Please enter a phone number." : (evaluatePhoneNumber ? "" : "Phone number only contain the following: 0-9, +, -, (, ), and whitespaces.")
        
        return evaluatePhoneNumber
    }
}
