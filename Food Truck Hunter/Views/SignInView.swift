import SwiftUI
import GoogleSignIn

func doNothing() {}

struct SignInView: View {
    @EnvironmentObject var authState: AuthenticationState
    @ObservedObject var form = SignInViewModel(formModel: FormModel(email: "", password: ""))
    
    @State var successfulLogin: Int? = nil
    @State var invalidEmailHintLabel : String = ""
    @State var invalidCredentialHintLabel : String = ""
    @State var isClicked: Bool = false
    
    func signInUser() {
        self.isClicked.toggle()
        self.form.signInAction()
        self.isClicked.toggle()
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
                                    TextField("Email Address", text: self.$form.email)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .padding(.all)
                                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                        .cornerRadius(6)
                                }
                                .padding(.bottom, 5)
                            }
                            
                            Section() {
                                HStack {
                                    SecureField("Password", text: self.$form.password)
                                        .autocapitalization(.none)
                                        .padding(.all)
                                        .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                        .cornerRadius(6)
                                }
                                HStack {
                                    Text(self.form.getPasswordHintLabel())  // Debug this...Message not showing
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.red)
                                        .padding(.bottom, 2.0)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .animation(.easeInOut)
                                    Spacer()
                                }
                            }
                        }.padding(.all)
                        VStack(alignment:.center){
                            NavigationLink(destination: ForgotPasswordView()) {
                                Text("Forgot password?")
                                    .font(.headline)
                                    .foregroundColor(Color.red)
                                    .padding(.bottom,15)
                           }
                        }.padding(.top,-20)
                    }//.padding(.all)
                    
                    // MARK: Log In Section
                    Section() {
                        if (!self.isClicked) {
                            DefaultButton(label: "Sign in", function: self.signInUser)
                        }
    //                    DefaultButton(label: "Continue with Google", function: doNothing)     // Leave this out for now
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up")
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
} // MARK: View End
}
