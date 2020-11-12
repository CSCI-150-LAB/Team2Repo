//
//  CustomerSignUpView.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 11/6/20.
//

import SwiftUI

struct CustomerSignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var form = SignUpViewModel(formModel: FormModel(email: "", password: ""), type: "customer")
    
    @State private var showPassword: Bool = false
    @State private var showReenterPassword: Bool = false
    @State private var isClicked: Bool = false
    
    func signUpUser() {
        self.isClicked.toggle()
        self.form.signUpAction()
        self.isClicked.toggle()
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text("Finding food trucks never been so easy. Sign up today!")
                    .font(.system(size: 14))
                    .padding(.bottom, 18)
                
                Section() {
                    Group {
                        Text("First Name")
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$form.firstName)
                                .keyboardType(.alphabet)
                                .autocapitalization(.none)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)

                            if !self.form.email.isEmpty {
                                Button(action: {
                                    self.form.firstName = ""
                                    self.form.setFirstName("")
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }
                        .padding(.vertical, 0)
                        .padding(.bottom, 14)
                        
                        Text("Last Name")
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$form.lastName)
                                .keyboardType(.alphabet)
                                .autocapitalization(.none)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)

                            if !self.form.lastName.isEmpty {
                                Button(action: {
                                    self.form.lastName = ""
                                    self.form.setLastName("")
                                }) {
                                    Image(systemName: "multiply").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }
                        }
                        .padding(.vertical, 0)
                        .padding(.bottom, 14)
                    }
                    
                    Group {
                        Group {
                            Text("Email Address")
                            ZStack(alignment: .trailing) {
                                TextField("", text: self.$form.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding(.all)
                                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                    .cornerRadius(5)

                                if (!self.form.email.isEmpty) {
                                    Button(action: {
                                        self.form.email = ""
                                        self.form.setEmail("")
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
                        
                        Group {
                            Text("Password")
                            ZStack(alignment: .trailing) {
                                if (showPassword) {
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
                                    self.showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }.padding(.vertical, 0)

                            if(self.form.getPasswordHintLabel().isEmpty) {
                                Text("7+ Characters, 1 Capital Letter, 1 Special Character")
                                    .font(.system(size: 14))
                                    .opacity(0.5)
                            }
                            
                            Text(self.form.getPasswordHintLabel())
                                .font(.system(size: 14))
                                .foregroundColor(Color.red)
                                .padding(.bottom, 2.0)
                                .fixedSize(horizontal: false, vertical: true)
                                .animation(.easeInOut)
                            
                            Text("Confirm Password")
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
                                    self.showReenterPassword.toggle()
                                }) {
                                    Image(systemName: showReenterPassword ? "eye.slash.fill" : "eye.fill").foregroundColor(Color(UIColor.opaqueSeparator))
                                }.padding(.trailing, 20)
                            }.padding(.vertical, 0)

                            if (self.form.getPasswordRetypedHintLabel().isEmpty) {
                                Text("Both passwords must match")
                                    .font(.system(size: 14))
                                    .opacity(0.5)
                            }
                            
                            Text(self.form.getPasswordRetypedHintLabel())
                                .font(.system(size: 14))
                                .foregroundColor(Color.red)
                                .padding(.bottom, 2)
                                .animation(.easeInOut)
                        }
                    }
                }

                if(!self.isClicked) {
                    DefaultButton(label: "Create account", function: self.signUpUser)
                }
            }.padding(.horizontal, 22)
        }
        .navigationTitle(("Customer Registration"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.form.resetForm()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Account")
            }
        })
    }
}
