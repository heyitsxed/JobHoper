//
//  SignUpView.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 33) {
            
            Spacer()
            
            VStack(spacing: 6) {
                Text(StringConstants.createAccount.rawValue)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.blue)
                
                Text(StringConstants.signUpGetStarted.rawValue)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                    
                    TextField(StringConstants.fullName.rawValue, text: $viewModel.newFullName)
                        .autocapitalization(.words)
                    
                    if let fullNameError = viewModel.fullNameError {
                        Text(fullNameError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .modifier(InputFieldStyle())
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    
                    TextField(StringConstants.email.rawValue, text: $viewModel.newEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    if let emailError = viewModel.emailError {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .modifier(InputFieldStyle())
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)
                    
                    SecureField(StringConstants.password.rawValue, text: $viewModel.newPassword)
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .modifier(InputFieldStyle())
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)
                    
                    SecureField(StringConstants.confirmPassword.rawValue, text: $viewModel.confirmPassword)
                    
                    if let confirmPasswordError = viewModel.confirmPasswordError {
                        Text(confirmPasswordError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .modifier(InputFieldStyle())
            }
            
            Button(action: viewModel.signUp) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(StringConstants.createAccount.rawValue)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
            .disabled(viewModel.isLoading)
            
            HStack {
                Text(StringConstants.alreadyHaveAccount.rawValue)
                    .foregroundColor(.gray)
                
                Button(StringConstants.login.rawValue) {
                    dismiss()
                }
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            }
            
            Spacer()
        }
        .alert(isPresented: $viewModel.isSuccessMessage) {
            Alert(title: Text(StringConstants.signupSuccessTitle.rawValue), message: Text(StringConstants.signUpSuccessDecription.rawValue), dismissButton: .default(Text(StringConstants.ok.rawValue)))
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
