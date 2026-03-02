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
        AppSessionManager.shared.users.contains(where: { $0.email == currentEmail && $0.password == currentPassword })
    }
    
    func login() {
        isLoading = true
        
        guard isExistingUser else {
            isShowErrorMessage = true
            isLoading = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let user = AppSessionManager.shared.users.first(where: { $0.email == self.currentEmail }) {
                AppSessionManager.shared.signIn(user: user)
            }
            self.isLoading = false
            
        }
    }
}
