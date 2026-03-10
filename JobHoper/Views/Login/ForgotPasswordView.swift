//
//  ForgotPasswordView.swift
//  JobHoper
//
//  Created by Cedrick on 3/5/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 10) {
            
            Spacer()
            
            Text(StringConstants.forgotPasswordTitle.rawValue)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)
                .padding(.bottom, 110)
            
            
            VStack(spacing: 15) {
                HStack {
                    Text(StringConstants.emailAddress.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                TextField("", text: $viewModel.forgotEmail, prompt: Text(StringConstants.email.rawValue).foregroundColor(.black))
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                    .modifier(InputFieldStyle())
                
                if viewModel.isUserFound {
                    TextField(StringConstants.enterNewPassword.rawValue, text: $viewModel.newPassword)
                        .textInputAutocapitalization(.never)
                        .modifier(InputFieldStyle())
                }
                
                Button(action: viewModel.isUserFound ? viewModel.resetPassword : viewModel.checkEmail) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text(viewModel.isUserFound ? StringConstants.resetPassword.rawValue : StringConstants.checkEmail.rawValue)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 20)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                .disabled(viewModel.isLoading)
                .padding(.top, 10)
                
                Text(StringConstants.backToSignIn.rawValue)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 120)

            
            Spacer()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
