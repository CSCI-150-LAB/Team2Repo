//
//  LoginView.swift
//  Food Truck Hunter
//
//  Created by Preston McCullough on 9/24/20.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "envelope").foregroundColor(.gray)
                TextField("Email",text: $email)
            }
            .padding(.horizontal, 20).padding(.top,20)
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(Color.gray)
            
            HStack {
                Image(systemName: "lock").foregroundColor(.gray)
                SecureField("Password",text: $password)
            }.padding(.horizontal, 20).padding(.top,20)
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 30)
             .background(Color.gray)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Login")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView().previewDevice("iPhone 8")
            LoginView().previewDevice("iPhone X")
            LoginView().previewDevice("iPhone 11 Pro Max")
        }
    }
}
