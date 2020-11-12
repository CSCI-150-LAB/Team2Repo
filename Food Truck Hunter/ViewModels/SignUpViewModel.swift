import Combine
import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class SignUpViewModel: AuthenticationState {
    static let uID = ID()
    static func generateID() -> String {
        return uID.generate(alphabet: .numeric, size: 8)
    }
    
    @Published private var formModel : FormModel    
    private let userID: String
    private let truckID: String
    public var firstName: String = ""
    public var lastName: String = ""
    public var truckName: String = ""
    public var phoneNumber: String = ""
    public var email: String = ""
    public var password: String = ""
    public var retypedPassword: String = ""
    public var type: String = "customer"
    
    init(formModel : FormModel, firstName : String = "", lastName : String = "", vendorName : String = "", phoneNumber : String = "", email : String = "", password : String = "", retypedPassword : String = "", type : String = "customer") {
        self.formModel = formModel
        self.userID = SignUpViewModel.generateID()
        self.truckID = SignUpViewModel.generateID()
        self.firstName = firstName
        self.lastName = lastName
        self.truckName = vendorName
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.retypedPassword = retypedPassword
        self.type = type
    }
    
    func getUserID() -> String {
        return self.userID
    }
    
    func getTruckID() -> String {
        return self.truckID
    }
    
    func getFirstName() -> String {
        return self.firstName
    }
    
    func getLastName() -> String {
        return self.lastName
    }
    
    func getTruckName() -> String {
        return self.truckName
    }
    
    func getPhoneNumber() -> String {
        return self.phoneNumber
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getRetypedPassword() -> String {
        return self.retypedPassword
    }
    
    func getType() -> String {
        return self.type
    }
    
    func getFirstNameHintLabel() -> String {
        return self.formModel.firstNameHintLabel
    }
    
    func getLastNameHintLabel() -> String {
        return self.formModel.lastNameHintLabel
    }
    
    func getTruckNameHintLabel() -> String {
        return self.formModel.truckNameHintLabel
    }
    
    func getPhoneNumberHintLabel() -> String {
        return self.formModel.phoneHintLabel
    }
    
    func getEmailHintLabel() -> String {
        return self.formModel.emailHintLabel
    }
    
    func getPasswordHintLabel() -> String {
        return self.formModel.passwordHintLabel
    }
    
    func getPasswordRetypedHintLabel() -> String {
        return self.formModel.passwordRetypedHintLabel
    }
    
    func setFirstName(_ firstName : String) {
        self.firstName = firstName
        self.formModel.firstName = firstName
    }
    
    func setLastName(_ lastName : String) {
        self.lastName = lastName
        self.formModel.lastName = lastName
    }
    
    func setTruckName(_ vendorName : String) {
        self.truckName = vendorName
        self.formModel.vendorName = vendorName
    }
    
    func setPhoneNumber(_ phoneNumber : String) {
        self.phoneNumber = phoneNumber
        self.formModel.phoneNumber = phoneNumber
    }
    
    func setEmail(_ email : String) {
        self.email = email
        self.formModel.email = email
    }
    
    func setPassword(_ password : String) {
        self.password = password
        self.formModel.password = password
    }
    
    func setRetypedPassword(_ retypedPassword : String) {
        self.retypedPassword = retypedPassword
        self.formModel.retypedPassword = retypedPassword
    }
    
    func setType(_ accountType : String) {
        self.type = accountType
        self.formModel.type = accountType
    }
    
    func setFirstNameHintLabel(_ message : String ) {
        self.formModel.firstNameHintLabel = message
    }
    
    func setLastNameHintLabel(_ message : String ) {
        self.formModel.lastNameHintLabel = message
    }
    
    func setTruckNameHintLabel(_ message : String ) {
        self.formModel.truckNameHintLabel = message
    }
    
    func setPhoneNumberHintLabel(_ message : String ) {
        self.formModel.phoneHintLabel = message
    }
    
    func setEmailHintLabel(_ message : String) {
        self.formModel.emailHintLabel = message
    }
    
    func setPasswordHintLabel(_ message : String) {
        self.formModel.passwordHintLabel = message
    }
    
    func setPasswordRetypedHintLabel(_ message : String) {
        self.formModel.passwordRetypedHintLabel = message
    }
    
    func signUpAction() {
        if (getType() == "vendor" && self.validateVendorInputFields()) {
            let userData: [String: Any] = [
                "business_license": "",
                "email": self.getEmail().lowercased(),
                "first_name": self.getFirstName().lowercased(),
                "id": Int(self.getUserID())!,
                "last_name" : self.getLastName().lowercased(),
                "phone_number": self.getPhoneNumber(),
                "truck_id": Int(self.getTruckID())!,
                "truck_name": self.getTruckName().lowercased(),
                "type": self.getType(),
            ]
            self.signUp(email: self.getEmail(), password: self.getPassword(), userInfo: userData) { (result, error) in
                if error != nil {
                    self.setEmailHintLabel(error!.localizedDescription as String)
                    print("\(String(describing: error!.localizedDescription))")
                } else {
                    // Successfully signed up
                    print("Signing up...")
                    self.resetForm()
                }
            }
        }
            
        if (getType() == "customer" && self.validateUserInputFields()) {
            let userData: [String: Any] = [
                "id": Int(self.getUserID())!,
                "email": self.getEmail().lowercased(),
                "first_name" : self.getFirstName().lowercased(),
                "last_name" : self.getLastName().lowercased(),
                "type" : self.getType(),
            ]
            
            self.signUp(email: self.getEmail(), password: self.getPassword(), userInfo: userData) { (result, error) in
                if error != nil {
                    self.setEmailHintLabel(String(describing: error!.localizedDescription))
                } else {
                    self.resetForm()
                }
            }
            
            // Create user document in Users collection

        }
    }
    
    func resetForm() {
        self.setFirstName("")
        self.setLastName("")
        self.setTruckName("")
        self.setPhoneNumber("")
        self.setEmail("")
        self.setPassword("")
        self.setRetypedPassword("")
        self.formModel.type = ""
        self.setEmailHintLabel("")
        self.setPasswordHintLabel("")
        self.setPasswordRetypedHintLabel("")
    }
    
    func validateUserInputFields() -> Bool {
        let isEmailValid = FormUtilities.validateEmail(self.getEmail(), &self.formModel.emailHintLabel)
        let isPasswordValid = FormUtilities.validatePassword(self.getPassword(), &self.formModel.passwordHintLabel)
        let doesPasswordsMatch = FormUtilities.validatePasswords(self.getPassword(), self.getRetypedPassword(), &self.formModel.passwordRetypedHintLabel)
        
        return (isEmailValid && isPasswordValid && doesPasswordsMatch)
    }
    
    func validateVendorInputFields() -> Bool {
        let isFirstLastNameValid = FormUtilities.validateFirstName(self.getFirstName(), &(self.formModel.firstNameHintLabel))
        let isLastNameValid = FormUtilities.validateLastName(self.getLastName(), &(self.formModel.lastNameHintLabel))
        let isTruckNameValid = FormUtilities.validateTruckName(self.getTruckName(), &(self.formModel.truckNameHintLabel))
        let isPhoneNumberValid = FormUtilities.validatePhoneNumber(self.getPhoneNumber(), &(self.formModel.phoneHintLabel))
        let isEmailValid = FormUtilities.validateEmail(self.getEmail(), &(self.formModel.emailHintLabel))
        let isPasswordValid = FormUtilities.validatePassword(self.getPassword(), &(self.formModel.passwordHintLabel))
        let doesPasswordsMatch = FormUtilities.validatePasswords(self.getPassword(), self.getRetypedPassword(), &(self.formModel.passwordRetypedHintLabel))
        
        return (isFirstLastNameValid && isLastNameValid && isTruckNameValid && isPhoneNumberValid && isEmailValid && isPasswordValid && doesPasswordsMatch)
    }
}
