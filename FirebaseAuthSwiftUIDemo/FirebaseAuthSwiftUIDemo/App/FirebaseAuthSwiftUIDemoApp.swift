//
//  FirebaseAuthSwiftUIDemoApp.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/22/24.
//

import SwiftUI

@main
struct FirebaseAuthSwiftUIDemoApp: App {
    
    // Use an EnvironmentObject to represent AuthViewModel instead of instantiating multiple StateObjects.
    // EnvironmentObjects get initialized in one place and can be used across multiple surfaces in the app (because we need to access AuthViewModel in LoginView, RegistrationView, ProfileView, and ContentView).
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
