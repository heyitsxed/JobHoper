//
//  ForgotPasswordViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 3/5/26.
//

import Combine

class ForgotPasswordViewModel: ObservableObject {
    @Published var forgotEmail: String = ""
    @Published var newPassword: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isUserFound: Bool = false
    
    private var users = AppSessionManager.shared.users

    func checkEmail() {
        let resetUser = users.contains { user in
            user.email == forgotEmail
        }
        
        isUserFound = resetUser == true ? true : false
    }
    
    func resetPassword() {
        guard let index = users.firstIndex(where: { $0.email == forgotEmail }) else { return }
        
        var updatedUser = users
        updatedUser[index].password = newPassword
        AppSessionManager.shared.users = updatedUser
    }

}
