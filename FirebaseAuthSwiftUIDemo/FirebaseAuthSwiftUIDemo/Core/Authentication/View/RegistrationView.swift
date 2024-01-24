//
//  RegistrationView.swift
//  FirebaseAuthSwiftUIDemo
//
//  Created by Michael Parekh on 1/22/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
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
                InputView(text: $fullname, title: "Full Name", placeholder: "Enter your full name")
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // MARK: Sign Up Button
            Button {
                Task {
                    // Because 'createUser' uses async await, we need to wrap it in a Task.
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemPink))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            // MARK: Sign In Button
            // We do not need a NavigationLink to go back to the LoginView (we just need to dismiss back to the original screen).
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(.pink)
            }
        }
    }
}

// MARK: AuthenticationFormProtocol
extension RegistrationView: AuthenticationFormProtocol {
    // The 'formIsValid' property in AuthViewModel is dependent on these conditions we set.
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
