//
//  AppSession.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI
import Combine

class AppSessionManager {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("users") private var usersData: Data = Data()
    
    @Published private var currentUser: User?
    
    var users: [User] {
        get {
            (try? JSONDecoder().decode([User].self, from: usersData)) ?? []
        }
        
        set {
            usersData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
    
    static let shared = AppSessionManager()

    private init() {}
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
    
    func signIn() {
        isLoggedIn = true
    }
    
    func signUp(fullname: String, email: String, password: String) {
        if users.contains(where: {$0.email == email }) {
            return
        }
        
        let newUser = User(fullName: fullname, email: email, password: password)
        var updatedUsers = users
        updatedUsers.append(newUser)
        users = updatedUsers
        
        currentUser = newUser
    }
}
