import SwiftUI
import Firebase
import FirebaseFirestore
import GoogleSignIn

struct ContentView: View {

    @State private var emailEnter = ""
    @State private var passwordEnter = ""
    @State var successfulLogin: Int? = nil
    @State var invalidEmailHintLabel : String = ""
    @State var invalidCredentialHintLabel : String = ""
    
    @ObservedObject var userLoginModel = LoginViewModel(loginModel: FormModel(email: "", password: ""))
    
    // MARK: View Start
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack {
                    // MARK: Logo Section
                    Image("logoPic")
                        .resizable()
                        .frame(width: 310, height: 310, alignment: .center)
                        .padding(.top,20)
                       // .aspectRatio(contentMode: .fill)
                        
                    
                    //Section() {
                        // Possibly add an icon or image
                       // Text("Food Truck Hunter")
                        //    .font(.system(.largeTitle, design: .rounded))
                        //    .fontWeight(.bold)
                        // }
                    // MARK: Input Fields Section
                    Section() {
                        VStack(alignment: .center) {
                            Section() {
                                HStack {
                                    TextField("Email Address", text: self.$emailEnter)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .padding(.all)
                                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                        .cornerRadius(6)
                                }
                                
                                Text(self.userLoginModel.getEmailHintLabel())
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.red)
                                    .padding(.bottom, 2.0)
                                    .animation(.easeInOut)
                            }
                            
                            Section() {
                                HStack {
                                    SecureField("Password", text: self.$passwordEnter)
                                        .autocapitalization(.none)
                                        .padding(.all)
                                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                        .cornerRadius(6)
                                }
                                
                                Text(self.userLoginModel.getPasswordHintLabel())
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.red)
                                    .padding(.bottom, 1)
                                    .animation(.easeInOut)
                            }

                            
                            Section() {
                                HStack() {
                                    Spacer()
                                    NavigationLink(destination: ForgotPasswordView()) {
                                        Text("Forgot password?").font(.headline)
                                        .foregroundColor(Color.red)
                                                                                   
                                   }
                                }
                            }
                        }
                    }.padding(.all)
                
                // MARK: Log In Section
                Section() {
                    NavigationLink(destination: LandingView(),tag: 1, selection: self.$successfulLogin) {
//                        DefaultButton(label: "Log In", function: userLoginModel.logIn(emailEnter, passwordEnter, self.&successfulLogin), returnValue: true, buttonColor:Color.Red)
//
                        Button(action: {
//                             Check input fields to see if empty
                            if (!self.emailEnter.isEmpty && !self.passwordEnter.isEmpty) {
                                if true {//FormUtilities.validateEmail(self.emailEnter) {

                                    self.invalidEmailHintLabel = ""

                                    // MARK: Firebase Auth
                                    Auth.auth().signIn(withEmail: self.emailEnter, password: self.passwordEnter, completion: {result, error in
                                        // Unsuccessful
                                        guard error == nil else {
                                            print("Cannot sign in")
                                            self.invalidCredentialHintLabel = "Email or password is incorrect."
                                            return
                                        }

                                        // Successfully logged in
                                        // Reset all fields
                                        self.emailEnter = ""
                                        self.passwordEnter = ""
                                        self.successfulLogin = 1
                                        self.invalidCredentialHintLabel = ""
                                        print("Successfully signed in")
                                    })
                                }
                                else {
                                    self.invalidCredentialHintLabel = ""
//                                    self.invalidEmailHintLabel = FormUtilities.validateEmailErrorMsg(self.email)
                                }
                            }
                            else {
//                                self.invalidEmailHintLabel = FormUtilities.isEmptyErrorMsg(self.email, "email")
//                                self.invalidCredentialHintLabel = FormUtilities.isEmptyErrorMsg(self.password, "password")
                            }
                        }) {
                            HStack {
                                Spacer()
                                    Text("Log In")
                                        .font(.headline)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .foregroundColor(Color.red)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6.0)
                                                .stroke(Color.red, lineWidth: 2)
                                        )
                                Spacer()
                            }
                        }
                        .accessibility(label: Text("Log in"))
                        .padding(.horizontal, 40)
                    }

                        
                    Text("or")
                        .padding(.vertical, 1)
                        .foregroundColor(Color.black)
                                        
                    Button(action: {}) {
                        Text("Continue with Google")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.red)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 40)
                    
                    Button(action: {}) {
                        Text("Continue with Apple")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.red)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 40)
                    
                    NavigationLink(destination: CreateAccountView()) {
                        Text("Create an account")
                            .font(.headline)
                            .foregroundColor(Color.red)
                    }
                }
                .padding(.bottom,20)
              } // end v stack
            }   // end scroll view
            .background(Color(UIColor(red: 0.15, green: 0.80, blue: 0.97, alpha: 1.00)))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            
        }
    }
}
// MARK: View End

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
