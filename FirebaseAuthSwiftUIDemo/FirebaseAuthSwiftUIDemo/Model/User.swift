//
//  User.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/22/24.
//

import Foundation

// For any app that requires authentication, we need to create a data model representing a User object.
// The Codable protocol allows us to encode/decode User object data so that it can be stored in Firestore. 
struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    // Convert the 'fullname' property into initials for the ProfileView.
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Michael Parekh", email: "test@gmail.com")
}
