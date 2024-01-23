//
//  LoginView.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/22/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        // Wrap in a NavigationStack because we want to be able to move between the LoginView and RegistrationView.
        NavigationStack {
            VStack {
                // MARK: Image
                Image("hopper-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // MARK: Form Fields
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email", placeholder: "name@hopper.com")
                        .autocapitalization(.none)
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // MARK: Sign In Button
                Button {
                    Task {
                        // Because 'signIn' uses async await, we need to wrap it in a Task.
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    // This button will have 16 pixels of padding on either side.
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemPink))
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // MARK: Sign Up Button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.pink)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
