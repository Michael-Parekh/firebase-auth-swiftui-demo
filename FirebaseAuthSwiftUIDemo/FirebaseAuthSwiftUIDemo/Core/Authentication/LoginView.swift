//
//  LoginView.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/22/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        // Wrap in a NavigationStack because we want to be able to move between the LoginView and SignUpView.
        NavigationStack {
            VStack {
                // MARK: Image
                Image("hopper-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // MARK: Form Fields
                
                // MARK: Sign In Button
                
                Spacer()
                
                // MARK: Sign Up Button
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
