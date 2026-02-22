//
//  LoginView.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    @State private var isShowSignUp: Bool = false
    
    var body: some View {
        VStack(spacing: 68) {
            
            Spacer()

            VStack(spacing: 6) {
                Text(StringConstants.welcomeUser.rawValue)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.blue)

                Text(StringConstants.loginToYourAccount.rawValue)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }

            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)

                    TextField(StringConstants.email.rawValue, text: $viewModel.currentEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .modifier(InputFieldStyle())
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)

                    SecureField(StringConstants.password.rawValue, text: $viewModel.currentPassword)
                }
                .modifier(InputFieldStyle())
                
                HStack {
                    Spacer()
                    
                    Text(StringConstants.forgotPassword.rawValue)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .onTapGesture {
                            print("Forgot password")
                        }
                }
            }

            Button(action: viewModel.login) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(StringConstants.login.rawValue)
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

            HStack {
                Text(StringConstants.dontHaveAccount.rawValue)
                    .foregroundColor(.gray)

                Button(StringConstants.signUp.rawValue) {
                    isShowSignUp = true
                }
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            }

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $isShowSignUp) {
            SignUpView()
        }
        .alert(isPresented: $viewModel.isShowErrorMessage) {
            Alert(title: Text(StringConstants.loginFailedTitle.rawValue), message: Text(StringConstants.loginFailedDescription.rawValue), dismissButton: .default(Text(StringConstants.ok.rawValue)))
        }
    }
}

struct InputFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(14)
            .background(.white)
            .cornerRadius(12)
            .shadow(radius: 3)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.blue, lineWidth: 1)
            }
    }
}

#Preview {
    LoginView()
}
