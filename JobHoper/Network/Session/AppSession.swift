//
//  AppSession.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

class AppSession {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userName") var userName: String = ""
    
    static let shared = AppSession()

    private init() {}
    
    func login(user: String) {
        userName = user
        isLoggedIn = true
    }
    
    func logout() {
        userName = ""
        isLoggedIn = false
        
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userName")
    }
}
