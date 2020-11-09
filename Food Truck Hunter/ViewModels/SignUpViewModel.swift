import Foundation

import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class SignUpViewModel : ObservableObject {
    static let uID = ID()
    static func generateID() -> String {
        return uID.generate(alphabet: .numeric, size: 8)
    }
    
    @Published private var formModel : FormModel
    @Published private var isCompleted : Bool = false
    private let db = Firestore.firestore()
    private let dispatch = DispatchGroup()
    
    private let userID : String
    public var firstName : String = ""
    public var lastName : String = ""
    public var vendorName : String = ""
    public var phoneNumber : String = ""
    public var email : String = ""
    public var password : String = ""
    public var retypedPassword : String = ""
    public var type : String = "User"
    
    init(formModel : FormModel, firstName : String = "", lastName : String = "", vendorName : String = "", phoneNumber : String = "", email : String = "", password : String = "", retypedPassword : String = "", type : String = "User") {
        self.formModel = formModel
        self.userID = SignUpViewModel.generateID()
        self.firstName = firstName
        self.lastName = lastName
        self.vendorName = vendorName
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.retypedPassword = retypedPassword
        self.type = type
    }
    
    func getID() -> String {
        return self.userID
    }
    
    func getFirstName() -> String {
        return self.firstName
    }
    
    func getLastName() -> String {
        return self.lastName
    }
    
    func getVendorName() -> String {
        return self.vendorName
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
    
    func setVendorName(_ vendorName : String) {
        self.vendorName = vendorName
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
    
    func setEmailHintLabel(_ message : String) {
        self.formModel.emailHintLabel = message
    }
    
    func setPasswordHintLabel(_ message : String) {
        self.formModel.passwordHintLabel = message
    }
    
    func setPasswordRetypedHintLabel(_ message : String) {
        self.formModel.passwordRetypedHintLabel = message
    }
    
    func createVendorAccount() {
        if (self.validateVendorInputFields()) {

            self.dispatch.enter()
            Auth.auth().createUser(withEmail: self.getEmail(), password: self.getPassword()) { authResult, error in
                // An error occurred
                guard error == nil else {
                    self.setEmailHintLabel(String(describing: error!.localizedDescription))
                    return
                }

                // Successfully created account
                var ref: DocumentReference? = nil
                ref = self.db.collection("Trucks").addDocument(data: [
                    "id" : Int(self.getID())!,
                    "business_license" : "",
                    "cuisine" : [],
                    "email" : self.getEmail().lowercased(),
                    "hours" : ["", "", "", "", "", "", ""],
                    "locations" : [],
                    "name" : self.getVendorName().lowercased(),
                    "owner_id" : 0,
                    "owner_name" : "",
                    "phone" : self.getPhoneNumber(),
                    "rating" : 0,
                    "total_reviews" : 0
                ]) {
                    error in
                    if let error = error {
                        print("Error:\n\(error)")
                    }
                    else {
                        self.isCompleted = true
                        print("\(self.vendorName) added. Document reference is \(ref!.documentID).")
                    }
                }
                self.resetForm()
                self.isCompleted.toggle()
            }
            self.dispatch.leave()
        }
    }
    
    func createUserAccount() {
        if (self.validateUserInputFields()) {
            self.dispatch.enter()
            Auth.auth().createUser(withEmail: self.getEmail(), password: self.getPassword()) { authResult, error in
                // An error occurred
                guard error == nil else {
                    self.setEmailHintLabel(String(describing: error!.localizedDescription))
                    return
                }

                // Successfully created account
                var ref: DocumentReference? = nil
                ref = self.db.collection("Users").addDocument(data: [
                    "id" : Int(self.getID())!,
                    "email" : self.getEmail().lowercased(),
                    "favorites": [],
                    "first_name" : self.getFirstName().lowercased(),
                    "last_name" : self.getLastName().lowercased(),
                    "phone": "",
                    "profile_img": "",
                    "total_reviews": 0,
                    "status": "basic",
                    "type" : self.type
                ]) {
                    error in
                    if let error = error {
                        print("Error:\n\(error)")
                    }
                    else {
                        self.isCompleted = true
                        print("\(self.firstName) \(self.lastName) added. Document reference is \(ref!.documentID).")
                    }
                }
                self.resetForm()
                self.isCompleted.toggle()
            }
            self.dispatch.leave()
        }
    }
    
    func resetForm() {
        self.setFirstName("")
        self.setLastName("")
        self.setVendorName("")
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
        let isEmailValid = FormUtilities.validateEmail(self.getEmail(), &(self.formModel.emailHintLabel))
        let isPasswordValid = FormUtilities.validatePassword(self.getPassword(), &(self.formModel.passwordHintLabel))
        let doesPasswordsMatch = FormUtilities.validatePasswords(self.getPassword(), self.getRetypedPassword(), &(self.formModel.passwordRetypedHintLabel))
        print("\(isEmailValid) && \(isPasswordValid) && \(doesPasswordsMatch)")
        return (isEmailValid && isPasswordValid && doesPasswordsMatch)
    }
    
    func validateVendorInputFields() -> Bool {
        let isVendorNameEmpty = self.getVendorName().isEmpty
        let isPhoneNumberValid = self.getPhoneNumber().isEmpty
        let isEmailValid = FormUtilities.validateEmail(self.getEmail(), &(self.formModel.emailHintLabel))
        let isPasswordValid = FormUtilities.validatePassword(self.getPassword(), &(self.formModel.passwordHintLabel))
        let doesPasswordsMatch = FormUtilities.validatePasswords(self.getPassword(), self.getRetypedPassword(), &(self.formModel.passwordRetypedHintLabel))
        print("\(!isVendorNameEmpty) && \(!isPhoneNumberValid) && \(isEmailValid) && \(isPasswordValid) && \(doesPasswordsMatch)")
        return (!isVendorNameEmpty && !isPhoneNumberValid && isEmailValid && isPasswordValid && doesPasswordsMatch)
    }
}
