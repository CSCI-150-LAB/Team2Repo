//
//  UsersViewModel.swift
//  Food Truck Hunter
//
//  Created by Sue Vang on 9/29/20.
//

import Foundation
import Firebase
import FirebaseFirestore

final class UsersViewModel: ObservableObject {
    
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
