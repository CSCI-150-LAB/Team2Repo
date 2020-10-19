import SwiftUI
import Firebase
import FirebaseAuth

public var count = 0

struct CreateUserAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var form = CreateUserAccountViewModel(createUserAccountModel: FormModel(email: "", password: ""))

//    @State private var buttonLabel : String = "Create an account"
//    @State private var buttonColor : Color = Color.blue
//    private var buttonDisable : Bool = false;
    
    // used for animating loading circle
//    @State private var isLoading : Bool = false
//    @State private var isRotating : Bool = false
//    @State private var animateStrokeStart : Bool = false
//    @State private var animateStrokeEnd : Bool = true

    @State private var showPassword : Bool = false
    @State private var showReenterPassword : Bool = false
    
    var body: some View {
        ScrollView() {
            Section() {
                VStack(alignment: .leading) {
                    Section() {
                        Text("First Name").padding(.bottom, 0)
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$form.firstName)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                            
                            if !(self.form.getFirstName().isEmpty) {
                                Button(action: {
                                    self.form.setFirstName("")
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }.padding(.bottom, 14)
                    }
                    
                    Section() {
                        Text("Last Name").padding(.bottom, 0)
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$form.lastName)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                            
                            if !self.form.lastName.isEmpty {
                                Button(action: {
                                    self.form.setLastName("")
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }.padding(.bottom, 14)
                    }
                    
                    Section() {
                        Text("Email Address")
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$form.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                            
                            if !self.form.email.isEmpty {
                                Button(action: {
                                    self.form.email = ""
                                    self.form.setEmail(self.form.email)
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }.padding(.vertical, 0)
                        
                        Text(self.form.getEmailHintLabel())
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2.0)
                            .animation(.easeInOut)
                    }

                    Section() {
                        Text("Password")
                        ZStack(alignment: .trailing) {
                            if showPassword {
                                TextField("", text: self.$form.password)
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            else {
                                SecureField("", text: self.$form.password)
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
                        
                        Text(self.form.getPasswordHintLabel())
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2.0)
                            .fixedSize(horizontal: false, vertical: true)
                            .animation(.easeInOut)
                    }
                    
                    Section() {
                        Text("Retype Password")
                        ZStack(alignment: .trailing) {
                            if showReenterPassword {
                                TextField("", text: self.$form.retypedPassword)
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)
                            }
                            else {
                                SecureField("", text: self.$form.retypedPassword)
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
                        
                        Text(self.form.getPasswordRetypedHintLabel())
                            .font(.system(size: 14))
                            .foregroundColor(Color.red)
                            .padding(.bottom, 2)
                            .animation(.easeInOut)
                    }
                }
            }.padding(.horizontal)
            
            Section() {
                DefaultButton(label: "Create Account", function: self.form.createAccount)
            }
        }
        .navigationTitle("Create an Account")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.form.resetForm()
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

//struct CreateUserAccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateUserAccountView(user: UsersViewModel)
//    }
//}
