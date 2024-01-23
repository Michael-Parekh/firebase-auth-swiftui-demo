//
//  AuthViewModel.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/23/24.
//

import Foundation
import Firebase

// Responsible for functionality associated with authenticating users (making the network calls) + updating the UI as needed.
// Conforms to the ObservableObject protocol so that our view will be able to observe changes on AuthViewModel.
class AuthViewModel: ObservableObject {
    // Tells us whether there is a user currently logged in (so that the app knows whether to route us to the Login flow or Profile flow).
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    // `async throws` indicates that the asynchronous function can also throw errors.
    func signIn(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    // Fetch the current User object.
    func fetchUser() async {
        
    }
}

