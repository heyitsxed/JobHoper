//
//  LoginViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var currentEmail: String = ""
    @Published var currentPassword: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isShowErrorMessage: Bool = false
    
    var isExistingUser: Bool {
        self.currentEmail == AppSession.shared.existingEmail && self.currentPassword == AppSession.shared.existingPassword
    }
    
    func login() {
        isLoading = true
        
        guard isExistingUser else {
            isShowErrorMessage = true
            isLoading = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isLoading = false
        }
    }
}
