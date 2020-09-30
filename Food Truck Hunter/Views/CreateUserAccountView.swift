//
//  CreateUserAccountView.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 9/29/20.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct CreateUserAccountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var email : String = ""
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
                        Text("Email Address")
                        ZStack(alignment: .trailing) {
                            TextField("user@foodtruckhunter.com", text: self.$email, onEditingChanged: {_ in
                                if !self.email.isEmpty {
                                    self.invalidEmailHintLabel = FormUtilities.validateEmail(self.email) ? "" : "Invalid email address"
                                }
                            })
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
                        Text("Password")
                        ZStack(alignment: .trailing) {
                            SecureField("1SuperUncrackablePassword!", text: self.$password)
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
                        Text("Re-enter Password")
                        ZStack(alignment: .trailing) {
                            SecureField("1SuperUncrackablePassword!", text: self.$reenterPassword)
                                .onChange(of: self.reenterPassword) { newRetypedPassword in
                                    self.reenterPassword = newRetypedPassword
                                    
                                    if self.reenterPassword.isEmpty {
                                        self.invalidPasswordMatchHintLabel = ""
                                    }
                                    else {
                                        self.invalidPasswordMatchHintLabel = (self.password == self.reenterPassword) ? "" : "Password does not match"
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
                            .padding(.bottom, 2.0)
                            .animation(.easeInOut)
                    }
                }
            }
            
            Section() {
                Button(action: {
                    if ((!self.email.isEmpty && !self.password.isEmpty) && !self.reenterPassword.isEmpty) {
                        if FormUtilities.validateEmail(self.email) && FormUtilities.validatePassword(self.password) && (self.password == self.reenterPassword) {
                            Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                                // An error occurred
                                guard error == nil else {
                                    print("Unsuccessfully created an account")
                                    return;
                                }
                                
                                // Account creation was successful
                                self.email = ""
                                self.password = ""
                                self.reenterPassword = ""
                                print("Successfully created an account")
                            }
                        }
                    }
                    else {
                        self.invalidEmailHintLabel = self.email.isEmpty ? "Please enter an email address" : ""
                        self.invalidPasswordHintLabel = self.password.isEmpty ? "Please enter a password" : ""
                        self.invalidPasswordMatchHintLabel = self.reenterPassword.isEmpty ? "Please re-enter the password" : ""
                    }
                }) {
                    HStack {
                        Spacer()
                            Text("Create an account")
                                .font(.headline)
                                .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.vertical, 15.0)
                .background(Color.blue)
                .padding(.horizontal, 100.0)
                .cornerRadius(4.0)
                .accessibility(label: Text("Create account button"))
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
