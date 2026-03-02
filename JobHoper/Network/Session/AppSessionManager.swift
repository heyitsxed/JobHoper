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
    
    var fullName: String? {
        get {
            return UserDefaults.standard.string(forKey: "fullName")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fullName")
            UserDefaults.standard.synchronize()
        }
    }
    
    var emailDisplay: String? {
        get {
            return UserDefaults.standard.string(forKey: "email")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
            UserDefaults.standard.synchronize()
        }
    }
    
    var users: [User] {
        get {
            (try? JSONDecoder().decode([User].self, from: usersData)) ?? []
        }
        
        set {
            usersData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
    
    var joined: String? {
        get {
            return UserDefaults.standard.string(forKey: "joined")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "joined")
            UserDefaults.standard.synchronize()
        }
    }
    
    var position: String? {
        get {
            return UserDefaults.standard.string(forKey: "position")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "position")
            UserDefaults.standard.synchronize()
        }
    }
    
    var location: String? {
        get {
            return UserDefaults.standard.string(forKey: "location")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "location")
            UserDefaults.standard.synchronize()
        }
    }
    
    var phone: String? {
        get {
            return UserDefaults.standard.string(forKey: "phone")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "phone")
            UserDefaults.standard.synchronize()
        }
    }
    
    static let shared = AppSessionManager()
    
    private init() {}
    
    func logout() {
        fullName = nil
        emailDisplay = nil
        joined = nil
        currentUser = nil
        isLoggedIn = false
    }
    
    func signIn(user: User) {
        currentUser = user
        fullName = user.fullName
        emailDisplay = user.email
        joined = formattedDate(user.createdAt)
        isLoggedIn = true
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String) {
        if users.contains(where: {$0.email == email }) {
            return
        }
        
        let newUser = User(id: UUID().uuidString, firstName: firstName, lastName: lastName, email: email, password: password, createdAt: Date())
        var updatedUsers = users
        updatedUsers.append(newUser)
        users = updatedUsers
        
        fullName = newUser.fullName
        emailDisplay = newUser.email
        joined = formattedDate(newUser.createdAt)
        
        currentUser = newUser
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
