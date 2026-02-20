//
//  LoginViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var fullName = ""
    @Published var newEmail = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    
    @Published var isLoading = false
    @Published var isLoggedIn = false
    
    @Published var errorMessage: String = ""
    @Published var isShowErrorMessage: Bool = false
    
    func login() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard self.email == AppSession.shared.email && self.password == AppSession.shared.password else {
                self.isShowErrorMessage = true
                self.errorMessage = "Incorrect Username or Password"
                return
            }
            
            AppSession.shared.login(user: self.email, password: self.password)
        }
        
        self.isLoading = false
    }
    
    func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            isShowErrorMessage = true
            return
        }

        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            AppSession.shared.signUp(email: self.email, password: self.password)
            AppSession.shared.fullName = self.fullName
            print("xxx Sign Up:", self.fullName, self.email)
        }
    }

}
