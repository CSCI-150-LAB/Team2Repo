import SwiftUI
import Firebase
import FirebaseAuth

public func returnThis() {
    print("You pressed the button.")
}

struct CreateUserAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var user = UsersViewModel(usr: User(default_location: "", email: "", first_name: "", id: 0, last_name: "", phone_number: "", type: ""))
    
    @State private var buttonLabel : String = "Create an account"
    @State private var buttonColor : Color = Color.blue
    @State private var buttonDisable : Bool = false;
    
    // used for animating loading circle
    @State private var isLoading : Bool = false
    @State private var isRotating : Bool = false
    @State private var animateStrokeStart : Bool = false
    @State private var animateStrokeEnd : Bool = true
    
    @State private var firstName : String = ""
    @State private var lastName : String = ""
    @State var email : String = ""
    @State private var showPassword : Bool = false
    @State private var showReenterPassword : Bool = false
    @State private var password : String = ""
    @State private var reenterPassword : String = ""
    @State var invalidEmailHintLabel : String = ""
    @State var invalidPasswordHintLabel : String = ""
    @State var invalidPasswordMatchHintLabel : String = ""
    
    var body: some View {
        ScrollView() {
            Section() {
                Text("Be the first to find the food truck.\nBe the first to share it.")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.bottom, 10)
            
            Section() {
                VStack(alignment: .leading) {
                    Section() {
                        Text("First Name").padding(.bottom, 0)
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$firstName)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                            
                            if !self.firstName.isEmpty {
                                Button(action: {
                                    self.firstName = ""
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }.padding(.bottom, 14)
                    }
                    
                    Section() {
                        Text("Last Name").padding(.bottom, 0)
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$lastName)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                            
                            if !self.lastName.isEmpty {
                                Button(action: {
                                    self.lastName = ""
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }.padding(.bottom, 14)
                    }
                    
                    Section() {
                        Text("Email Address")
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$email, onEditingChanged: {_ in
                                if !self.email.isEmpty {
                                    self.invalidEmailHintLabel = FormUtilities.validateEmailErrorMsg(self.email)
                                }
                            })
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                            
                            if !self.email.isEmpty {
                                Button(action: {
                                    self.email = ""
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }.padding(.vertical, 0)
                        
                        Text(self.invalidEmailHintLabel)
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2.0)
                            .animation(.easeInOut)
                    }

                    Section() {
                        Text("Password")
                        ZStack(alignment: .trailing) {
                            if showPassword {
                                TextField("", text: self.$password, onEditingChanged: {_ in
                                    if self.password.isEmpty {
                                        self.invalidPasswordHintLabel = ""
                                    }
                                    else {
                                        if(self.password.count >= 1 && self.password.count <= 8) {
                                            self.invalidPasswordHintLabel = FormUtilities.validatePassword(self.password) ? "" : "Must at least 8 characters long."
                                        }
                                        else {
                                            self.invalidPasswordHintLabel = FormUtilities.validatePassword(self.password) ? "" : "Must at least 8 characters long. \nContain at least an upper case, a lower case, a digit, and a special character."
                                        }
                                    }
                                })
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            else {
                                SecureField("", text: self.$password)
                                    .onChange(of: self.password) { newPassword in
                                        self.password = newPassword
                                        
                                        if self.password.isEmpty {
                                            self.invalidPasswordHintLabel = ""
                                        }
                                        else {
                                            if(self.password.count >= 1 && self.password.count <= 8) {
                                                self.invalidPasswordHintLabel = FormUtilities.validatePassword(self.password) ? "" : "Must at least 8 characters long."
                                            }
                                            else {
                                                self.invalidPasswordHintLabel = FormUtilities.validatePassword(self.password) ? "" : "Must at least 8 characters long. \nContain at least an upper case, a lower case, a digit, and a special character."
                                            }
                                        }
                                    }
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }

                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill").foregroundColor(Color(UIColor.opaqueSeparator))
                            }.padding(.trailing, 20)
                        }.padding(.vertical, 0)
                        
                        Text(self.invalidPasswordHintLabel)
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2.0)
                            .fixedSize(horizontal: false, vertical: true)
                            .animation(.easeInOut)
                    }
                    
                    Section() {
                        Text("Re-enter Password")
                        ZStack(alignment: .trailing) {
                            if showReenterPassword {
                                TextField("", text: self.$reenterPassword, onEditingChanged: {_ in
                                    if self.reenterPassword.isEmpty {
                                        self.invalidPasswordMatchHintLabel = ""
                                    }
                                    else {
                                        self.invalidPasswordMatchHintLabel = FormUtilities.validatePasswordsEquivalentErrorMsg(self.password, self.reenterPassword)
                                    }
                                })
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            else {
                                SecureField("", text: self.$reenterPassword)
                                    .onChange(of: self.reenterPassword) { newRetypedPassword in
                                        self.reenterPassword = newRetypedPassword
                                        
                                        if self.reenterPassword.isEmpty {
                                            self.invalidPasswordMatchHintLabel = ""
                                        }
                                        else {
                                            self.invalidPasswordMatchHintLabel = FormUtilities.validatePasswordsEquivalentErrorMsg(self.password, self.reenterPassword)
                                        }
                                    }
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            
                            Button(action: {
                                showReenterPassword.toggle()
                            }) {
                                Image(systemName: showReenterPassword ? "eye.slash.fill" : "eye.fill").foregroundColor(Color(UIColor.opaqueSeparator))
                            }.padding(.trailing, 20)
                        }.padding(.vertical, 0)
                        
                        Text(self.invalidPasswordMatchHintLabel)
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2)
                            .animation(.easeInOut)
                    }
                }
            }.padding(.horizontal)
            
            Section() {
                Button(action: {
                    if ((!self.email.isEmpty && !self.password.isEmpty) && !self.reenterPassword.isEmpty) {
                        if FormUtilities.validateEmail(self.email) && FormUtilities.validatePassword(self.password) && (self.password == self.reenterPassword) {
                            buttonDisable.toggle()
                            isLoading.toggle()
                            buttonLabel = ""
                            self.invalidEmailHintLabel = ""
                            Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                                // An error occurred
                                guard error == nil else {
                                    buttonDisable.toggle()
                                    isLoading.toggle()
                                    buttonLabel = "Create an account"
                                    
                                    self.invalidEmailHintLabel = String(describing: error!.localizedDescription)
                                    print("Unsuccessfully created an account:\n\(String(describing: error?.localizedDescription))")
                                    return;
                                }
                                
                                // To be moved to UsersViewModel
                                let db = Firestore.firestore()
                                let dispatch = DispatchGroup()
                                
                                dispatch.enter()
                                print(Auth.auth().currentUser!)
                                var ref: DocumentReference? = nil
                                ref = db.collection("Users").addDocument(data: [
                                    "first_name" : self.firstName,
                                    "last_name" : self.lastName,
                                    "email" : self.email
                                ]) {
                                    error in
                                    if let error = error {
                                        print("Something happened: \(error)")
                                    }
                                    else {
                                        print("Added document \(ref!.documentID)")
                                    }
                                }
                                
                                // Account creation was successful
                                isLoading.toggle()
                                buttonLabel = "Account created!"
                                buttonColor = Color.green
                                self.firstName = ""
                                self.lastName = ""
                                self.email = ""
                                self.password = ""
                                self.reenterPassword = ""
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    buttonLabel = "Create an account"
                                    buttonColor = Color.blue
                                    buttonDisable.toggle()
                                }
                                print("Successfully created an account.")
                                dispatch.leave()
                            }
                        }
                        else {
                            self.invalidEmailHintLabel = FormUtilities.validateEmailErrorMsg(self.email)
                            self.invalidPasswordMatchHintLabel = FormUtilities.validatePasswordsEquivalentErrorMsg(self.password, self.reenterPassword)
                        }
                    }
                    else {
                        self.invalidEmailHintLabel = FormUtilities.isEmptyErrorMsg(self.email, "email")
                        self.invalidPasswordHintLabel = FormUtilities.isEmptyErrorMsg(self.password, "password")
                        self.invalidPasswordMatchHintLabel = FormUtilities.isEmptyErrorMsg(self.reenterPassword, "reenterpassword")
                    }
                }) {
                    HStack {
                        Spacer()
                        ZStack {
                            if isLoading {
                                Circle()
                                    .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
                                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .rotationEffect(Angle(degrees: isRotating ? 360 : 0))
                                    .opacity(isLoading ? 1 : 0)
                                    .onAppear() {
                                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                            isRotating.toggle()
                                        }
                                        
                                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                                            animateStrokeStart.toggle()
                                        }
                                        
                                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                                            animateStrokeEnd.toggle()
                                        }
                                    }
                            }
                        
                            Text(buttonLabel)
                                .font(.headline)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(buttonColor)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(buttonColor, lineWidth: 1)
                                )
                        }
                        Spacer()
                    }
                }
                .padding(.bottom, 5)
                .padding(.horizontal)
                .accessibility(label: Text("Create account button"))
                .disabled(buttonDisable)
                
                // This is how we'll be add button from now on. To keep view clean
                // Go to Components > Buttons > DefaultButtonView to change the style.
                // Takes 3 arguemnts: Title, Function, Return Bool
                // vvv (Uncomment to see an example) vvv
                // DefaultButton(label: "Test Button", function: returnThis, returnValue: true)
            }
        }
        .navigationTitle("Create an Account")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Login")
            }
        })
    }
}

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}

struct CreateUserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserAccountView()
    }
}
