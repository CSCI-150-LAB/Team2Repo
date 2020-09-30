//
//  ForgotPasswordView.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 9/29/20.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var email : String = ""
    @State var invalidEmailHintLabel : String = ""
    
    var body: some View {
        VStack() {
            Section() {
                Text("Don't sweat it! It happens to every one of us.\nEnter your email address to reset your password.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 15)
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
                Button(action: {
                    if (!self.email.isEmpty) {
                        
                    }
                    else {
                        self.invalidEmailHintLabel = "Please enter an email address"
                    }
                }) {
                    HStack {
                        Spacer()
                            Text("Send link")
                                .font(.headline)
                                .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.vertical, 15.0)
                .background(Color.blue)
                .padding(.horizontal, 130.0)
                .cornerRadius(4.0)
                .accessibility(label: Text("Send password reset link"))
            }
        }
        .padding(.all)
        .navigationTitle("Forgot Password")
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
