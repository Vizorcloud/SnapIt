//
//  LoginView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/13/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("snapitlogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .padding(.vertical, 32)
                
                
                Text("Log In")
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .opacity(0.9)
                    .font(.system(size: 40))
                // forms fields
                
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email Address")
                        .autocapitalization(.none)
                    
                    InputView(text: $password, title: "Password", isSecureField: true)
                        .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                }
                .background(Color(.appYellow))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                // sign up button
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 5) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 16))
                }
            }
        }
    }
}

// Mark: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}


#Preview {
    LoginView()
}
