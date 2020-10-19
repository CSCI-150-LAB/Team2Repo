import Foundation
import Firebase
import FirebaseFirestore
import GoogleSignIn
import NanoID

class CreateUserAccountViewModel : ObservableObject {
    static let uID = ID()
    static func generateID() -> String {
        return uID.generate(alphabet: .numeric, size: 8)
    }
    
    @Published private var createUserAccountModel : FormModel
    @Published private var isCompleted : Bool = false
    private let userID : String
    public var firstName : String = ""
    public var lastName : String = ""
    public var email : String = ""
    public var password : String = ""
    public var retypedPassword : String = ""
    public var type : String = "user"
    
    init(createUserAccountModel : FormModel, firstName : String = "", lastName : String = "", email : String = "", password : String = "", retypedPassword : String = "", type : String = "user") {
        self.createUserAccountModel = createUserAccountModel
        self.userID = CreateUserAccountViewModel.generateID()
        self.firstName = firstName
        self.lastName = lastName
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
    
    func getEmail() -> String {
        return self.email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getRetypedPassword() -> String {
        return self.retypedPassword
    }
    
    func getEmailHintLabel() -> String {
        return self.createUserAccountModel.emailHintLabel
    }
    
    func getPasswordHintLabel() -> String {
        return self.createUserAccountModel.passwordHintLabel
    }
    
    func getPasswordRetypedHintLabel() -> String {
        return self.createUserAccountModel.passwordRetypedHintLabel
    }
    
    func setFirstName(_ firstName : String) {
        self.firstName = firstName
        self.createUserAccountModel.firstName = firstName
    }
    
    func setLastName(_ lastName : String) {
        self.lastName = lastName
        self.createUserAccountModel.lastName = lastName
    }
    
    func setEmail(_ email : String) {
        self.email = email
        self.createUserAccountModel.email = email
    }
    
    func setPassword(_ password : String) {
        self.password = password
        self.createUserAccountModel.password = password
    }
    
    func setRetypedPassword(_ retypedPassword : String) {
        self.retypedPassword = retypedPassword
        self.createUserAccountModel.retypedPassword = retypedPassword
    }
    
    func setEmailHintLabel(_ message : String) {
        self.createUserAccountModel.emailHintLabel = message
    }
    
    func setPasswordHintLabel(_ message : String) {
        self.createUserAccountModel.passwordHintLabel = message
    }
    
    func setPasswordRetypedHintLabel(_ message : String) {
        self.createUserAccountModel.passwordRetypedHintLabel = message
    }
    
    func buttonPressed() {
        
    }
    
    func createAccount() {
        let db = Firestore.firestore()
        let dispatch = DispatchGroup()
        
        if (self.validateInputFields()) {

            Auth.auth().createUser(withEmail: self.getEmail(), password: self.getPassword()) { authResult, error in
                // An error occurred
                guard error == nil else {
                    self.setEmailHintLabel(String(describing: error!.localizedDescription))
                    print("Unsuccessfully created an account:\n\(String(describing: error?.localizedDescription))")
                    return
                }

                // Successfully created account
                dispatch.enter()
                var ref: DocumentReference? = nil
                ref = db.collection("Users").addDocument(data: [
                    "id" : Int(self.getID())!,
                    "email" : self.getEmail().lowercased(),
                    "favorites": [],
                    "first_name" : self.getFirstName().lowercased(),
                    "last_name" : self.getLastName().lowercased(),
                    "phone": "",
                    "profile_img": "",
                    "review_count": 0,
                    "status": "basic",
                    "type" : self.type
                ]) {
                    error in
                    if let error = error {
                        print("Something happened: \(error)")
                    }
                    else {
                        self.isCompleted = true
                        print("Added document \(ref!.documentID)")
                    }
                }
                self.resetForm()
                dispatch.leave()
                self.isCompleted.toggle()
            }
//            successfulAccountCreate
        }
    }
    
    func resetForm() {
        self.setFirstName("")
        self.setLastName("")
        self.setEmail("")
        self.setPassword("")
        self.setRetypedPassword("")
        self.createUserAccountModel.type = ""
        self.setEmailHintLabel("")
        self.setPasswordHintLabel("")
        self.setPasswordRetypedHintLabel("")
    }
    
    func validateInputFields() -> Bool {
        let check1 = FormUtilities.validateEmail(self.getEmail(), &(self.createUserAccountModel.emailHintLabel))
        let check2 = FormUtilities.validatePassword(self.getPassword(), &(self.createUserAccountModel.passwordHintLabel))
        let check3 = FormUtilities.validatePasswords(self.getPassword(), self.getRetypedPassword(), &(self.createUserAccountModel.passwordRetypedHintLabel))
        print("\(check1) && \(check2) && \(check3)")
        return (check1 && check2 && check3)
    }
}
