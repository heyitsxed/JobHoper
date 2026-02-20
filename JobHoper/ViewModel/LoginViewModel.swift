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
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var fullName = ""
    @Published var errorMessage: String = ""
    @Published var isShowErrorMessage: Bool = false
    
    func login() {
        isLoading = true
        isLoggedIn = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(self.email, forKey: "email")
            
            print("Login tapped:", self.email, self.password)
        }
    }
    
    func signUp() {
        guard password == confirmPassword else {
            print("Passwords do not match")
            errorMessage = "Passwords do not match"
            isShowErrorMessage = true
            return
        }

        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            print("Sign Up:", self.fullName, self.email)
        }
    }

}
