import SwiftUI
import Firebase
import FirebaseAuth

struct CreateUserAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
    @State private var password : String = ""
    @State private var reenterPassword : String = ""
    @State var invalidEmailHintLabel : String = ""
    @State var invalidPasswordHintLabel : String = ""
    @State var invalidPasswordMatchHintLabel : String = ""
    
    var body: some View {
        ScrollView() {
            Section() {
                VStack(alignment: .leading) {
                    Section() {
                        ZStack(alignment: .trailing) {
                            TextField("Email Address", text: self.$email, onEditingChanged: {_ in
                                if !self.email.isEmpty {
                                    self.invalidEmailHintLabel = FormUtilities.validateEmailErrorMsg(self.email)
                                }
                            })
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
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
                        }
                    }
                    
                    Section() {
                        ZStack(alignment: .trailing) {
                            TextField("Email Address", text: self.$email, onEditingChanged: {_ in
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
                        }
                    }
                    
                    Section() {
                        ZStack(alignment: .trailing) {
                            TextField("Email Address", text: self.$email, onEditingChanged: {_ in
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
                        }
                        
                        Text(self.invalidEmailHintLabel)
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2.0)
                            .animation(.easeInOut)
                    }

                    Section() {
                        ZStack(alignment: .trailing) {
                            SecureField("Password", text: self.$password)
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
                            if !self.password.isEmpty {
                                Button(action: {
                                    self.password = ""
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }
                        
                        Text(self.invalidPasswordHintLabel)
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2.0)
                            .fixedSize(horizontal: false, vertical: true)
                            .animation(.easeInOut)
                    }
                    
                    Section() {
                        ZStack(alignment: .trailing) {
                            SecureField("Re-enter Password", text: self.$reenterPassword)
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
                            if !self.reenterPassword.isEmpty {
                                Button(action: {
                                    self.reenterPassword = ""
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }
                        
                        Text(self.invalidPasswordMatchHintLabel)
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2)
                            .animation(.easeInOut)
                    }
                }
            }
            
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
                                
                                // Account creation was successful
                                isLoading.toggle()
                                buttonLabel = "Account created!"
                                buttonColor = Color.green
                                self.email = ""
                                self.password = ""
                                self.reenterPassword = ""
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    buttonLabel = "Create an account"
                                    buttonColor = Color.blue
                                    buttonDisable.toggle()
                                }
                                print("Successfully created an account.")
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
                .accessibility(label: Text("Create account button"))
                .disabled(buttonDisable)
            }
        }
        .padding(.all)
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

struct CreateUserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserAccountView()
    }
}
