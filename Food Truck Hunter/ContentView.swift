import SwiftUI
import Firebase
import FirebaseFirestore
import GoogleSignIn

struct ContentView: View {
    @ObservedObject var loginData = UsersViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State var invalidEmailHintLabel : Bool = false
    @State var invalidCredentialHintLabel : Bool = false
    @State var successful_login: Int? = nil
    // MARK: View Start
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Logo Section
                Section() {
                    // Possibly add an icon or image
                    Text("Food Truck Hunter")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                }
                // MARK: Input Fields Section
                Section() {
                    VStack(alignment: .leading) {
                        Section() {
                            HStack {
                                TextField("Email Address", text: self.$email, onEditingChanged: {_ in
                                    if !self.email.isEmpty {
                                        self.invalidEmailHintLabel = !FormUtilities.validateEmail(self.email)
                                    }
                                    else {
                                        self.invalidEmailHintLabel = false
                                    }
                                })
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            
                            Text("Invalid email address")
                                .font(.system(size: 14))
                                .foregroundColor(Color.red)
                                .padding(.bottom, 2.0)
                                .opacity(FormUtilities.showHintLabel(self.invalidEmailHintLabel))
                        }
                        
                        Section() {
                            HStack {
                                SecureField("Password", text: self.$password)
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            
                            Text("Incorrect email or password")
                                .font(.system(size: 14))
                                .foregroundColor(Color.red)
                                .padding(.bottom, 2.0)
                                .opacity(FormUtilities.showHintLabel(self.invalidCredentialHintLabel))
                        }
                    }.padding(.all)
                }
                // MARK: Log In Section
                Section() {
                    NavigationLink(destination: LandingView(),tag: 1, selection: $successful_login) {
                        Button(action: {
                            // Check input fields to see if empty
                            if (!self.email.isEmpty && !self.password.isEmpty) {
                                if FormUtilities.validateEmail(self.email) {
                                    
                                    self.invalidEmailHintLabel = false
                                    
                                    // MARK: Firebase Auth
                                    Auth.auth().signIn(withEmail: self.email, password: self.password, completion: {result, error in
                                        // Unsuccessful
                                        guard error == nil else {
                                            print("Cannot sign in")
                                            self.invalidCredentialHintLabel = true
                                            return
                                        }
                                        
                                        // Successfully logged in
                                        // Reset all fields
                                        self.email = ""
                                        self.password = ""
                                        self.invalidCredentialHintLabel = false
                                        print("Successfully signed in")
                                        self.successful_login = 1
                                    })
                                }
                                else {
                                    self.invalidCredentialHintLabel = false
                                    self.invalidEmailHintLabel = true
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                    Text("Log In")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                Spacer()
                            }
                        }
                        .padding(.vertical, 15.0)
                        .background(Color.blue)
                        .padding(.horizontal, 130.0)
                        .cornerRadius(4.0)
                        .accessibility(label: Text("Log in"))
                    }
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot password?").font(.headline)
                    }
                    .padding(.vertical, 5.0)
                    
                    Text("or")
                        .padding(.vertical, 10.0)
                        .foregroundColor(Color.gray)
                    
                    NavigationLink(destination: CreateUserAccountView()) {
                        Text("Create an account").font(.headline)
                    }
                    
                    Button(action: {}) {
                        Text("Google").font(.headline)
                    }.padding(.vertical, 3.0)
                    
                    Button(action: {}) {
                        Text("Apple").font(.headline)
                    }.padding(.vertical, 3.0)
                }
            }
        }
    }
}
// MARK: View End

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
