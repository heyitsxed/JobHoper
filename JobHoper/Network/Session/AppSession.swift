//
//  AppSession.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

class AppSession {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("fullName") var fullName: String = ""
    @AppStorage("email") var existingEmail: String = ""
    @AppStorage("password") var existingPassword: String = ""
    
    static let shared = AppSession()

    private init() {}
    
    func logout() {
        existingEmail = ""
        existingPassword = ""
        isLoggedIn = false
    }
    
    func signUp(email: String, password: String) {
        self.existingEmail = email
        self.existingPassword = password
    }
}
