//
//  SignupView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/13/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var fullName: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(){
            Image("snapitlogo")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .padding(.vertical, 32)
            
            Text("Create an Account")
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .opacity(0.9)
                .font(.system(size: 40))
            
            VStack(spacing: 24) {
                InputView(text: $email, title: "Email Address")
                    .autocapitalization(.none)
                
                InputView(text: $fullName, title: "Full Name")
                
                InputView(text: $password, title: "Password", isSecureField: true)
                    .autocapitalization(.none)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Confirm Password", isSecureField: true)
                        .autocapitalization(.none)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                }
            } label: {
                HStack {
                    Text("Sign Up")
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
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 5) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 16))
            }
        }
    }
}

// Mark: - AuthenticationFormProtocol

extension SignupView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    SignupView()
}

//TextField("Enter your email", text: $email)
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(10)
//                .keyboardType(.emailAddress)  // Email keyboard
//                .autocapitalization(.none)    // Disable automatic capitalization
//                .padding(.horizontal, 20)
