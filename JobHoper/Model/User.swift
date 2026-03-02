//
//  User.swift
//  JobHoper
//
//  Created by Cedrick on 2/22/26.
//

import Foundation

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let createdAt: Date
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
