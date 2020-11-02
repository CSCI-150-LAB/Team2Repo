import SwiftUI
import Firebase
import FirebaseFirestore
import GoogleSignIn

struct SignInView: View {

    @State private var emailEnter = ""
    @State private var passwordEnter = ""
    @State var successfulLogin: Int? = nil
    @State var invalidEmailHintLabel : String = ""
    @State var invalidCredentialHintLabel : String = ""
    @State var loading = false
    @State var error = false
    
    @ObservedObject var userLoginModel = LoginViewModel(loginModel: FormModel(email: "", password: ""))
    @EnvironmentObject var authState: AuthenticationState
    
    func signIn() {
        loading = true
        error = false
        authState.signIn(email: emailEnter, password: passwordEnter) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            }
            else {
                print("signing in...")
                self.emailEnter = ""
                self.passwordEnter = ""
            }
        }
    }
    
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
                    DefaultButton(label: "Login", function: signIn)
                        
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
