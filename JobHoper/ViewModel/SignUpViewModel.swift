//
//  SignUpViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 2/22/26.
//

import Combine
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var newFirstName = ""
    @Published var newLastName = ""
    @Published var newEmail = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    
    @Published var isLoading: Bool = false
    @Published var isSuccessMessage: Bool = false
    @Published var isValidatingUser: Bool = false
    
    var isFullNameValid: Bool { !newFirstName.isEmpty && newFirstName.count > 2 && !newLastName.isEmpty && newLastName.count > 2 }
    var isPasswordValid: Bool { !newPassword.isEmpty && newPassword == confirmPassword }
    
    var isEmailValid: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: newEmail)
    }

    var fullNameError: String? {
        guard isValidatingUser else { return nil }
        if !isFullNameValid { return StringConstants.enterValidFullName.rawValue }
        return nil
    }
    
    var emailError: String? {
        guard isValidatingUser else { return nil }
        if newEmail.isEmpty { return "Email cannot be empty" }
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: newEmail) {
            return StringConstants.enterValidEmail.rawValue
        }
        return nil
    }
    
    var passwordError: String? {
        guard isValidatingUser else { return nil }
        if newPassword.isEmpty { return StringConstants.passwordCannotBeEmpty.rawValue }
        return nil
    }
    
    var confirmPasswordError: String? {
        guard isValidatingUser else { return nil }
        if newPassword != confirmPassword { return StringConstants.passwordNotMatch.rawValue }
        return nil
    }
    
    func signUp() {
        isLoading = true
        isValidatingUser = true
        
        guard isFullNameValid && isEmailValid && isPasswordValid else {
            isLoading = false
            return
        }
        
        let workItem = DispatchWorkItem {
            AppSessionManager.shared.signUp(firstName: self.newFirstName, lastName: self.newLastName, email: self.newEmail, password: self.newPassword)
            self.isSuccessMessage = true
            self.isLoading = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
}
