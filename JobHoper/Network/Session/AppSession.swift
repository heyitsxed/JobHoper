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
    @AppStorage("email") var email: String = ""
    @AppStorage("password") var password: String = ""
    
    static let shared = AppSession()

    private init() {}
    
    func login(user: String, password: String) {
        email = user
        self.password = password
        isLoggedIn = true
    }
    
    func logout() {
        email = ""
        password = ""
        isLoggedIn = false
    }
    
    func signUp(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
