//
//  SignUpView.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = LoginViewModel()
    
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

                    TextField(StringConstants.fullName.rawValue, text: $viewModel.fullName)
                        .autocapitalization(.words)
                }
                .modifier(InputFieldStyle())

                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)

                    TextField(StringConstants.email.rawValue, text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .modifier(InputFieldStyle())

                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)

                    SecureField(StringConstants.password.rawValue, text: $viewModel.password)
                }
                .modifier(InputFieldStyle())

                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)

                    SecureField(StringConstants.confirmPassword.rawValue, text: $viewModel.confirmPassword)
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
        .alert(isPresented: $viewModel.isShowErrorMessage) {
            Alert(title: Text("Login Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
    }

}


#Preview {
    SignUpView()
}
