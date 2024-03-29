//
//  AuthViewModel.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/23/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// Responsible for functionality associated with authenticating users (making the network calls) + updating the UI as needed.
// Conforms to the ObservableObject protocol so that our view will be able to observe changes on AuthViewModel.

// Everywhere we have a form, we need to conform to AuthenticationFormProtocol and implement the logic for whether that form is valid.
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

// We need to publish all UI updates back on the main thread (by default, all of the asynchronous networking events happens on background threads).
@MainActor
class AuthViewModel: ObservableObject {
    // Tells us whether there is a user currently logged in (so that the app knows whether to route us to the Login flow or Profile flow).
    // Because it's a Published property, it will send a notification to ContentView to reconfigure when the value is changed.
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        // When the AuthViewModel initializes, it will check if there is already a logged in user.
        self.userSession = Auth.auth().currentUser
        
        // Try to fetch the current User right away.
        Task {
            await fetchUser()
        }
    }
    
    // `async throws` indicates that the asynchronous function can also throw errors.
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // Setting the 'userSession' redirects us to ProfileView.
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            // 'try await' eliminates the need for us to use completion blocks and handlers.
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            // Note that our User object has additional properties like email address - the Firebase user object is just the generic user object that Firebase creates on the backend.
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            // Store the encoded User object in Firestore.
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            // Fetch the User data that we just created so that it can be displayed in ProfileView.
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            // Signs out user on the Firebase backend.
            try Auth.auth().signOut()
            // Wipes out user session and takes us back to LoginView because presentation logic in ContentView is dependent on 'userSession'.
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    // Fetch the User object from Firestore for the currently logged in user.
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}

