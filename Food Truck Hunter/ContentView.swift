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
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        default_location    <- map["default_location"]
//        email               <- map["email"]
//        first_name          <- map["first_name"]
//        id                  <- map["id"]
//        last_name           <- map["last_name"]
//        password            <- map["password"]
//        type                <- map["type"]
//    }
}

class LoginView: ObservableObject {
    
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
    @ObservedObject var loginData = LoginView()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(loginData.msg)
                
                ForEach(loginData.users) { user in
                    Text(user.first_name ?? "Uh oh")
                }
            }.navigationTitle("Firestore Data")
            .navigationBarItems(trailing: Button(action: {
                print("Fetching data...")
                self.loginData.getData()
            }, label: {
                Text("Get Data")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
