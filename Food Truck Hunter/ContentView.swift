//
//  ContentView.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 9/27/20.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import ObjectMapper

struct User: Identifiable, Codable {
    var default_location: String?
    var email: String?
    var first_name: String?
    var id: Int?
    var last_name: String?
    var password: String?
    var type: String?
    
    init(default_location: String?, email: String?, first_name: String?, id: Int?, last_name: String?, password: String?, type: String?) {
        self.default_location = default_location
        self.email = email
        self.first_name = first_name
        self.id = id
        self.last_name = last_name
        self.password = password
        self.type = type
    }
}

class Login: ObservableObject {
    
    @Published var msg = "Initialized"
    
    @Published var users = [ User ]()
    
    func getData() {
        let db = Firestore.firestore()
        let dispatch = DispatchGroup()
        
        dispatch.enter()
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.users.append(User(default_location: (document.data()["default_location"] as! String), email: (document.data()["email"] as! String), first_name: (document.data()["first_name"] as! String), id: (document.data()["id"] as? Int), last_name: (document.data()["last_name"] as! String), password: (document.data()["password"] as! String), type: (document.data()["type"] as! String)))
                    print("user: \(self.users.count)")
                }
            }
            dispatch.leave()
            self.msg = ""
        }
        dispatch.notify(queue: .main, execute: {
            print("number of users: \(self.users.count)")
        })
    }
}

struct ContentView: View {
    @ObservedObject var loginData = Login()
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
//            ScrollView {
//                Text(loginData.msg)
//
//                ForEach(loginData.users) { user in
//                    Text( "Name: \(user.first_name!) \(user.last_name!)" )
//                    Text( "Email: \(user.email!)" )
//                    Text( "Type: \(user.type!)" )
//                }
//            }.navigationTitle("Firestore Data")
//            .navigationBarItems(trailing: Button(action: {
//                print("Fetching data...")
//                self.loginData.getData()
//            }, label: {
//                Text("Get Data")
//            }))
            ScrollView {
                Section() {
                    VStack {
                        Text("Food Truck Hunter").font(.title)
                    }
                }
                Section() {
                    VStack(alignment: .leading) {
                        Text("Email").font(.headline)
                        HStack {
                            TextField("example@mail.fresnostate.edu", text: self.$email)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                        }
                        
                        Text("Password").font(.headline)
                        HStack {
                            SecureField("●●●●●●●●●●●●", text: self.$password)
                                .padding(.all)
                                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                                .cornerRadius(5)
                        }
                    }.padding(.all)
                }
                
                Section() {
                    Button(action: {
                    }) {
                        HStack {
                            Spacer()
                                Text("Sign in")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 15.0)
                    .background(Color.blue)
                    .padding(.horizontal, 50.0)
                    .cornerRadius(4.0)
                    
                    HStack {
                        Text("Need an account?")
                        Button(action: {}) {
                            Text("Sign up").font(.headline)
                        }
                    }
                    
                    Text("Login with:")
                        .padding(.vertical, 8.0)
                    
                    Button(action: {}) {
                        Text("Google").font(.headline)
                    }.padding(.vertical, 3.0)
                    
                    Button(action: {}) {
                        Text("Facebook").font(.headline)
                    }.padding(.vertical, 3.0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
